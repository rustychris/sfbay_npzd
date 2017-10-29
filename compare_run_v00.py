import xarray as xr
import numpy as np
from stompy.grid import unstructured_grid
from stompy.spatial import linestring_utils

from stompy import utils
##

dwaq_base_path="dwaq_002"
map_output=os.path.join(dwaq_base_path,"dwaq_map.nc")

map_ds=xr.open_dataset(map_output)


##

usgs_ds=xr.open_dataset('usgs_cruises-2001_2016-v3.nc')

# Make versions of the nutrient variables here with the same units
# and names as DWAQ
usgs_ds['NO3']=usgs_ds['nn'] *14/1000.
usgs_ds['NH4']=usgs_ds['nh'] *14/1000.
usgs_ds['PO4']=usgs_ds['p'] * 31./1000.
usgs_ds['Si']=usgs_ds['si'] * 28/1000.

##


def find_map_cells_and_distances(map_ds):
    usgs_fine,srcs = linestring_utils.upsample_linearring(usgs_path,
                                                          200,closed_ring=0,
                                                          return_sources=True)
    centroids=g.cells_centroid()

    fine_cells=[ np.argmin( utils.dist(centroids-fine_xy) )
                 for fine_xy in usgs_fine ]

    fine_cells=np.unique(fine_cells)

    # For each of those, assign an effective distance along axis
    fine_cell_fine_idx=[ np.argmin( utils.dist(centroids[cell] - usgs_fine) )
                         for cell in fine_cells ]
    # each cell then has a closest point along the fine path, which then
    # gets mapped to its source index in usgs_path
    usgs_dists=usgs_ds.Distance_from_station_36.values
    fine_cell_fine_dist=np.interp( srcs[fine_cell_fine_idx],
                                   np.arange(len(usgs_dists)),usgs_dists)
    order=np.argsort(fine_cell_fine_dist)
    cell_dists=fine_cell_fine_dist[order]
    cell_idxs=fine_cells[order]
    return cell_idxs,cell_dists

##

fig_dir=os.path.join(dwaq_base_path,"figures")
os.path.exists(fig_dir) or os.makedirs(fig_dir)

# Generate spatial plots for each cruise,
# and time series for each station

# Per-station time series:
def compare_station(station_num,show_map=True,fig_num=1):
    station_idx=np.nonzero( usgs_ds.StationNumber.values==station_num)[0][0]
    x=usgs_ds.x.values[station_idx]
    y=usgs_ds.y.values[station_idx]

    g=unstructured_grid.UnstructuredGrid.from_ugrid(map_ds)
    g_cc=g.cells_centroid()
    dists=utils.dist(g_cc-np.r_[x,y])
    map_cell_idx=np.argmin(dists)

    plt.figure(fig_num).clf()
    fig,axs=plt.subplots(4,num=fig_num,sharex=True)

    pad=np.timedelta64(30,'D')
    usgs_date_sel= ( (usgs_ds.date>= map_ds.time[0] - pad ) &
                     (usgs_ds.date<= map_ds.time[-1] + pad ) ).values
    usgs_period=(usgs_ds
                 .isel(date=usgs_date_sel)
                 .isel(Distance_from_station_36=station_idx)
                 .mean(dim='prof_sample') )

    for ax,usgs_var,map_var in zip( axs,
                                    ['dchl','NO3','NH4','PO4','Si'],
                                    ['Chlfa','NO3','NH4','PO4','Si'] ):

        ax.plot( usgs_period.date, usgs_period[usgs_var].values,
                 'go',label='USGS')
        ax.plot( map_ds.time,
                 map_ds[map_var].isel(face=map_cell_idx).mean(dim='layer').values,
                 'k-',label='Model')
        if usgs_var!=map_var:
            label="%s -- %s"%(usgs_var,map_var)
        else:
            label=usgs_var
        ax.set_ylabel(label)
    plt.setp(axs[-1].xaxis.get_ticklabels(),rotation=90)
    fig.subplots_adjust(bottom=0.2)
    
    if show_map: # show the station location
        fig.subplots_adjust(right=0.65)
        ax_map=fig.add_axes([0.7,0.1,0.25,0.7])

        g.plot_edges(ax=ax_map)
        g.plot_cells(mask=[map_cell_idx],ax=ax_map)
        ax_map.text(x,y,'USGS')
        ax_map.plot([x],[y],'ro')    
        L=5*np.sqrt(g.cells_area()[map_cell_idx])
        ax_map.axis( [x-L,x+L,y-L,y+L] )

        ax_map.xaxis.set_visible(0)
        ax_map.yaxis.set_visible(0)

    if fig_dir is not None:
        fig.savefig(os.path.join(fig_dir,"time-station%s.png"%station_num))


# Which USGS stations to plot:
station_numbers=[36,34,32,30,27,24,22,21,18,15,13,9,6,3]
for station_num in station_numbers:
    compare_station(station_num)

##

# And spatial plots for each USGS cruise
cell_idxs,cell_dists=find_map_cells_and_distances(map_ds)

def compare_date(date,fig_num=2):
    usgs_cruise=usgs_ds.sel(date=date).mean(dim='prof_sample')
    map_time_idx=utils.nearest(map_ds.time,
                               date)

    plt.figure(fig_num).clf()
    fig,axs=plt.subplots(4,num=fig_num,sharex=True)
    for ax,usgs_var,map_var in zip( axs,
                                    ['dchl','NO3','NH4','PO4','Si'],
                                    ['Chlfa','NO3','NH4','PO4','Si'] ):
        ax.plot( usgs_cruise.Distance_from_station_36.values,
                 usgs_cruise[usgs_var].values,
                 'go')
        map_data=(map_ds[map_var]
                  .isel(time=map_time_idx)
                  .isel(face=cell_idxs)
                  .mean(dim='layer') )

        ax.plot( cell_dists, map_data, 'k-')
        ax.set_ylabel(usgs_var)

    axs[-1].set_xlabel('Distance from South (km)')
    usgs_date_s=utils.to_datetime(date).strftime('%Y-%m-%d')
    map_date_s=utils.to_datetime(map_ds.time.values[map_time_idx]).strftime('%Y-%m-%d')
    axs[0].set_title('USGS Cruise %s  Model output %s'%(usgs_date_s,map_date_s))

    if fig_dir is not None:
        fig.savefig(os.path.join(fig_dir,'cruise-%s.png'%usgs_date_s))

##
pad=np.timedelta64(10,'D')
usgs_date_sel= ( (usgs_ds.date>= map_ds.time[0] - pad ) &
                 (usgs_ds.date<= map_ds.time[-1] + pad ) ).values
usgs_dates=usgs_ds.date[ usgs_date_sel ]

for date in usgs_dates.values:
    compare_date(date)