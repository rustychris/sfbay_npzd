# parse a substance file and configure a waq_scenario accordingly

import logging
import stompy.model.delft.io as dio
from stompy.model.delft import waq_scenario

##

log=logging.getLogger('substance_file')

fn="SFB_pars.sub"

hydro=waq_scenario.Hydro()
scen=waq_scenario.Scenario(hydro=hydro)

# def load_substance_file(fn):
##

fp=open(fn,'r')
gen=dio.inp_tok(fp)
tok=lambda: next(gen)

def nv_pairs(stop_on):
    pairs={}
    while 1:
        tag=tok()
        if tag==stop_on:
            break
        else:
            # name-value pair
            name=tag
            value=tok().strip("'")
            pairs[name]=value
    return pairs
    
while 1:
    try:
        blk=tok()
    except StopIteration:
        break
    if blk=='substance':
        sub_name=tok().strip("'")
        activivity=tok()
        sub_attrs=nv_pairs(stop_on='end-substance')
        # scen.substances[name]=Substance(active=(activity=='active'))
    elif blk=='parameter':
        par_name=tok().strip("'")
        par_attrs=nv_pairs(stop_on='end-parameter')
        if 'value' in par_attrs:
            # scen.parameters[par_name]=PC(float(par_attrs['value']))
            pass
        else:
            log.warning("Not sure how to deal with %s"%(par_attrs))
    elif blk=='output':
        out_var=tok().strip("'")
        out_attrs=nv_pairs(stop_on='end-output')
        # scen.map_output += (out_var,)
        # scen.hist_output += (out_var,)
    elif blk=='active-processes':
        while 1:
            tag=tok()
            if tag=='end-active-processes':
                break
            elif tag=='name':
                proc_name=tok().strip("'")
                proc_desc=tok().strip("'")
                # scen.parameters['ACTIVE_%s'%proc_name]=1
            else:
                log.warning("What is %s"%tag)
    else:
        log.warning("Skipping %s"%blk)
