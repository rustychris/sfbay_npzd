import xarray as xr
import numpy as np
from stompy.grid import unstructured_grid
from stompy.spatial import linestring_utils

from stompy import utils
##
import pandas as pd
zz_rad=pd.read_csv("zz_deb_config/RadSurfTemporal.txt",
                   skiprows=2,names=['time','rad'],
                   delimiter="\s+",
                   parse_dates=['time'])

## 
usgs_ds=xr.open_dataset('usgs_cruises-2001_2016-v3.nc')

# Make versions of the nutrient variables here with the same units
# and names as DWAQ
usgs_ds['NO3']=usgs_ds['nn'] *14/1000.
usgs_ds['NH4']=usgs_ds['nh'] *14/1000.
usgs_ds['PO4']=usgs_ds['p'] * 31./1000.
usgs_ds['Si']=usgs_ds['si'] * 28/1000.

##

dwaq_base_path="dwaq_012"
map_output=os.path.join(dwaq_base_path,"dwaq_map.nc")
his_output=os.path.join(dwaq_base_path,"dwaq_hist.nc")

map_ds=xr.open_dataset(map_output)
his_ds=xr.open_dataset(his_output)

# # 
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

# #

fig_dir=os.path.join(dwaq_base_path,"figures")
os.path.exists(fig_dir) or os.makedirs(fig_dir)

# Generate spatial plots for each cruise,
# and time series for each station

def map_cell_for_usgs_station_num(station_num):
    station_idx=np.nonzero( usgs_ds.StationNumber.values==station_num)[0][0]
    x=usgs_ds.x.values[station_idx]
    y=usgs_ds.y.values[station_idx]

    g=unstructured_grid.UnstructuredGrid.from_ugrid(map_ds)
    g_cc=g.cells_centroid()
    dists=utils.dist(g_cc-np.r_[x,y])
    map_cell_idx=np.argmin(dists)
    return map_cell_idx

# Per-station time series:
def compare_station(station_num,show_map=True,fig_num=1):
    station_idx=np.nonzero( usgs_ds.StationNumber.values==station_num)[0][0]
    x=usgs_ds.x.values[station_idx]
    y=usgs_ds.y.values[station_idx]

    g=unstructured_grid.UnstructuredGrid.from_ugrid(map_ds)

    map_cell_idx=map_cell_for_usgs_station_num(station_num)
    
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

# #

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

# #
pad=np.timedelta64(10,'D')
usgs_date_sel= ( (usgs_ds.date>= map_ds.time[0] - pad ) &
                 (usgs_ds.date<= map_ds.time[-1] + pad ) ).values
usgs_dates=usgs_ds.date[ usgs_date_sel ]

for date in usgs_dates.values:
    compare_date(date)



##

# looking more closely at dwaq_003

# 1:  is the phyto field really as low as it appears? yes.  History file
#     is not representative.

# That's june 3, 2013
plt.figure(4).clf()
fig,ax=plt.subplots(num=4)
chlfa=map_ds['Chlfa'].mean(dim='layer').isel(time=300).values

coll=g.plot_cells(values=chlfa,cmap='jet',ax=ax)
plt.colorbar(coll)

# where were the history outputs? shoals of LSB, one in LSB channel,
# one in shoals of SSFB.
# ax.plot( his_ds.element_x, his_ds.element_y, 'go')

## 2: What is limiting phytoplankton?

# they are everywhere light limited
phyt_e=(map_ds['MDIATOMS_E']+map_ds['MFLAGELA_E']).mean(dim='layer').isel(time=300).values
phyt_n=(map_ds['MDIATOMS_N']+map_ds['MFLAGELA_N']).mean(dim='layer').isel(time=300).values
phyt_p=(map_ds['MDIATOMS_P']+map_ds['MFLAGELA_P']).mean(dim='layer').isel(time=300).values

phyt = map_ds['Phyt'].mean(dim='layer').isel(time=300).values

plt.figure(4).clf()
fig,ax=plt.subplots(num=4)
coll=g.plot_cells(values=phyt_e/phyt,cmap='jet',ax=ax)
coll.set_clim([0,1.2])
plt.colorbar(coll)

## 3: What light field is being imposed?

# they are everywhere light limited
# OSS is maybe 0.3 in shallows
extvl=map_ds['ExtVl'].isel(layer=1).isel(time=300).values

plt.figure(5).clf()
coll=g.plot_cells(values=extvl,cmap='jet')
plt.colorbar(coll)

# ExtVl now about 2.5 in many places.
# still kind of high? 
# ExtVlFresh is adding the extra 0.97/m
#  Is the salinity field screwed? yes!
# after adding IM1, ExtVlISS is now 1.25, so drop ExtVlBak further

## 
#     ExtVl       (time, layer, face) float64 2.97 2.97 2.97 2.97 2.97 2.97 ...
#     ExtVlBak    (time, layer, face) float64 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 ...
#     ExtVlFresh  (time, layer, face) float64 0.97 0.97 0.97 0.97 0.97 0.97 ...
#     ExtVlISS    (time, layer, face) float64 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 ...
#     ExtVlODS    (time, layer, face) float64 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 ...
#     ExtVlOSS    (time, layer, face) float64 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 ...
#     ExtVlPhyt   (time, layer, face) float64 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 ...

#   [ExtVLSal0           ] extra VL extinction at Salinity = 0                                   
#        Using constant nr139 with value: 0.970000                                                    

# Time to bring in DEB zooplankton


# Time series of zoopl
cell=map_cell_for_usgs_station_num(27)

stn_avg=map_ds.isel(face=cell).mean(dim='layer')
##

plt.figure(6).clf()
fig,axs=plt.subplots(2,1,num=6,sharex=True)
axs[0].plot(map_ds.time,stn_avg.Phyt,label='phyt')
axs[0].plot(map_ds.time,stn_avg.Z_Bio,label='Z_Bio')

axs[1].plot(map_ds.time,stn_avg.TIM,label='TIM')
# axs[1].plot(map_ds.time, map_ds['Rad'].isel(face=cell).isel(layer=0))

##
# chlfa gets down to 1.5ug/l in oscillations, phyt down 0.02, zoopl_v down to 0.05
# gC/m3 i assume.

##

# Initial settings are at least doing something, no oscillations, but seems to chomp
# the phyto down too much.
# Can I find that half-saturation grazing thing?
# possible parameters:
#   Yk with TIM: this is the SSC inhibition term.  TIM set to 1.0, Yk crazy high 1e6.
#   Z_JXm               ] max ingestion rate of DEB Zooplankton                                 
#       Using constant nr 39 with value:  450.000                                                    
# Later - Z_kappaI - ingestion efficiency of DEB Zooplankton, could implement sloppy
#   grazing if nutrients and chl are out of whack, but probably not the right knob
#       [Z_Xk                ] halfrate const for food of DEB Zooplankton                            
#       Using constant nr 41 with value: 0.250000                                                    

# And somewhere there is the min biomass thing for bloom.
# 
##
