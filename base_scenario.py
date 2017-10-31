"""
2017-10-29: copied from sfbay_phyto_agg_subtidal_basic
  Testing agg runs with new input file from T. Troost and A Blauw

2017-06-xx: copied ../sfbay_phyto_dynamo/sfbay_dynamo_wy2013_v001.py here, trim down
  for better starting point for aggregated runs.

v001: 2017-04-17.  back to tuning some of the parameters to tame the chlorophyll growth.

2017-03-17: Returning to DYNAMO after a long dry spell.  Switching up to use
  newest aggregated hydro.  Copied from dwaq_wy2013_D02hpc_phytoA00_K55.py

Building off of the BLOOM runs, now try to do something similar but with DYNAMO.

"""
import os
import datetime
import logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

import numpy as np
import xarray as xr
import pandas as pd

from six import iteritems
try:
    from importlib import reload
except ImportError:
    pass

from stompy import utils
from stompy.model.delft import waq_scenario

##

reload(waq_scenario)

## 

# Specify locations of outside data sources:

# POTW data, checked out in subdirectory:
potw_fn='sfbay_potw/outputs/sfbay_delta_potw.nc'
# Selection of hydrodynamics data:
rel_hyd_path="hydro/com-sfb_wy2013_sigagglp_v03.hyd"

# External reference to radiance data defined in radsurf() in Scen() class

##

# Load those external datasets:
sfbay_potw=xr.open_dataset(potw_fn)

hydro=waq_scenario.HydroFiles(hyd_path=rel_hyd_path)
hydro.enable_write_symlink=True

## 

PC=waq_scenario.ParameterConstant
Sub=waq_scenario.Substance
IC=waq_scenario.Initial


def parse_substance_file(fn,substance_cb=None,
                         parameter_cb=None,process_cb=None,
                         output_cb=None):
    with open(fn,'r') as fp:
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
                activity=tok()
                sub_attrs=nv_pairs(stop_on='end-substance')
                if substance_cb:
                    substance_cb(sub_name,active=(activity=='active'))
                # scen.substances[name]=Substance(active=(activity=='active'))
            elif blk=='parameter':
                par_name=tok().strip("'")
                par_attrs=nv_pairs(stop_on='end-parameter')
                if 'value' in par_attrs:
                    # scen.parameters[par_name]=PC(float(par_attrs['value']))
                    pass
                else:
                    log.warning("Not sure how to deal with %s"%(par_attrs))
                if parameter_cb:
                    parameter_cb(par_name,par_attrs)
            elif blk=='output':
                out_var=tok().strip("'")
                out_attrs=nv_pairs(stop_on='end-output')
                # scen.map_output += (out_var,)
                # scen.hist_output += (out_var,)
                if output_cb:
                    output_cb(out_var)
            elif blk=='active-processes':
                while 1:
                    tag=tok()
                    if tag=='end-active-processes':
                        break
                    elif tag=='name':
                        proc_name=tok().strip("'")
                        proc_desc=tok().strip("'")
                        # scen.parameters['ACTIVE_%s'%proc_name]=1
                        if process_cb:
                            process_cb(proc_name)
                    else:
                        log.warning("What is %s"%tag)
            else:
                log.warning("Skipping %s"%blk)


class BayDynamo(waq_scenario.Scenario):
    map_formats=['binary']
    sub_files=['SFB_pars.sub']
    use_bloom=True

    def __init__(self,*a,**k):
        super(BayDynamo,self).__init__(*a,**k)

        for fn in self.sub_files:
            self.add_outputs_from_sub(fn)

    def add_substances_from_sub(self,fn,subs):
        def sub_cb(name,active):
            subs[name]=Sub(active=active)
        parse_substance_file(fn,substance_cb=sub_cb)
    def add_parameters_from_sub(self,fn,params):
        def param_cb(name,attrs):
            params[name]=float(attrs['value'])
        def proc_cb(name):
            params["ACTIVE_"+name]=1
        parse_substance_file(fn,parameter_cb=param_cb,process_cb=proc_cb)
    def add_outputs_from_sub(self,fn):
        def output_cb(name):
            self.map_output += (name,)
            self.hist_output += (name,)
        parse_substance_file(fn,output_cb=output_cb)
            
    def init_substances(self):
        subs=super(BayDynamo,self).init_substances()
        for sub_fn in self.sub_files:
            self.add_substances_from_sub(sub_fn,subs)
            
        # self.log.info('BayDynamo: init_substances()')
        # subs['Diat'] = Sub(initial=IC(default=1.0))
        # subs['Green'] = Sub(initial=IC(default=1.0))
        # 
        # subs['AAP']        = Sub()
        # subs['DetC']       = Sub()
        # subs['DetN']       = Sub()
        # subs['DetP']       = Sub()
        # subs['DetSi']      = Sub()
        # 
        # subs['NH4']        = Sub(initial=IC(default=0.2))
        # subs['NO3']        = Sub(initial=IC(default=1.1))
        # subs['PO4']        = Sub(initial=IC(default=0.1))
        # subs['Si']         = Sub(initial=IC(default=0.1))
        # 
        # subs['OOC']        = Sub(initial=IC(default=0.1))
        # subs['OON']        = Sub(initial=IC(default=0.1))
        # subs['OOP']        = Sub(initial=IC(default=0.1))
        # subs['OOSi']       = Sub(initial=IC(default=0.1))
        # 
        # subs['Continuity'] = Sub(initial=IC(default=1.0))
        # subs['OXY']        = Sub(initial=IC(default=14.0))
        # 
        # # inactive:
        # subs['AAPS1']      = Sub(initial=IC(default=0.0),active=False)  
        # subs['DetCS1']     = Sub(initial=IC(default=0.0),active=False)  
        # subs['DetNS1']     = Sub(initial=IC(default=0.0),active=False)  
        # subs['DetPS1']     = Sub(initial=IC(default=0.0),active=False)  
        # subs['DetSiS1']    = Sub(initial=IC(default=0.0),active=False)  
        # subs['OOCS1']      = Sub(initial=IC(default=0.0),active=False)  
        # subs['OONS1']      = Sub(initial=IC(default=0.0),active=False)  
        # subs['OOPS1']      = Sub(initial=IC(default=0.0),active=False)  
        # subs['OOSiS1']     = Sub(initial=IC(default=0.0),active=False)  
        # subs['SOD']        = Sub(initial=IC(default=0.0),active=False)  

        return subs

    def init_parameters(self):       
        params=super(BayDynamo,self).init_parameters()

        for sub_fn in self.sub_files:
            self.add_parameters_from_sub(sub_fn,params)
        
        self.log.info("Start of BayDynamo parameter defs")
                

        # params['ACTIVE_Phy_dyn']=PC(1)
        # params["ACTIVE_GroMrt_Gre"]=PC(1)
        # params["ACTIVE_GroMrt_Dia"]=PC(1)
        # 
        # params["ACTIVE_NutUpt_Alg"]=PC(1)
        # params["ACTIVE_NutRel_Alg"]=PC(1)
        # params["ACTIVE_SedDiat"]=PC(1)

        # # will these take care of light limitation?
        # params["ACTIVE_Rad_Green"]=PC(1)
        # params["ACTIVE_Rad_Diat"]=PC(1)
        # 
        # params["ACTIVE_PPrLim"]=PC(1)


        # below, these are mostly copied from baybloom
        params['NOTHREADS']=PC(0) # Use more than one processor if available

        # params['SWAdsP']=PC(0) # SWAdsP          switch PO4 adsorption <0=Kd|1=Langmuir|2=pHdep>
        # params['KdPO4AAP']=PC(0.5) # KdPO4AAP        distrib. coeff. (-) or ads. eq. const.          [-]
        # # params['VSedAAP']=PC(5.00000e-001 # VSedAAP         sedimentation velocity AAP                      [m/d]
        # params['MaxPO4AAP']=PC(1.50000e-001) # MaxPO4AAP       adsorption capacity TIM for PO4                 [-]
        # params['fSedIM1']=PC(0.25)         # fSedIM1         sedimentation flux IM1                          [-]
        # params['VxSedIM1']=PC(0.00000e+000) # VxSedIM1        sedimentation velocity IM1                      [m/d]
        # 
        # params['SWOxyProd']=PC(1) # SWOxyProd       switch on oxygen prod. (0=BLOOM, 1=VAROXY)      [-]
        # 
        # # Deleted a bunch of parameters related to specific BLOOM classes
        # 
        # params['RcDetC']=PC(1.20000e-001) # RcDetC          first-order mineralisation rate DetC in layerS1 [d-1]
        # params['RcDetCHigh']=PC(1.80000e-001) # RcDetCHigh      maximum first-order mineralisation rate DetC    [d-1]
        # params['TcDetC']=PC(1.11000e+000) # TcDetC          temperature coefficient for mineralisation DetC [-]
        # params['CTMin']=PC(3.00000e+000) # CTMin           critical temperature for mineralisation         [oC]
        # params['NCMinLimH']=PC(1.50000e-001) # NCMinLimH       Upper limit limit N:C ratio detritus            [gN/gC]
        # params['NCMinLimL']=PC(1.00000e-001) # NCMinLimL       Lower limit limit N:C ratio detritus            [gN/gC]
        # params['PCMinLimH']=PC(1.50000e-002) # PCMinLimH       Upper limit limit P:C ratio detritus            [gP/gC]
        # params['PCMinLimL']=PC(1.00000e-002) # PCMinLimL       Lower limit limit P:C ratio detritus            [gP/gC]
        # params['ZSedDetC']=PC(0.00000e+000) # ZSedDetC        zeroth-order sedimentation flux DetC
        # params['VSedDetC']=PC(1.50000e+000) # VSedDetC        Setling velocity Detritus-C                     [d-1]
        # params['RcDetCS1']=PC(3.00000e-002) # RcDetCS1        Decomposition rate Detritus-C in sediment layer [d-1]
        # params['TcBMDetC']=PC(1.11000e+000) # TcBMDetC        Temperature coeff. mineralisation DetC in sed.  [-]
        # params['RcDetN']=PC(1.20000e-001) # RcDetN          first-order mineralisation rate DetN            [d-1]
        # params['RcDetNHigh']=PC(1.80000e-001) # RcDetNHigh      maximum first-order mineralisation rate DetN    [d-1]
        # params['TcDetN']=PC(1.11000e+000) # TcDetN          temperature coefficient for mineralisation DetN [-]
        # params['RcDetNS1']=PC(3.00000e-002) # RcDetNS1        1st-order mineralisation rate DetN in layer S1  [d-1]
        # params['TcBMDetN']=PC(1.11000e+000) # TcBMDetN        Temperature coefficient bottom Detritus-N       [-]
        # params['C-NDetCS1']=PC(6.60000e+000) # C-NDetCS1       C:N ratio in Detritus in the sediment s1        [gC/gN]
        # params['C-PDetCS1']=PC(5.00000e+001) # C-PDetCS1       C:P ratio in Detritus in the sediment s1        [gC/gP]
        # params['C-SDetCS1']=PC(4.00000e+000) # C-SDetCS1       C:si ratio in Detritus in the sediment s1       [gC/gSi]
        # params['RcDetP']=PC(1.20000e-001) # RcDetP          first-order mineralisation rate DetP            [d-1]
        # params['RcDetPHigh']=PC(1.80000e-001) # RcDetPHigh      maximum first-order mineralisation rate DetP    [d-1]
        # params['TcDetP']=PC(1.11000e+000) # TcDetP          temperature coefficient for mineralisation DetP [-]
        # params['RcDetPS1']=PC(3.00000e-002) # RcDetPS1        1st-order mineralisation rate DetP in layer S1  [d-1]
        # params['TcBMDetP']=PC(1.11000e+000) # TcBMDetP        Temperature coefficient bottom Detritus-P       [-]
        # params['RcDetSi']=PC(4.00000e-002) # RcDetSi         first-order mineralisation rate Detsi           [d-1]
        # params['RcDetSHigh']=PC(8.00000e-002) # RcDetSHigh      maximum first-order mineralisation rate DetSi   [d-1]
        # params['TcDetSi']=PC(1.11000e+000) # TcDetSi         temp. coefficient for mineralisation DetSi      [-]
        # params['SiCMinLimH']=PC(2.00000e-002) # SiCMinLimH      upper limit Si:C ratio detritus                 [gSi/gC]
        # params['SiCMinLimL']=PC(1.00000e-002) # SiCMinLimL      lower limit Si:C ratio detritus                 [gSi/gC]
        # 
        # params['RcDetSiS1']=PC(7.50000e-003) # RcDetSiS1       1st-order mineralisation rate DetSi layer S1    [d-1]
        # params['TcBMDetSi']=PC(1.04700e+000) # TcBMDetSi       Temp. coefficient bottom Detritus-Si            [-]
        # params['RcNit20']=PC(1.00000e-001) # RcNit20         MM- nitrification rate at 20 oC                 [d-1]     nitr
        # params['TcNit']=PC(1.07000e+000) # TcNit           temperature coefficient for nitrification       [-]
        # params['KsAmNit']=PC(4.00000e-001) # KsAmNit         half saturation constant for ammonium cons.     [gN/m3]
        # params['KsOxNit']=PC(5.00000e-001) # KsOxNit         half saturation constant for DO cons.           [gO2/m3]
        # params['CTNit']=PC(3.00000e+000) # CTNit           Critical temperature for nitrification          [oC]
        # params['Rc0NitOx']=PC(0.00000e+000) # Rc0NitOx        zero-order nitrification rate at neg. DO        [d-1]
        # params['COXNIT']=PC(-0.00000e+000) # COXNIT          critical oxygen concentration for nitrification [gO2/m3]
        # params['RcNit']=PC(1.00000e-001) # RcNit           Nitrification rate                              [d-1]     nitr
        # params['OOXNIT']=PC(5.00000e+000) # OOXNIT          optimum oxygen concentration for nitrification  [gO2/m3]
        # params['fAtmDepNH4']=PC(0.00000e+000) # fAtmDepNH4      Fraction of atmospherical deposition of NH4     [-]
        # params['sw2AtmDNH4']=PC(0.00000e+000) # sw2AtmDNH4      maximise withdrawel to mass 0=no, 1=yes
        # params['RcDen20']=PC(0.0)          # RcDen20         MM-denitrification reaction rate at 20 oC       [d-1]     denrate
        # params['TcDenWat']=PC(1.07000e+000) # TcDenWat        temperature coefficient for denitrification     [-]
        # params['KsOxDen']=PC(1.00000e+000) # KsOxDen         half saturation constant for oxygen inhib.      [gO2/m3]
        # params['CTDEN']=PC(2.00000e+000) # CTDEN           Critical temperature for denitrification        [oC]
        # params['Rc0DenOx']=PC(0.00000e+000) # Rc0DenOx        zero-order denit. rate at low temperature       [d-1]
        # params['COXDEN']=PC(1.01000e+002) # COXDEN          crit. oxygen concentr. for denitrification      [gO2/m3]
        # params['OOXDEN']=PC(1.00000e+002) # OOXDEN          optimum oxygen concentration for denitrification[gO2/m3]
        # params['RcDenWat']=PC(0.03)         # RcDenWat        first-order denitrification rate in water       [d-1]     denrate
        # params['fAtmDepNO3']=PC(0.00000e+000) # fAtmDepNO3      fraction atmospherische deposition of NO3       [-]
        # 
        # params['RcOOC']=PC(1.00000e-003) # RcOOC           first-order mineralisation rate OOC in layer S1 [d-1]
        # params['RcOOCHigh']=PC(1.00000e-003) # RcOOCHigh       maximum first-order mineralisation rate OOC     [d-1]
        # params['TcOOC']=PC(1.11000e+000) # TcOOC           temperature coefficient for mineralisation OOC  [-]
        # params['VSedOOC']=PC(1.00000e-001) # VSedOOC         sedimentation velocity OOC                      [m/d]
        # params['RcOOCS1']=PC(1.00000e-003) # RcOOCS1         first-order mineralisation rate OOC in layer S1 [d-1]
        # params['TcBMOOC']=PC(1.11000e+000) # TcBMOOC         temperature coeff. mineralisation OOC in sed    [-]
        # params['RcOOSi']=PC(2.00000e-002) # RcOOSi          first-order mineralisation rate OOSi in layers1 [d-1]
        # params['RcOOSiHigh']=PC(2.00000e-002) # RcOOSiHigh      maximum first-order mineralisation rate OOSi    [d-1]
        # params['TcOOSi']=PC(1.11000e+000) # TcOOSi          temperature coefficient for mineralisation OOSi [-]
        # params['RcOOSiS1']=PC(1.00000e-003) # RcOOSiS1        first-order mineralisation rate OOSi in layerS1 [-]
        # params['TcBMOOSi']=PC(1.11000e+000) # TcBMOOSi        temperature coeff. mineralisation OOSi in sed   [-]
        # 
        # # Previously omitted in several models! Added Hans Los 16 January 2013
        # params['RcOON']=PC(1.00000e-003) # RcOON           first-order mineralisation rate OON in layer S1 [d-1]
        # params['RcOONHigh']=PC(1.00000e-003) # RcOONHigh       maximum first-order mineralisation rate OON     [d-1]
        # params['TcOON']=PC(1.11000e+000) # TcOON           temperature coefficient for mineralisation OON  [-]
        # params['RcOOP']=PC(1.00000e-003) # RcOOP           first-order mineralisation rate OOP in layer S1 [d-1]
        # params['RcOOPHigh']=PC(1.00000e-003) # RcOOPHigh       maximum first-order mineralisation rate OOP     [d-1]
        # params['TcOOP']=PC(1.11000e+000) # TcOOP           temperature coefficient for mineralisation OOP  [-]
        # 
        # params['ZSedAlg']=PC(0.00000e+000) # ZSedAlg         zeroth-order sedimentation flux algae           [d-1]
        # params['V0SedAlg']=PC(0.0) # base sedimentation velocity of algae
        # params['Salinity']=PC(0.00000e+000) # Salinity        Background salinity                             [ppt]
        # params['SWRear']=PC(9.00000e+000) # SWRear          switch for oxygen reaeration formulation (1-13)
        # params['KLRear']=PC(4.00000e+000) # KLRear          reaeration transfer coefficient                 [d-1]
        # params['TCRear']=PC(1.01600e+000) # TCRear          Temperature coefficient for rearation           [-]
        # params['T1MxPP']=PC(1.00000e+001) # T1MxPP          1st Temperature coefficient for algae growth    [oC]
        # params['T2MxPP']=PC(1.30000e+001) # T2MxPP          2nd Temperature coefficient for algae growth    [oC]
        # params['fSODaut']=PC(0.00000e+000) # fSODaut         autonomous SOD (no effect SOD stat.var)         [-]
        # params['fSOD']=PC(0.00000e+000) # fSOD            zeroth-order sediment oxygen demand flux        [-]
        # params['RcSOD']=PC(1.00000e-001) # RcSOD           ecay rate SOD at 20 oC                          [d-1]
        # params['TcSOD']=PC(1.04000e+000) # TcSOD           temperature coefficient decay SOD               [-]
        # params['COXSOD']=PC(0.00000e+000) # COXSOD          critical oxygen concentration for SOD decay     [g02/m3]
        # params['PeriodVTRA']=PC(2.40000e+001) # PeriodVTRA      Period                                          [day]
        # params['ExtVlBak']=PC(8.00000e-002) # ExtVlBak        background extinction visible light             [m-1]
        # params['ExtVlDetC']=PC(1.00000e-001) # ExtVlDetC       Vis Light specific extinction coefficient DetC  [m2/gC]
        # params['ExtVlIM1']=PC(2.50000e-002) # ExtVlIM1        VL specific extinction coefficient M1           [m2/g]
        # params['ExtVLSal0']=PC(9.70000e-001) # ExtVLSal0       Specific Extinction of humic substances via salinity [m2/g]
                
        params['CLOSE_ERR']=1 # CLOSE_ERR       Close after error
        params['ScaleVDisp']=1 # ScaleVDisp      Scale of verticle dispersion
        params['MaxIter']=200 # MaxIter         Maximum itteration - raised from 100
        params['Tolerance']=1.0e-005 # Tolerance       Tollerance level - decreased from 10-7
        params['NOVEC']=PC(100.)         # NOVEC           Novec for numerical scheme
        params['Iteration Report']=PC(0.00000e+000) #Iteration Report Report iteration
        params['Latitude']=38.          # Latitude        latitude of study area - San Francisco
        params['RefDay']=274.         # RefDay          daynumber of reference day simulation - For now October [d]

        # params['VBurDMS1']=PC(5.00000e-003) # VBurDMS1        first order burial rate for layer S1            [d-1]
        # params['fBurS1IM1']=PC(5.00000e-003)
        # params['IM1S1']=PC(1000.)
        # params['SWSediment']=PC(1.00000e+000)
        # params['PorS1']=PC(3.00000e-001)
        # params['MaxThS1']=PC(999999)

        # params['MDETPR']=PC(5.00000E+000) # MDETPR          Prefernce of grazer of Detritus                 [-]
        # params['MGRZMO']=PC(1.00000E-001) # MGRZMO          Monod term filtration rate Mussel               [gC/m3]
        # params['MGRZRM']=PC(1.00000E-001) # MGRZRM          Maximum daily uptake Mussel                     [mgC/mgC/d]
        # params['MGRZFM']=PC(5.00000E-002) # MGRZFM          Maximum filtration velocity Mussel              [m3/gC/d]
        # params['MTMPFM']=PC(4.00000E-002) # MTMPFM          Tempearture coefficient Mussel filtration       [1/oC]
        # params['MTMPRM']=PC(4.00000E-002) # MTMPFM          Tempearture coefficient Mussel feeding rate     [1/oC]
        # params['MGRZMM']=PC(0.20000E-000) # MGRZMM          Maximum relative mortality Mussel               [1/d]
        # params['MGRZGM']=PC(0.20000E-000) # MGRZGM          Maximum relative Growth Mussel                  [1/d]
        # params['MGRZSE']=PC(0.00500E+000) # MGRZSE          Standaard respiration coefficient Mussel        [1/d]
        # params['MGRZRE']=PC(0.20000E+000) # MGRZRE          Maintenance respiration coefficient Mussel      [-]
        # params['MUnitSW']=PC(1.00000E+000) # MUnitSW         Use gC/m3 (0) or gC/m2 (1) for Mussels          [-]

        params['ONLY_ACTIVE']=1 # ONLY_ACTIVE
        # params['ACTIVE_AdsPO4AAP']=PC(1.00000e+000) # ACTIVE_AdsPO4AAP        Ad(De)Sorption ortho phosphorus to inorg. matter
        # params['ACTIVE_Sed_AAP']=PC(1.00000e+000) # ACTIVE_Sed_AAP          Sedimentation AAP (adsorbed PO4)
        # params['ACTIVE_VertDisp']=PC(1.00000e+000) # ACTIVE_VertDisp         Vertical dispersion (segment -> exchange)
        # params['ACTIVE_BurS1_AAP']=PC(1.00000e+000) # ACTIVE_BurS1_AAP        Burial of AAP (adsorbed PO4) from sediment S1
        # 
        # params['ACTIVE_Compos']=PC(1.00000e+000) # ACTIVE_Compos           Composition
        # params['ACTIVE_DecFast']=PC(1.00000e+000) # ACTIVE_WM_DetC          Mineralisation detritus carbon
        # params['ACTIVE_Sed_POC1']=PC(1.00000e+000) # ACTIVE_SedDetC          Sedimentation detritus carbon
        # params['ACTIVE_BMS1_DetC']=PC(1.00000e+000) # ACTIVE_BMS1_DetC        Mineralisation detritus carbon in sediment S1
        # params['ACTIVE_BurS1_DetC']=PC(1.00000e+000) # ACTIVE_BurS1_DetC       Burial detritus carbon from sediment S1
        # params['ACTIVE_BMS1_DetN']=PC(1.00000e+000) # ACTIVE_BMS1_DetN        Mineralisation detritus nitrogen in sediment S1
        # params['ACTIVE_BurS1N_Det']=PC(1.00000e+000) # ACTIVE_BurS1N_Det       Burial nutrients in detritus from sediment S1
        # params['ACTIVE_BMS1_DetP']=PC(1.00000e+000) # ACTIVE_BMS1_DetP        Mineralisation detritus phosphorus in sediment S1
        # params['ACTIVE_DisSi']=PC(1.00000e+000) # ACTIVE_WM_DetSi         Mineralisation detritus silicium
        # params['ACTIVE_BMS1_DetSi']=PC(1.00000e+000) # ACTIVE_BMS1_DetSi       Mineralisation detritus silica in sediment S1
        # params['ACTIVE_Nitrif_NH4']=PC(1.00000e+000) # ACTIVE_Nitrif_NH4       Nitrification of ammonium
        # 
        # params['ACTIVE_BMS1_OON']=PC(1.00000e+000) # ACTIVE_BMS1_OON         mineralisation other organic N in sediment S1
        # params['ACTIVE_BMS1_OOP']=PC(1.00000e+000)
        # params['ACTIVE_AtmDep_NH4']=PC(1.00000e+000) # ACTIVE_AtmDep_NH4       Atmosperic deposition NH4
        # params['ACTIVE_DenWat_NO3']=PC(1.00000e+000) # ACTIVE_DenWat_NO3       Denitrification in water column
        # params['ACTIVE_AtmDep_NO3']=PC(1.00000e+000) # ACTIVE_AtmDep_NO3       Atmosperic deposition NO3
        # params['ACTIVE_DecMedium']=PC(1.00000e+000) # ACTIVE_WM_OOC           Mineralisation other organic carbon
        # params['ACTIVE_Sed_OOC']=PC(1.00000e+000) # ACTIVE_Sed_OOC          Sedimentation other organic carbon
        # params['ACTIVE_SedN_OOC']=PC(1.00000e+000) # ACTIVE_SedN_OOC         Sedimentation nutrients in OOC
        # params['ACTIVE_SedN_Det']=PC(1.00000e+000) # ACTIVE_SedN_Det         Sedimimentation nutrients in detritus
        # params['ACTIVE_BMS1_OOC']=PC(1.00000e+000) # ACTIVE_BMS1_OOC         Mineralisation other organic C in sediment S1
        # params['ACTIVE_BurS1_OOC']=PC(1.00000e+000) # ACTIVE_BurS1_OOC        Burial other organic carbon from sediment S1
        # params['ACTIVE_BurS1N_OO']=PC(1.00000e+000) # ACTIVE_BurS1N_OO        Burial nutrients in oth. organics from sediment S1
        # params['ACTIVE_BMS1_OOSi']=PC(1.00000e+000) # ACTIVE_BMS1_OOSi        Mineralisation other organic Si in sediment S1

        # Maybe BLOOM-only?
        # params['ACTIVE_SEDALG']=PC(1.00000e+000) # ACTIVE_SEDALG           Sedimentation of algae species i
        
        # params['ACTIVE_RearOXY']=PC(1.00000e+000) # ACTIVE_RearOXY          Reaeration of oxygen

        # This had been xxx'd out - trying to restore it.  possible that SwOxyProd=1 is the right way, tho.
        # ACTIVE_VAROXY=1 gets through delwaq1, but fails in delwaq2
        # params['ACTIVE_VAROXY']=PC(1.00000e+000) # ACTIVE_VAROXY           Variable oxygen
        # params['SWOxyProd']=PC(1) # maybe that's the correct way???
        # params['ACTIVE_SedOXYDem']=PC(1.00000e+000) # ACTIVE_SedOXYDem        sediment oxygen demand
        # params['ACTIVE_DynDepth']=PC(1.00000e+000) # ACTIVE_DynDepth         Dynamical depth
        # params['ACTIVE_S1_Comp']=PC(1.00000e+000) # ACTIVE_S1_Comp          Composition sediment layer S1
        # params['ACTIVE_S2_Comp']=PC(1.00000e+000)
        
        params['ACTIVE_CalcRad']=PC(1.00000e+000) # ACTIVE_CalcRad          Radiation calculation
        params['ACTIVE_DepAve']=PC(1.00000e+000) # ACTIVE_DepAve           Average depth for Bloom step
        params['ACTIVE_Daylength']=PC(1.00000e+000) # ACTIVE_Daylength        Daylength calculation
        params['ACTIVE_vtrans']=PC(1.00000e+000) # ACTIVE_vtrans           vertical mixing distribution over a period
        params['ACTIVE_Compos']=PC(1.00000e+000) # ACTIVE_POC_Dyn          Composition of POC (Dynamo & Bloom)
        params['ACTIVE_Tau']=PC(1.00000e+000) # ACTIVE_Tau              Shear stress: Calculation of bottom friction
        # params['ACTIVE_Bur_DM']=PC(1.00000e+000) # ACTIVE_Bur_DM           Burial total bottom mass (dry matter)
        # params['ACTIVE_CalVSALG']=PC(1.00000e+000) # ACTIVE_CalVSALG         Sedimentation velocity ALGi = f (Temp SS Sal)

        params['ACTIVE_Veloc']=PC(1.00000e+000) # ACTIVE_Veloc            horizontal flow velocity
        params['ACTIVE_SaturOXY']=PC(1.00000e+000) # ACTIVE_SaturOXY         Saturation concentration oxygen
        params['ACTIVE_TotDepth']=PC(1.00000e+000) # ACTIVE_TotDepth         Calculate total depth

        params['ACTIVE_Extinc_VL']=PC(1.00000e+000) # ACTIVE_Extinc_VL        Extinction of visible-light (370-680nm)
        params['ACTIVE_Extinc_VLG']=PC(1) # replaces ACTIVE_ExtPODVL, ExtPOGVL
        params['ACTIVE_Chezy']=PC(1.00000e+000) # ACTIVE_Chezy            Chezy coefficient
        params['ACTIVE_Sum_Sedim']=PC(1.00000e+000) # ACTIVE_Sum_Sedim        Total of all sedimenting substances
        params['ACTIVE_SalinChlor']=PC(1.00000e+000) # updated name of ACTIVE_Chloride
                
        return params


class Scen(BayDynamo):
    name="sfbay_npzd000"
    desc=('sfbay_npzd',
          'wy2013',
          'sig-agg-lp')
    integration_option="""16 ;
    LOWER-ORDER-AT-BOUND NODISP-AT-BOUND
    BALANCES-OLD-STYLE BALANCES-GPP-STYLE 
    BAL_NOLUMPPROCESSES BAL_NOLUMPLOADS BAL_NOLUMPTRANSPORT
    BAL_NOSUPPRESSSPACE BAL_NOSUPPRESSTIME
    """
    # base_path='dwaq_000' # nefis output
    # base_path='dwaq_001' # switch to binary map output
    # base_path='dwaq_002' # long run
    # base_path='dwaq_003' # osx run    
    # base_path='dwaq_004' # set outputs from .sub file
    # base_path='dwaq_005' # fix ExtVlBak 6 --> 2, and drop BLOOMGRP from outputs
    # base_path='dwaq_006' # fix salinity being all 0.
    # base_path='dwaq_007' # DEB first go
    # base_path='dwaq_008' # DEB, increase Z_Xk 0.25->1
    # base_path='dwaq_009' # DEB - set IM1=20, and Yk=50
    # base_path='dwaq_010' # DEB. IM1=50.  Xk 1->0.5
    #base_path='dwaq_011' # DEB. IM1=50.  Xk 0.5->1.0, more light by backing off ExtVlBak
    base_path='dwaq_012' # output Z_Bio.  And modify bloominp to up BIOBAS by factor of 10

    time_step=3000 # matches the hydro

    def init_substances(self):
        subs=super(Scen,self).init_substances()

        if 'salinity' in subs:
            self.log.warning("Removing substance salinity in favor of parameter")
            del subs['salinity']
            
        
        subs['OXY']=Sub(initial=IC(default=8.0)) # start DO at 8mg/L
        subs['continuity']=Sub(initial=IC(default=1.0))

        # Based on Nutrient Conceptual model data, (pg 48)
        # NH4 in April: 3uM in Central, 4ish in SSFB and SPB,
        # so punt with 2uM coastal.
        # similarly 20uM NO3 in Central.  30-35 uM is upper bound on ocean
        # NO3, based on freshly upwelled water.  More common is 10uM in the
        # coastal ocean.

        # call the initial condition spatially constant 10uM.

        # 1 umol/L NH4 * 14 gN/mol * 1milli/1000micro
        subs['NH4']        = Sub(initial=IC(default=2 * 14/1000.))
        # had been 1.1 - i.e. lower south bay ambient 70uM.
        subs['NO3']        = Sub(initial=IC(default=10 * 14/1000.))
        # Follow Largier and Stacey - coastal phosphate roughly Redfield
        # to the nitrate.
        subs['PO4']        = Sub(initial=IC(default=10/16. * 31/1000.))

        # based on SFB Nutrient Conceptual model fig 6.7, choose a nominal
        # 100uM Si initial condition
        subs['Si']         = Sub(initial=IC(default=100.*28/1000))
        
        add_cons=False # whether to add conserved nutrient mimics
        if add_cons:
            subs['NH4cons']=subs['NH4'].copy()
            subs['NO3cons']=subs['NO3'].copy()

        link_groups=self.hydro.group_boundary_links()
        groups={} # just used for sanity checks to make sure that BCs that we're
        # trying to set exist.
        for link_group in link_groups:
            if link_group['id']>=0 and link_group['name'] not in groups:
                groups[ link_group['name'] ] = link_group
                
        def items_by_category(cat):
            return [key for key,val
                    in iteritems(groups)
                    if val['attrs'].get('category',None)==cat]

        # Dropped the old, hard-coded name-based categories.
        refinery_items=items_by_category('refinery')
        potw_items=items_by_category('potw')
        river_items=items_by_category('river')
        ocean_items=items_by_category('ocean')
        
        n_total_items=len(refinery_items + potw_items + river_items + ocean_items)
        if n_total_items != len(groups):
            self.log.error("Selected items: %d, but count of groups: %d"%(n_total_items,
                                                                          len(groups)))
            raise Exception("Missing category or something with grouped boundary links")

        if 1:
            subs['potw']=Sub(initial=IC(default=0.0))
            self.src_tags.append(dict(tracer='potw',items=potw_items))
        if 1: # set to if 0: to disable this one
            subs['river']=Sub(initial=IC(default=0.0))
            self.src_tags.append(dict(tracer='river',items=river_items))
        if 0:
            subs['refinery']=Sub(initial=IC(default=0.0))
            self.src_tags.append(dict(tracer='refinery',items=refinery_items))

        if 'continuity' in subs:
            self.src_tags.append(dict(tracer='continuity',
                                      items=river_items+ocean_items+potw_items+refinery_items,
                                      value=1.0))

        # Rivers and the ocean get background DO, but leave refineries and potws with 0 DO.
        self.src_tags.append(dict(tracer='oxy',items=river_items+ocean_items,
                                  value=subs['oxy'].initial.default))

        # Rivers get a base Si concentration, adapted from Peterson, 1978
        # Discharges stick with 0 Si.
        self.src_tags.append(dict(tracer='si',items=river_items,
                                  value=200 * 28./1000 ) )
        self.src_tags.append(dict(tracer='si',items=ocean_items,
                                  value=30 * 28./1000 ) )

        # And the nutrients:
        for grp_id,group in iteritems(groups):
            # Do we have a CSV with nutrients for this group?
            feature=group['attrs']
            if feature['driver']!='SFBAY_POTW':
                continue

            site_name=feature['gages'].split('#')[0]

            def to_series(fld):
                try:
                    return sfbay_potw[fld].sel(site=site_name).to_dataframe()[fld]
                except KeyError: # annoying py3 bytes vs. string
                    return sfbay_potw[fld].sel(site=site_name.encode()).to_dataframe()[fld]
                    
            
            items=[feature['name']]

            nox_conc=to_series('NOx_conc')
            self.src_tags.append(dict(tracer='no3',
                                      items=items,
                                      value=nox_conc))

            nh3_conc=to_series('NH3_conc')
            self.src_tags.append(dict(tracer='nh4',
                                      items=items,
                                      value=nh3_conc))

            po4_conc=to_series('PO4_conc')
            self.src_tags.append(dict(tracer='po4',
                                      items=items,
                                      value=po4_conc))

        # Will eventually have some synthetic ocean BC for nutrients, but for
        # now the ocean gets the same as initial conditions:
        for tracer in ['NO3','NH4','PO4']:
            self.src_tags.append(dict(tracer=tracer,
                                      items=ocean_items,
                                      value=subs[tracer].initial.default))


        if 1: # secondary salt tracer
            dfm_salt_ic=self.hydro.seg_func(t_sec=self.start_time, 
                                            label='salinity-file')
            subs['dwaq_salt']=Sub(initial=IC(seg_values=dfm_salt_ic))
            # 33.5 just reflects the less than great value taken from
            # the suntans run.
            self.src_tags.append(dict(tracer='dwaq_salt',items=ocean_items,
                                      value=33.5))

        self.add_deb_substances(subs)
    
        return subs

    def add_deb_substances(self,subs):
        # Based on Zhenlin run 2017082403
        subs['Zoopl_V']=Sub(initial=IC(default=0.4))
        subs['Zoopl_E']=Sub(initial=IC(default=0.1))
        subs['Zoopl_R']=Sub(initial=IC(default=0.0))
        subs['Zoopl_N']=Sub(initial=IC(default=50e3))

    def add_deb_parameters(self,params):
        params['ACTIVE_DEBGRZ_Z']=1

        params['Z_Lref']=5.0e-2
        params['Z_shape']=1
        params['Z_Pm']=480
        params['Z_JXm']=450
        params['Z_Kappa']=0.7
        params['Z_Xk']=0.25 # 1=> oscillations, ZZ: 0.25 
        params['Z_Yk']=50 # 1e6 # This is one they suggested could be changed for SSC inhibition
        params['Z_rMor']=0.0
        params['Z_TSi']=2.0e-3
        
        
    def init_parameters(self):
        # choose which processes are enabled.  Includes some
        # parameters which are not currently used.
        params=super(Scen,self).init_parameters()
        
        params['NOTHREADS']=3 # better to keep it to real cores?

        params['Tolerance']=1.0e-6
        
        # if convergence becomes an issue, there *might* be more info here:
        # params['Iteration Report']=PC(1)

        params['VWIND']=3.5

        params['TimMultBl']=48 # daily bloom step for a 0.5h waq step.

        params['RadSurf']=self.radsurf()

        params['ExtVlBak']=0.75 # this is becoming secondary to the IM1 effect
        params['IM1']=50.0 # mg/l SSC ish?
        self.add_deb_parameters(params)
        return params
        
    def cmd_default(self):
        self.cmd_write_hydro()
        self.cmd_write_inp()
        self.cmd_delwaq1()
        self.cmd_delwaq2()
        self.cmd_write_nc()

    def radsurf(self):
        """ Returns a parameter to describe the potentially time-varying
        incident radiation.
        """
        # rs=PC(150.0) # rough guess
        # rs=PC(75.0) # dial that back, too.

        # Pull in Union City CIMIS data:
        df=xr.open_dataset('union_city-hourly-2001-2016.nc')
        # Source is hourly, take true daily averages:
        daily_rad = np.nanmean( df['HlySolRad'].values.reshape([-1,24]), axis=1)
        daily_rad = utils.fill_invalid(daily_rad) # rare, but a few nans.

        # start in pacific standard time:
        daily_time=df['time'].values[::24] # these will be datetime64.
        daily_dn=utils.to_dnum(daily_time) + 8./24 # shift to UTC, though doesn't really matter.
        dn0=utils.to_dnum(self.hydro.time0)
        tsecs=((daily_dn-dn0)*86400).astype(np.int32)
        
        rs=waq_scenario.ParameterTemporal(times=tsecs,
                                          values=daily_rad)
        
        return rs
        
    def __init__(self,*a,**k):
        super(Scen,self).__init__(*a,**k)

        extra_fields=('salinity',
                      'temp',
                      'TotalDepth',
                      'ExtVl',
                      'Rad',
                      # minor glimpse at vertical mixing:
                      #'fractime01','fractime02','fractime08',
                      # 'SaturOXY',
                      'VertDisper',
                      'Chlfa',
                      'Phyt',
                      # 'AlgN','AlgP','AlgSi',
                      # dynamo only: 'fppDiat','fppGreen', # net pri pro
                      'Z_Bio', # DEB zooplankton biomass
                      'volume',
                      'depth')
        self.map_output+=extra_fields
        self.hist_output+=extra_fields

        DAILY=1000000
        self.map_time_step=DAILY # daily
        self.mon_time_step=DAILY # daily
        
        self.hist_time_step=DAILY # daily-hourly

        self.config_dispersion()
        self.config_rates()
        self.add_usgs_transect_monitor()
        self.add_lsb_monitors()

    def config_dispersion(self):
        # 2017-03-17: copied in from ../sfbay_nophyto_agg_subtidal/dwaq_tune_nutrients_v05.py
        # 2017-2-10: based on updated sig-agg-lp hydro, and a new go at
        # tuning in dwaq_tune_dispersion_03.py, the very slightly changed
        # values are 
        Klat=144.0
        Klon=2.81
        # 50.0 made good stride, but still a bit low
        Klsb=100.0 
        Kz=0.0
        scale_Kturb=0.023
        
        link_labels=np.loadtxt('link_labels-v04.txt',dtype='i4')
        # 0: error!   1: boundary   2: lateral  3:longitudinal
        # 4: LSB (new with v04)
        K_choices=np.array([ np.nan,0.0,Klat, Klon, Klsb])

        Kxyz=np.zeros( self.hydro.n_exch, 'f4' )
        self.hydro.infer_2d_links()
        Kxyz[:self.hydro.n_exch_x] = K_choices[ link_labels[self.hydro.exch_to_2d_link['link']]]
        Kxyz[self.hydro.n_exch_x:] = Kz
        self.dispersions['subtidal_K']=waq_scenario.DispArray(substances='.*',data=Kxyz)

        self.parameters['ScaleVDisp'] = PC(scale_Kturb)

        # these are now overridden by the above
        self.base_x_dispersion=0.0
        self.base_y_dispersion=0.0
        self.base_z_dispersion=0.0

    def add_usgs_transect_monitor(self):
        """ lump all the usgs sample locations into one monitoring area to
        get broad-brush balances.
        """
        # pulled from usgs transect
        xy=np.array( [[  582676.89874631,  4147608.43485955],
                      [  581341.46840116,  4148519.88353528],
                      [  580146.58169605,  4150172.63870161],
                      [  577628.08464891,  4151628.13229029],
                      [  576586.78934572,  4152728.03349741],
                      [  574367.58634256,  4153817.4355253 ],
                      [  571544.03202531,  4156751.47189957],
                      [  569029.11834886,  4158209.56929831],
                      [  566663.74310412,  4159484.68975885],
                      [  564437.61852413,  4161871.12435409],
                      [  562511.08020062,  4163705.51662575],
                      [  560585.48008233,  4165540.46266197],
                      [  559528.12680624,  4169416.15506171],
                      [  558330.08584425,  4172551.26246545],
                      [  558453.38267663,  4175880.75757463],
                      [  556516.2466788 ,  4179935.62097193],
                      [  556498.48564466,  4182524.40826308],
                      [  553393.91771774,  4186017.28803373],
                      [  550881.84804991,  4188960.18742818],
                      [  550418.09174599,  4192840.75604696],
                      [  548637.36614153,  4196528.48190827],
                      [  549476.11342052,  4203190.88711621],
                      [  552234.90982132,  4206721.74706252],
                      [  555291.3004305 ,  4209145.90400182],
                      [  560391.72612233,  4211771.20928497],
                      [  564623.62825589,  4212913.26912799],
                      [  569450.11460174,  4212767.9811421 ],
                      [  572530.45877571,  4211685.15653964],
                      [  574451.68089209,  4209483.16829452],
                      [  579258.93975789,  4211562.78942538],
                      [  584650.55476478,  4213466.4860191 ],
                      [  589481.4076512 ,  4212963.23308994],
                      [  593444.05879313,  4211712.976593  ],
                      [  598413.99062463,  4211956.42813898],
                      [  600443.0439842 ,  4213460.80109604],
                      [  605270.37332549,  4213336.82658049],
                      [  614930.91266961,  4223085.77808305]])

        # hydro=waq_scenario.HydroFiles(os.path.join(dwaq_dir,'com-sfbay_dynamo000.hyd'))

        self.hydro.infer_2d_elements()
        g=self.hydro.grid()

        elt_sel=[g.select_cells_nearest(pnt,inside=False)
                 for pnt in xy]

        segs=[ np.nonzero(elt==hydro.seg_to_2d_element)[0] 
               for elt in np.unique(elt_sel) ]
        segs=np.concatenate(segs)
        self.monitor_areas=self.monitor_areas + (('usgs_transect',segs),)

    def add_lsb_monitors(self):
        point_labels=[ [ (580097.08073597332, 4146652.9906012951), 'palo_alto'],
                       [ (586412.05526224524, 4146816.1563579757), 'coyote'],
                       [ (572731.88494433311, 4166797.7251314637), 'hayward'] ]
        g=self.hydro.grid()
        for pnt,label in point_labels:
            elt=g.select_cells_nearest(pnt,inside=True)
            segs=np.nonzero(elt==hydro.seg_to_2d_element)[0]
            self.monitor_areas=self.monitor_areas + ((label,segs),)
                   

    def config_rates(self):
        """ Adjust the rates relevant to tuning.  copied from sfbay_nophyto_agg_subtidal/tune v05...
        """
        hydro=self.hydro
        hydro.infer_2d_elements()

        cc=hydro.grid().cells_centroid()
        # cell centroids east of here are delta:
        delta_x0=601000

        # array with length of the number of 3D segments, which is 1.0 outside
        # the delta, 0.0 inside the delta
        delta_zero=(cc[:,0]<=delta_x0)[hydro.seg_to_2d_element].astype('f8')
        
        # These is also RcNit20, but with the specific flags that doesn't
        # get used.
        # Only need to zero out base rates, not temp coefficients.
        # RcDenSed is failing
        for param in ['RcNit','RcDenSed','RcDenWat']:
            if param not in self.parameters:
                raise Exception("Can only unDeltify parameters which have specified values: %s"%param)
            
            old_param=self.parameters[param]
            if isinstance(old_param,waq_scenario.ParameterConstant):
                new_param=waq_scenario.ParameterSpatial(old_param.value * delta_zero)
                self.parameters[param]=new_param
            else:
                self.log.warning("Will NOT un-Deltify parameter %s"%param)

sec=datetime.timedelta(seconds=1)

# # 
if 0:  # short run for testing:
    start_time=hydro.time0+60*24*3600*sec
    # and run for 20 days
    stop_time=start_time + 20*24*3600*sec
    map_time_step=3000 # half hour
if 1: # long run
    start_time=hydro.time0+hydro.t_secs[ 0]*sec
    stop_time =hydro.time0+hydro.t_secs[-2]*sec
    map_time_step=1000000 # daily

scen=Scen(hydro=hydro,
          start_time=start_time,
          stop_time=stop_time)
scen.map_time_step=map_time_step

# # 

# Hack for mac:
if 'DELFT_SRC' not in os.environ:
    os.environ['DELFT_SRC']="/Users/rusty/sfei/conda-recipes/delwaq/src/delft3d/src"
if 'DELFT_BIN' not in os.environ:
    os.environ['DELFT_BIN']='/usr/local/bin'
if 'D3D_HOME' not in os.environ:
    os.environ['D3D_HOME']='/usr/local'

scen.cmd_default()

##

# Can we get some basic cal plots going as part of that?

# Comparison of the processes in base_scenario, vs. the substance file:

# Substances:
#   Both:  OXY salinity continuity nh4 no3 po4 si
#          detcs1 detns1 detsis1 detps1
#   Only base_scenario:
#     aap, detc, detn detp detsi, diat, green, ooc oon oop oosi
#     aaps1  oocs1 oons1 oops1 oosis1 sod
#   Only sub file: opal poc1 pon1 pop1, mdiatoms_{e,n,p}
#     mflagela_{e,n,p}


# Processes:
#   Both:  VertDisp DenWat_NO3 nitrif_nh4 RearOXY DenSed_NO3
#          AtmDep_NH4 AtmDep_NO3 CalcRad
#          BMS1_DetC, BMS1_DetN, BMS1_DetP, BMS1_DetSi
#          SaturOXY, TotDepth Bur_DM  S1_Comp Sum_Sedim
#          Extinc_VLG DisSi Compos DynDepth DecFast CalVSALG
#          DepAve Daylength vtrans Veloc
# Only base_scenario:
#          Phy_dyn GroMRt_{Gre,Dia} Nutupt_alg nutrel_alg seddiat
#          rad_green rad_diat pprlim AdsPO4AAP ACTIVE_Sed_AAP
#          BurS1_AAP sed_poc1 burs1_{detc,detn,detp,detsi}
#          BMS1_OON BMS1_OOP Sed_OOC SedN_OOC BMS1_OOC BurS1_OOC
#          BurS1N_OO BMS1_OOSi 
#          SedOXYDem Tau Chezy SalinChlor DecMedium SedN_Det
#          S2_Comp Extinc_VL
# Only substance file:
#          BLOOM_P Sed_Opal Sed_POC1 SedNPOC1 S12TraDetC S12TraDetN
#          S12TraDetP SedPhBlo_P Phy_Blo_P SEDALG EXTINABVLP
#          CalVS_POC1 CONSELAC Secchi AtmDep_PO4


# substance file:
#   constant values for VertDisper, temp
#   TimMultBl - probably needs adjusting
#   COXDEN seems very high -
#   RcDenWat very small
# RcNit 0.07 - not bad
# Just set a shear stress - good
# Use a constant RadSurf - not really, it's set to -999

# maybe should output ExtVl - total extinction of visible light

# Adding DEB based on Zhenlin's 2017082403 run:
#  Looking through lsp:
#     Input for [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)                
#   it supplies some fluxes like dZ_Diat, dZ_Nres (=>NH4)
#   dZ_Pres, dZ_Resp
#   Zoopl_V (structural biomass), E (energy reserves) R (repro biomass), Zoopl_N (density?)

# So have to add substances:


