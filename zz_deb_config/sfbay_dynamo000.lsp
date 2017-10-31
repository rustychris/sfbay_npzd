                                                                                
 found -p command line switch                                                   

 Using process definition file : /home/zhenlin/src/delft3d/delft3d/src/engines_gpl/waq/default/proc_def
 Version number                :       5.05
 Serial                        : 2016051001



 Model :            sfbay_dynamo000                         
                    wy2013                                  


 Run   :            sig-agg-lp                              
                    T0: 2012/08/07-00:00:00  (scu=       1s)


# scanning input for old process definitions
 found only_active constant                                                     
 only activated processes are switched on                                       

total number of substances with fractions :  0
# Determining which processes can be switched on                                                    
                                                                                                    
 Input for [DynDepth            ] dynamic calculation of the depth                                  
   Process is activated                                                                             
                                                                                                    
 Input for [TotDepth            ] depth water column                                                
   Process is activated                                                                             
                                                                                                    
 Input for [VertDisp            ] Vertical dispersion (segment -> exchange)                         
   Process is activated                                                                             
                                                                                                    
 Input for [CalcRad             ] Radiation at segment upper and lower boundaries                   
   Process is activated                                                                             
                                                                                                    
 Input for [Phy_dyn             ] Computation of phytoplankton - Dynamo                             
   Process is activated                                                                             
                                                                                                    
 Input for [DenSed_NO3          ] Denitrification in sediment                                       
   Process is activated                                                                             
                                                                                                    
 Input for [DenWat_NO3          ] Denitrification in water column                                   
   Process is activated                                                                             
                                                                                                    
 Input for [Nitrif_NH4          ] Nitrification of ammonium                                         
   Process is activated                                                                             
                                                                                                    
 Input for [SaturOXY            ] Saturation concentration oxygen                                   
   Process is activated                                                                             
                                                                                                    
 Input for [RearOXY             ] Reaeration of oxygen                                              
   Process is activated                                                                             
                                                                                                    
 Input for [NLDiat              ] Nutrient limiation function for diatoms                           
   Process is activated                                                                             
                                                                                                    
 Input for [Rad_Diat            ] Light efficiency function diatoms                                 
   Process is activated                                                                             
                                                                                                    
 Input for [GroMrt_Dia          ] Nett primary production and mortality diatoms                     
   Process is activated                                                                             
                                                                                                    
 Input for [PPrLim              ] Limitation (numerical) on primary production                      
   Process is activated                                                                             
                                                                                                    
 Input for [NutUpt_Alg          ] Uptake of nutrients by growth of algae                            
   Process is activated                                                                             
                                                                                                    
 Input for [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)                
   Process is activated                                                                             
                                                                                                    
                                                                                                    
# determinig the processes to model the substances.                                                 
                                                                                                    
-fluxes for [Diat                ]                                                                  
 found flux  [dPPDiat             ] net primary production of Diatoms                               
   from proces [GroMrt_Dia          ] Nett primary production and mortality diatoms                 
   process is switched on.                                                                          
 found flux  [dMrtDiat            ] mortality of Diatoms                                            
   from proces [GroMrt_Dia          ] Nett primary production and mortality diatoms                 
   process is switched on.                                                                          
 found flux  [dcPPDiat            ] correction flux Diatoms growth                                  
   from proces [PPrLim              ] Limitation (numerical) on primary production                  
   process is switched on.                                                                          
 found flux  [dZ_Diat             ] grazing of Diatoms by DEB Zooplankton                           
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [Diat                ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [Diat                ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [NH4                 ]                                                                  
 found flux  [dNITRIF             ] nitrification flux                                              
   from proces [Nitrif_NH4          ] Nitrification of ammonium                                     
   process is switched on.                                                                          
 found flux  [dNH4Upt             ] NH4 uptake by algae growth                                      
   from proces [NutUpt_Alg          ] Uptake of nutrients by growth of algae                        
   process is switched on.                                                                          
 found flux  [dZ_NRes             ] respiration flux DEB Zooplankton                                
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [NH4                 ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [NH4                 ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [NO3                 ]                                                                  
 found flux  [dDenitSed           ] denitrification flux from the sediment                          
   from proces [DenSed_NO3          ] Denitrification in sediment                                   
   process is switched on.                                                                          
 found flux  [dDenitWat           ] denitrification flux in the water column                        
   from proces [DenWat_NO3          ] Denitrification in water column                               
   process is switched on.                                                                          
 found flux  [dNITRIF             ] nitrification flux                                              
   from proces [Nitrif_NH4          ] Nitrification of ammonium                                     
   process is switched on.                                                                          
 found flux  [dNO3Upt             ] uptake of NO3 by algae growth                                   
   from proces [NutUpt_Alg          ] Uptake of nutrients by growth of algae                        
   process is switched on.                                                                          
-dispersion for [NO3                 ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [NO3                 ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [PO4                 ]                                                                  
 found flux  [dPO4Upt             ] PO4 uptake by algae growth                                      
   from proces [NutUpt_Alg          ] Uptake of nutrients by growth of algae                        
   process is switched on.                                                                          
 found flux  [dZ_PRes             ] respiration flux DEB Zooplankton                                
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [PO4                 ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [PO4                 ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [Si                  ]                                                                  
 found flux  [dSIUpt              ] Si uptake by algae growth                                       
   from proces [NutUpt_Alg          ] Uptake of nutrients by growth of algae                        
   process is switched on.                                                                          
-dispersion for [Si                  ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [Si                  ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [continuity          ]                                                                  
 no fluxes found                                                                                    
-dispersion for [continuity          ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [continuity          ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [OXY                 ]                                                                  
 found flux  [dDenitWat           ] denitrification flux in the water column                        
   from proces [DenWat_NO3          ] Denitrification in water column                               
   process is switched on.                                                                          
 found flux  [dNITRIF             ] nitrification flux                                              
   from proces [Nitrif_NH4          ] Nitrification of ammonium                                     
   process is switched on.                                                                          
 found flux  [dREAROXY            ] reaeration flux of dissolved oxygen                             
   from proces [RearOXY             ] Reaeration of oxygen                                          
   process is switched on.                                                                          
 found flux  [dPPDiat             ] net primary production of Diatoms                               
   from proces [GroMrt_Dia          ] Nett primary production and mortality diatoms                 
   process is switched on.                                                                          
 found flux  [dcPPGreen           ] correction flux Greens growth                                   
   from proces [PPrLim              ] Limitation (numerical) on primary production                  
   process is switched on.                                                                          
 found flux  [dcPPDiat            ] correction flux Diatoms growth                                  
   from proces [PPrLim              ] Limitation (numerical) on primary production                  
   process is switched on.                                                                          
 found flux  [dNO3Upt             ] uptake of NO3 by algae growth                                   
   from proces [NutUpt_Alg          ] Uptake of nutrients by growth of algae                        
   process is switched on.                                                                          
 found flux  [dZ_Resp             ] respiration flux DEB Zooplankton                                
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [OXY                 ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [OXY                 ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [Zoopl_V             ]                                                                  
 found flux  [dZ_Vgr              ] growth flux struct biomass DEB Zoopl                            
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
 found flux  [dZ_Vmor             ] mortality flux struct biomass DEB Zoopl                         
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [Zoopl_V             ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [Zoopl_V             ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [Zoopl_E             ]                                                                  
 found flux  [dZ_Ea               ] anabolic flux energy reserves DEB Zoopl                         
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
 found flux  [dZ_Ec               ] catabolic flux energy reserves DEB Zoopl                        
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
 found flux  [dZ_Emor             ] mortality flux energy reserves DEB Zoopl                        
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [Zoopl_E             ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [Zoopl_E             ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [Zoopl_R             ]                                                                  
 found flux  [dZ_SpwDet           ] spawning flux DEB Zooplankton to DetC                           
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
 found flux  [dZ_Rgr              ] growth flux gonadal tissue DEB Zoopl                            
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
 found flux  [dZ_Rmor             ] mortality flux gonadal tissue DEB Zoopl                         
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [Zoopl_R             ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [Zoopl_R             ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [Zoopl_N             ]                                                                  
 found flux  [dZ_Nind             ] increase dens by growth (V1morphs only)                         
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
 found flux  [dZ_Mort             ] mortality and harvesting of DEB Zoopl                           
   from proces [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)            
   process is switched on.                                                                          
-dispersion for [Zoopl_N             ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [Zoopl_N             ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [potw                ]                                                                  
 no fluxes found                                                                                    
-dispersion for [potw                ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [potw                ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [river               ]                                                                  
 no fluxes found                                                                                    
-dispersion for [river               ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [river               ]                                                                
 no velocity found                                                                                  
                                                                                                    
-fluxes for [dwaq_salt           ]                                                                  
 no fluxes found                                                                                    
-dispersion for [dwaq_salt           ]                                                              
 found dispersion[VertDisp            ] vertical dispersion                                         
   from proces [VertDisp            ] Vertical dispersion (segment -> exchange)                     
   process is switched on.                                                                          
-velocity for [dwaq_salt           ]                                                                
 no velocity found                                                                                  
                                                                                                    
# locating processes for requested output                                                           
                                                                                                    
# determining the input for the processes (in reversed order)                                       
                                                                                                    
 Input for [DEBGRZ_Z            ] Dynamics of DEB Zooplankton (def: active V1morphs)                
       [DELT                ] timestep for processes                                                
       Using DELWAQ timestep in days                                                                
       [Volume              ] volume of computational cell                                          
       Using DELWAQ volume                                                                          
       [Temp                ] ambient water temperature                                             
       Using segment function nr  2                                                                 
       [Depth               ] depth of segment                                                      
       Using output from proces [DynDepth            ]                                              
       [TotalDepth          ] total depth water column                                              
       Using output from proces [TotDepth            ]                                              
       [TIM                 ] total inorganic matter                                                
       Using constant nr 35 with value:  1.00000                                                    
       [SWDetTyp            ] option for POX (value must not be changed)                            
       using default value:  1.00000                                                                
       [Z_SwV1              ] use 0 [ISO-morphs] or 1 [V1-morphs]                                   
       using default value:  1.00000                                                                
       [Z_SwBEN             ] Use 0 [pelagic] or 1 [benthic] for DEB Zoopl                          
       using default value:  0.00000                                                                
       [Zoopl_V             ] conc struct biomass of DEB Zoopl                                      
       Using substance nr   8                                                                       
       [Zoopl_E             ] conc energy reserves of DEB Zoopl                                     
       Using substance nr   9                                                                       
       [Zoopl_R             ] conc gonadal biomass of DEB Zoopl                                     
       Using substance nr  10                                                                       
       [Zoopl_N             ] nr of individuals DEB Zooplankton                                     
       Using substance nr  11                                                                       
       [Z_Lref              ] ref length of DEB Zoopl    (only for V1morphs)                        
       Using constant nr 36 with value: 0.500000E-01                                                
       [Z_Dummy             ] dummy constant for DEB Zooplankton                                    
       using default value:  1.00000                                                                
       [Z_Vb                ] volume at birth of individual DEB Zooplankter                         
       using default value: 0.100000E-05                                                            
       [Z_Vp                ] volume at start of repro stage ind DEB Zoopl                          
       using default value: 0.481570E-05                                                            
       [Z_shape             ] shape coefficient of DEB Zooplankton                                  
       Using constant nr 37 with value:  1.00000                                                    
       [Z_Em                ] maximum storage density of DEB Zooplankton                            
       using default value:  3347.00                                                                
       [Z_Eg                ] volume-spec costs for growth of DEB Zoopl                             
       using default value:  3173.00                                                                
       [Z_Pm                ] respiration rate constant of DEB Zooplankton                          
       Using constant nr 38 with value:  480.000                                                    
       [Z_JXm               ] max ingestion rate of DEB Zooplankton                                 
       Using constant nr 39 with value:  450.000                                                    
       [Z_kappaI            ] ingestion efficiency of DEB Zooplankton                               
       using default value:  1.00000                                                                
       [Z_kappaA            ] assimilation efficiency of DEB Zooplankton                            
       using default value:  1.00000                                                                
       [Z_kappa             ] fraction of energy spent on growth DEB Zoopl                          
       Using constant nr 40 with value: 0.700000                                                    
       [Z_kappaR            ] fraction of energy spent on gonads DEB Zoopl                          
       using default value: 0.950000                                                                
       [Z_Ta                ] arrhenius temperature of DEB Zooplankton                              
       using default value:  8000.00                                                                
       [Z_Tah               ] arr temp for upper boundary DEB Zooplankton                           
       using default value:  190000.                                                                
       [Z_Tal               ] arr temp for lower boundary DEB Zooplankton                           
       using default value:  50000.0                                                                
       [Z_Th                ] upper boundary of tolerance range of DEB Zoopl                        
       using default value:  400.000                                                                
       [Z_Tl                ] lower boundary of tolerance range of DEB Zoopl                        
       using default value:  273.000                                                                
       [Z_GSIupr            ] minimum GSI for spawning of DEB Zooplankton                           
       using default value: 0.930000E-01                                                            
       [Z_GSIlwr            ] minimum GSI while spawning of DEB Zooplankton                         
       using default value: 0.100000E-02                                                            
       [Z_DoSpawn           ] indication of spawning of DEB Zooplankton                             
       using default value:  0.00000                                                                
       [Z_rSpawn            ] spawning rate of DEB Zooplankton                                      
       using default value: 0.105000                                                                
       [Z_MinSTmp           ] minimum temperature for spawning of DEB Zoopl                         
       using default value:  10.0000                                                                
       [Z_Xk                ] halfrate const for food of DEB Zooplankton                            
       Using constant nr 41 with value: 0.250000                                                    
       [Z_Yk                ] halfrate const for TIM of DEB Zooplankton                             
       Using constant nr 42 with value: 0.100000E+07                                                
       [Z_rMor              ] reference mortality rate of DEB Zooplankton                           
       Using constant nr 43 with value:  0.00000                                                    
       [Z_cMor              ] length coefficient harvesting rate DEB Zoopl                          
       using default value:  0.00000                                                                
       [Z_rHrv              ] reference rate of harvesting of DEB Zoopl                             
       using default value:  0.00000                                                                
       [Z_cHrv              ] length coefficient harvesting rate DEB Zoopl                          
       using default value:  0.00000                                                                
       [Z_cEC               ] energy to carbon conversion of DEB Zoopl                              
       using default value: 0.240260E-04                                                            
       [Z_cVC               ] volume to carbon conversion of DEB Zoopl                              
       using default value: 0.603000E-01                                                            
       [Z_cAFWC             ] AFD weight to carbon conv of DEB Zoopl                                
       using default value: 0.400000                                                                
       [Z_cWWC              ] wetweight to carbon conv of DEB Zoopl                                 
       using default value: 0.480000E-02                                                            
       [Z_TC                ] C:C ratio of DEB Zooplankton                                          
       using default value:  1.00000                                                                
       [Z_TN                ] N:C ratio of DEB Zooplankton                                          
       using default value: 0.181800                                                                
       [Z_TP                ] P:C ratio of DEB Zooplankton                                          
       using default value: 0.263000E-01                                                            
       [Z_TSi               ] Si:C ratio of DEB Zooplankton                                         
       Using constant nr 44 with value: 0.200000E-02                                                
       [Z_FrDetS1           ] fraction of DEB Zoopl detritus into sediment                          
       using default value:  0.00000                                                                
       [Z_SFSusp            ] DEB Zoopl pref suspension over deposit feeding                        
       using default value:  1.00000                                                                
       [Z_PrDet             ] DEB Zoopl preference for DetC or POC1                                 
       using default value:  0.00000                                                                
       [Z_PrDetS1           ] DEB Zoopl preference for DetCS1                                       
       using default value:  0.00000                                                                
       [Z_FFDet             ] Faecal fraction of DetC for DEB Zooplankton                           
       using default value: 0.500000                                                                
       [Z_FFDetS1           ] Faecal fraction of DetCS1 for DEB Zooplankton                         
       using default value: 0.500000                                                                
       [DetC                ] Detritus Carbon  (DetC)                                               
       using default value:  0.00000                                                                
       [DetN                ] Detritus Nitrogen (DetN)                                              
       using default value:  0.00000                                                                
       [DetP                ] Detritus Phosphorus (DetP)                                            
       using default value:  0.00000                                                                
       [DetSi               ] Detritus Silica (DetSi)                                               
       using default value:  0.00000                                                                
       [POC1                ] POC1 (fast decomposing fraction)                                      
       using default value:  0.00000                                                                
       [PON1                ] PON1 (fast decomposing fraction)                                      
       using default value:  0.00000                                                                
       [POP1                ] POP1 (fast decomposing fraction)                                      
       using default value:  0.00000                                                                
       [Opal                ] Opal-Si                                                               
       using default value:  0.00000                                                                
       [DetCS1              ] DetC in layer S1                                                      
       using default value:  0.00000                                                                
       [DetNS1              ] DetN in layer S1                                                      
       using default value:  0.00000                                                                
       [DetPS1              ] DetP in layer S1                                                      
       using default value:  0.00000                                                                
       [DetSiS1             ] DetSi in layer S1                                                     
       using default value:  0.00000                                                                
       [Green               ] Algae (non-Diatoms)                                                   
       using default value:  0.00000                                                                
       [Diat                ] Diatoms                                                               
       Using substance nr   1                                                                       
       [BLOOMALG01          ] concentration of algae type 1                                         
       using default value: -101.000                                                                
       [BLOOMALG02          ] concentration of algae type 2                                         
       using default value: -101.000                                                                
       [BLOOMALG03          ] concentration of algae type 3                                         
       using default value: -101.000                                                                
       [BLOOMALG04          ] concentration of algae type 4                                         
       using default value: -101.000                                                                
       [BLOOMALG05          ] concentration of algae type 5                                         
       using default value: -101.000                                                                
       [BLOOMALG06          ] concentration of algae type 6                                         
       using default value: -101.000                                                                
       [BLOOMALG07          ] concentration of algae type 7                                         
       using default value: -101.000                                                                
       [BLOOMALG08          ] concentration of algae type 8                                         
       using default value: -101.000                                                                
       [BLOOMALG09          ] concentration of algae type 9                                         
       using default value: -101.000                                                                
       [BLOOMALG10          ] concentration of algae type 10                                        
       using default value: -101.000                                                                
       [BLOOMALG11          ] concentration of algae type 11                                        
       using default value: -101.000                                                                
       [BLOOMALG12          ] concentration of algae type 12                                        
       using default value: -101.000                                                                
       [BLOOMALG13          ] concentration of algae type 13                                        
       using default value: -101.000                                                                
       [BLOOMALG14          ] concentration of algae type 14                                        
       using default value: -101.000                                                                
       [BLOOMALG15          ] concentration of algae type 15                                        
       using default value: -101.000                                                                
       [BLOOMALG16          ] concentration of algae type 16                                        
       using default value: -101.000                                                                
       [BLOOMALG17          ] concentration of algae type 17                                        
       using default value: -101.000                                                                
       [BLOOMALG18          ] concentration of algae type 18                                        
       using default value: -101.000                                                                
       [BLOOMALG19          ] concentration of algae type 19                                        
       using default value: -101.000                                                                
       [BLOOMALG20          ] concentration of algae type 20                                        
       using default value: -101.000                                                                
       [BLOOMALG21          ] concentration of algae type 21                                        
       using default value: -101.000                                                                
       [BLOOMALG22          ] concentration of algae type 22                                        
       using default value: -101.000                                                                
       [BLOOMALG23          ] concentration of algae type 23                                        
       using default value: -101.000                                                                
       [BLOOMALG24          ] concentration of algae type 24                                        
       using default value: -101.000                                                                
       [BLOOMALG25          ] concentration of algae type 25                                        
       using default value: -101.000                                                                
       [BLOOMALG26          ] concentration of algae type 26                                        
       using default value: -101.000                                                                
       [BLOOMALG27          ] concentration of algae type 27                                        
       using default value: -101.000                                                                
       [BLOOMALG28          ] concentration of algae type 28                                        
       using default value: -101.000                                                                
       [BLOOMALG29          ] concentration of algae type 29                                        
       using default value: -101.000                                                                
       [BLOOMALG30          ] concentration of algae type 30                                        
       using default value: -101.000                                                                
       [F1                  ] Dummy food type 1                                                     
       using default value:  0.00000                                                                
       [F2                  ] Dummy food type 2                                                     
       using default value:  0.00000                                                                
       [F3                  ] Dummy food type 3                                                     
       using default value:  0.00000                                                                
       [F4                  ] Dummy food type 4                                                     
       using default value:  0.00000                                                                
       [F5                  ] Dummy food type 5                                                     
       using default value:  0.00000                                                                
       [F6                  ] Dummy food type 6                                                     
       using default value:  0.00000                                                                
       [F7                  ] Dummy food type 7                                                     
       using default value:  0.00000                                                                
       [F8                  ] Dummy food type 8                                                     
       using default value:  0.00000                                                                
       [NCRatGreen          ] N:C ratio Greens                                                      
       using default value: 0.160000                                                                
       [NCRatDiat           ] N:C ratio Diatoms                                                     
       Using constant nr 34 with value: 0.150000                                                    
       [NCRAlg01            ] N:C ratio algae type 01                                               
       using default value: 0.200000                                                                
       [NCRAlg02            ] N:C ratio algae type 02                                               
       using default value: 0.200000                                                                
       [NCRAlg03            ] N:C ratio algae type 03                                               
       using default value: 0.200000                                                                
       [NCRAlg04            ] N:C ratio algae type 04                                               
       using default value: 0.200000                                                                
       [NCRAlg05            ] N:C ratio algae type 05                                               
       using default value: 0.200000                                                                
       [NCRAlg06            ] N:C ratio algae type 06                                               
       using default value: 0.200000                                                                
       [NCRAlg07            ] N:C ratio algae type 07                                               
       using default value: 0.200000                                                                
       [NCRAlg08            ] N:C ratio algae type 08                                               
       using default value: 0.200000                                                                
       [NCRAlg09            ] N:C ratio algae type 09                                               
       using default value: 0.200000                                                                
       [NCRAlg10            ] N:C ratio algae type 10                                               
       using default value: 0.200000                                                                
       [NCRAlg11            ] N:C ratio algae type 11                                               
       using default value: 0.200000                                                                
       [NCRAlg12            ] N:C ratio algae type 12                                               
       using default value: 0.200000                                                                
       [NCRAlg13            ] N:C ratio algae type 13                                               
       using default value: 0.200000                                                                
       [NCRAlg14            ] N:C ratio algae type 14                                               
       using default value: 0.200000                                                                
       [NCRAlg15            ] N:C ratio algae type 15                                               
       using default value: 0.200000                                                                
       [NCRAlg16            ] N:C ratio algae type 16                                               
       using default value: 0.200000                                                                
       [NCRAlg17            ] N:C ratio algae type 17                                               
       using default value: 0.200000                                                                
       [NCRAlg18            ] N:C ratio algae type 18                                               
       using default value: 0.200000                                                                
       [NCRAlg19            ] N:C ratio algae type 19                                               
       using default value: 0.200000                                                                
       [NCRAlg20            ] N:C ratio algae type 20                                               
       using default value: 0.200000                                                                
       [NCRAlg21            ] N:C ratio algae type 21                                               
       using default value: 0.200000                                                                
       [NCRAlg22            ] N:C ratio algae type 22                                               
       using default value: 0.200000                                                                
       [NCRAlg23            ] N:C ratio algae type 23                                               
       using default value: 0.200000                                                                
       [NCRAlg24            ] N:C ratio algae type 24                                               
       using default value: 0.200000                                                                
       [NCRAlg25            ] N:C ratio algae type 25                                               
       using default value: 0.200000                                                                
       [NCRAlg26            ] N:C ratio algae type 26                                               
       using default value: 0.200000                                                                
       [NCRAlg27            ] N:C ratio algae type 27                                               
       using default value: 0.200000                                                                
       [NCRAlg28            ] N:C ratio algae type 28                                               
       using default value: 0.200000                                                                
       [NCRAlg29            ] N:C ratio algae type 29                                               
       using default value: 0.200000                                                                
       [NCRAlg30            ] N:C ratio algae type 30                                               
       using default value: 0.200000                                                                
       [NCRatF1             ] N:C ratio Dummy food type 1                                           
       using default value: 0.400000                                                                
       [NCRatF2             ] N:C ratio Dummy food type 2                                           
       using default value: 0.400000                                                                
       [NCRatF3             ] N:C ratio Dummy food type 3                                           
       using default value: 0.400000                                                                
       [NCRatF4             ] N:C ratio Dummy food type 4                                           
       using default value: 0.400000                                                                
       [NCRatF5             ] N:C ratio Dummy food type 5                                           
       using default value: 0.400000                                                                
       [NCRatF6             ] N:C ratio Dummy food type 6                                           
       using default value: 0.400000                                                                
       [NCRatF7             ] N:C ratio Dummy food type 7                                           
       using default value: 0.400000                                                                
       [NCRatF8             ] N:C ratio Dummy food type 8                                           
       using default value: 0.400000                                                                
       [PCRatGreen          ] P:C ratio Greens                                                      
       using default value: 0.200000E-01                                                            
       [PCRatDiat           ] P:C ratio Diatoms                                                     
       Using constant nr 33 with value: 0.900000E-02                                                
       [PCRAlg01            ] P:C ratio algae type 01                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg02            ] P:C ratio algae type 02                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg03            ] P:C ratio algae type 03                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg04            ] P:C ratio algae type 04                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg05            ] P:C ratio algae type 05                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg06            ] P:C ratio algae type 06                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg07            ] P:C ratio algae type 07                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg08            ] P:C ratio algae type 08                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg09            ] P:C ratio algae type 09                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg10            ] P:C ratio algae type 10                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg11            ] P:C ratio algae type 11                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg12            ] P:C ratio algae type 12                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg13            ] P:C ratio algae type 13                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg14            ] P:C ratio algae type 14                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg15            ] P:C ratio algae type 15                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg16            ] P:C ratio algae type 16                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg17            ] P:C ratio algae type 17                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg18            ] P:C ratio algae type 18                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg19            ] P:C ratio algae type 19                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg20            ] P:C ratio algae type 20                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg21            ] P:C ratio algae type 21                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg22            ] P:C ratio algae type 22                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg23            ] P:C ratio algae type 23                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg24            ] P:C ratio algae type 24                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg25            ] P:C ratio algae type 25                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg26            ] P:C ratio algae type 26                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg27            ] P:C ratio algae type 27                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg28            ] P:C ratio algae type 28                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg29            ] P:C ratio algae type 29                                               
       using default value: 0.200000E-01                                                            
       [PCRAlg30            ] P:C ratio algae type 30                                               
       using default value: 0.200000E-01                                                            
       [PCRatF1             ] P:C ratio Dummy food type 1                                           
       using default value: 0.200000E-01                                                            
       [PCRatF2             ] P:C ratio Dummy food type 2                                           
       using default value: 0.200000E-01                                                            
       [PCRatF3             ] P:C ratio Dummy food type 3                                           
       using default value: 0.200000E-01                                                            
       [PCRatF4             ] P:C ratio Dummy food type 4                                           
       using default value: 0.200000E-01                                                            
       [PCRatF5             ] P:C ratio Dummy food type 5                                           
       using default value: 0.200000E-01                                                            
       [PCRatF6             ] P:C ratio Dummy food type 6                                           
       using default value: 0.200000E-01                                                            
       [PCRatF7             ] P:C ratio Dummy food type 7                                           
       using default value: 0.200000E-01                                                            
       [PCRatF8             ] P:C ratio Dummy food type 8                                           
       using default value: 0.200000E-01                                                            
       [SCRatGreen          ] Si:C ratio Greens                                                     
       using default value:  0.00000                                                                
       [SCRatDiat           ] Si:C ratio Diatoms                                                    
       Using constant nr 32 with value: 0.140000                                                    
       [SCRAlg01            ] Si:C ratio algae type 01                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg02            ] Si:C ratio algae type 02                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg03            ] Si:C ratio algae type 03                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg04            ] Si:C ratio algae type 04                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg05            ] Si:C ratio algae type 05                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg06            ] Si:C ratio algae type 06                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg07            ] Si:C ratio algae type 07                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg08            ] Si:C ratio algae type 08                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg09            ] Si:C ratio algae type 09                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg10            ] Si:C ratio algae type 10                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg11            ] Si:C ratio algae type 11                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg12            ] Si:C ratio algae type 12                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg13            ] Si:C ratio algae type 13                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg14            ] Si:C ratio algae type 14                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg15            ] Si:C ratio algae type 15                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg16            ] Si:C ratio algae type 16                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg17            ] Si:C ratio algae type 17                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg18            ] Si:C ratio algae type 18                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg19            ] Si:C ratio algae type 19                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg20            ] Si:C ratio algae type 20                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg21            ] Si:C ratio algae type 21                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg22            ] Si:C ratio algae type 22                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg23            ] Si:C ratio algae type 23                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg24            ] Si:C ratio algae type 24                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg25            ] Si:C ratio algae type 25                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg26            ] Si:C ratio algae type 26                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg27            ] Si:C ratio algae type 27                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg28            ] Si:C ratio algae type 28                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg29            ] Si:C ratio algae type 29                                              
       using default value: 0.200000E-02                                                            
       [SCRAlg30            ] Si:C ratio algae type 30                                              
       using default value: 0.200000E-02                                                            
       [SCRatF1             ] Si:C ratio Dummy food type 1                                          
       using default value:  0.00000                                                                
       [SCRatF2             ] Si:C ratio Dummy food type 2                                          
       using default value:  0.00000                                                                
       [SCRatF3             ] Si:C ratio Dummy food type 3                                          
       using default value:  0.00000                                                                
       [SCRatF4             ] Si:C ratio Dummy food type 4                                          
       using default value:  0.00000                                                                
       [SCRatF5             ] Si:C ratio Dummy food type 5                                          
       using default value:  0.00000                                                                
       [SCRatF6             ] Si:C ratio Dummy food type 6                                          
       using default value:  0.00000                                                                
       [SCRatF7             ] Si:C ratio Dummy food type 7                                          
       using default value:  0.00000                                                                
       [SCRatF8             ] Si:C ratio Dummy food type 8                                          
       using default value:  0.00000                                                                
       [Z_PrGrn             ] Preference of DEB Zooplankton for Greens                              
       using default value:  1.00000                                                                
       [Z_PrDiat            ] Preference of DEB Zooplankton for Diatoms                             
       using default value:  1.00000                                                                
       [Z_PrAlg01           ] Preference of DEB Zooplankton for algae type 01                       
       using default value: 0.850000                                                                
       [Z_PrAlg02           ] Preference of DEB Zooplankton for algae type 02                       
       using default value: 0.850000                                                                
       [Z_PrAlg03           ] Preference of DEB Zooplankton for algae type 03                       
       using default value: 0.850000                                                                
       [Z_PrAlg04           ] Preference of DEB Zooplankton for algae type 04                       
       using default value: 0.500000                                                                
       [Z_PrAlg05           ] Preference of DEB Zooplankton for algae type 05                       
       using default value: 0.500000                                                                
       [Z_PrAlg06           ] Preference of DEB Zooplankton for algae type 06                       
       using default value: 0.500000                                                                
       [Z_PrAlg07           ] Preference of DEB Zooplankton for algae type 07                       
       using default value: 0.100000                                                                
       [Z_PrAlg08           ] Preference of DEB Zooplankton for algae type 08                       
       using default value: 0.100000                                                                
       [Z_PrAlg09           ] Preference of DEB Zooplankton for algae type 09                       
       using default value: 0.100000                                                                
       [Z_PrAlg10           ] Preference of DEB Zooplankton for algae type 10                       
       using default value: 0.300000                                                                
       [Z_PrAlg11           ] Preference of DEB Zooplankton for algae type 11                       
       using default value: 0.300000                                                                
       [Z_PrAlg12           ] Preference of DEB Zooplankton for algae type 12                       
       using default value: 0.300000                                                                
       [Z_PrAlg13           ] Preference of DEB Zooplankton for algae type 13                       
       using default value:  1.00000                                                                
       [Z_PrAlg14           ] Preference of DEB Zooplankton for algae type 14                       
       using default value:  1.00000                                                                
       [Z_PrAlg15           ] Preference of DEB Zooplankton for algae type 15                       
       using default value:  1.00000                                                                
       [Z_PrAlg16           ] Preference of DEB Zooplankton for algae type 16                       
       using default value:  1.00000                                                                
       [Z_PrAlg17           ] Preference of DEB Zooplankton for algae type 17                       
       using default value:  1.00000                                                                
       [Z_PrAlg18           ] Preference of DEB Zooplankton for algae type 18                       
       using default value:  1.00000                                                                
       [Z_PrAlg19           ] Preference of DEB Zooplankton for algae type 19                       
       using default value:  1.00000                                                                
       [Z_PrAlg20           ] Preference of DEB Zooplankton for algae type 20                       
       using default value:  1.00000                                                                
       [Z_PrAlg21           ] Preference of DEB Zooplankton for algae type 21                       
       using default value:  1.00000                                                                
       [Z_PrAlg22           ] Preference of DEB Zooplankton for algae type 22                       
       using default value:  1.00000                                                                
       [Z_PrAlg23           ] Preference of DEB Zooplankton for algae type 23                       
       using default value:  1.00000                                                                
       [Z_PrAlg24           ] Preference of DEB Zooplankton for algae type 24                       
       using default value:  1.00000                                                                
       [Z_PrAlg25           ] Preference of DEB Zooplankton for algae type 25                       
       using default value:  1.00000                                                                
       [Z_PrAlg26           ] Preference of DEB Zooplankton for algae type 26                       
       using default value:  1.00000                                                                
       [Z_PrAlg27           ] Preference of DEB Zooplankton for algae type 27                       
       using default value:  1.00000                                                                
       [Z_PrAlg28           ] Preference of DEB Zooplankton for algae type 28                       
       using default value:  1.00000                                                                
       [Z_PrAlg29           ] Preference of DEB Zooplankton for algae type 29                       
       using default value:  1.00000                                                                
       [Z_PrAlg30           ] Preference of DEB Zooplankton for algae type 30                       
       using default value:  1.00000                                                                
       [Z_Pr1               ] Preference of DEB Zooplankton for Dummy Food1                         
       using default value:  0.00000                                                                
       [Z_Pr2               ] Preference of DEB Zooplankton for Dummy Food2                         
       using default value:  0.00000                                                                
       [Z_Pr3               ] Preference of DEB Zooplankton for Dummy Food3                         
       using default value:  0.00000                                                                
       [Z_Pr4               ] Preference of DEB Zooplankton for Dummy Food4                         
       using default value:  0.00000                                                                
       [Z_Pr5               ] Preference of DEB Zooplankton for Dummy Food5                         
       using default value:  0.00000                                                                
       [Z_Pr6               ] Preference of DEB Zooplankton for Dummy Food6                         
       using default value:  0.00000                                                                
       [Z_Pr7               ] Preference of DEB Zooplankton for Dummy Food7                         
       using default value:  0.00000                                                                
       [Z_Pr8               ] Preference of DEB Zooplankton for Dummy Food8                         
       using default value:  0.00000                                                                
       [BenGrn              ] Use 0 [pelagic] or 1 [benthic] Greens                                 
       using default value:  0.00000                                                                
       [BenDiat             ] Use 0 [pelagic] or 1 [benthic] Diatoms                                
       using default value:  0.00000                                                                
       [BenAlg01            ] Use 0 [pelagic] or 1 [benthic] algae type 01                          
       using default value:  0.00000                                                                
       [BenAlg02            ] Use 0 [pelagic] or 1 [benthic] algae type 02                          
       using default value:  0.00000                                                                
       [BenAlg03            ] Use 0 [pelagic] or 1 [benthic] algae type 03                          
       using default value:  0.00000                                                                
       [BenAlg04            ] Use 0 [pelagic] or 1 [benthic] algae type 04                          
       using default value:  0.00000                                                                
       [BenAlg05            ] Use 0 [pelagic] or 1 [benthic] algae type 05                          
       using default value:  0.00000                                                                
       [BenAlg06            ] Use 0 [pelagic] or 1 [benthic] algae type 06                          
       using default value:  0.00000                                                                
       [BenAlg07            ] Use 0 [pelagic] or 1 [benthic] algae type 07                          
       using default value:  0.00000                                                                
       [BenAlg08            ] Use 0 [pelagic] or 1 [benthic] algae type 08                          
       using default value:  0.00000                                                                
       [BenAlg09            ] Use 0 [pelagic] or 1 [benthic] algae type 09                          
       using default value:  0.00000                                                                
       [BenAlg10            ] Use 0 [pelagic] or 1 [benthic] algae type 10                          
       using default value:  0.00000                                                                
       [BenAlg11            ] Use 0 [pelagic] or 1 [benthic] algae type 11                          
       using default value:  0.00000                                                                
       [BenAlg12            ] Use 0 [pelagic] or 1 [benthic] algae type 12                          
       using default value:  0.00000                                                                
       [BenAlg13            ] Use 0 [pelagic] or 1 [benthic] algae type 13                          
       using default value:  0.00000                                                                
       [BenAlg14            ] Use 0 [pelagic] or 1 [benthic] algae type 14                          
       using default value:  0.00000                                                                
       [BenAlg15            ] Use 0 [pelagic] or 1 [benthic] algae type 15                          
       using default value:  0.00000                                                                
       [BenAlg16            ] Use 0 [pelagic] or 1 [benthic] algae type 16                          
       using default value:  0.00000                                                                
       [BenAlg17            ] Use 0 [pelagic] or 1 [benthic] algae type 17                          
       using default value:  0.00000                                                                
       [BenAlg18            ] Use 0 [pelagic] or 1 [benthic] algae type 18                          
       using default value:  0.00000                                                                
       [BenAlg19            ] Use 0 [pelagic] or 1 [benthic] algae type 19                          
       using default value:  0.00000                                                                
       [BenAlg20            ] Use 0 [pelagic] or 1 [benthic] algae type 20                          
       using default value:  0.00000                                                                
       [BenAlg21            ] Use 0 [pelagic] or 1 [benthic] algae type 21                          
       using default value:  0.00000                                                                
       [BenAlg22            ] Use 0 [pelagic] or 1 [benthic] algae type 22                          
       using default value:  0.00000                                                                
       [BenAlg23            ] Use 0 [pelagic] or 1 [benthic] algae type 23                          
       using default value:  0.00000                                                                
       [BenAlg24            ] Use 0 [pelagic] or 1 [benthic] algae type 24                          
       using default value:  0.00000                                                                
       [BenAlg25            ] Use 0 [pelagic] or 1 [benthic] algae type 25                          
       using default value:  0.00000                                                                
       [BenAlg26            ] Use 0 [pelagic] or 1 [benthic] algae type 26                          
       using default value:  0.00000                                                                
       [BenAlg27            ] Use 0 [pelagic] or 1 [benthic] algae type 27                          
       using default value:  0.00000                                                                
       [BenAlg28            ] Use 0 [pelagic] or 1 [benthic] algae type 28                          
       using default value:  0.00000                                                                
       [BenAlg29            ] Use 0 [pelagic] or 1 [benthic] algae type 29                          
       using default value:  0.00000                                                                
       [BenAlg30            ] Use 0 [pelagic] or 1 [benthic] algae type 30                          
       using default value:  0.00000                                                                
       [Ben1                ] Use 0 [pelagic] or 1 [benthic] Dummy Food1                            
       using default value:  1.00000                                                                
       [Ben2                ] Use 0 [pelagic] or 1 [benthic] Dummy Food2                            
       using default value:  1.00000                                                                
       [Ben3                ] Use 0 [pelagic] or 1 [benthic] Dummy Food3                            
       using default value:  1.00000                                                                
       [Ben4                ] Use 0 [pelagic] or 1 [benthic] Dummy Food4                            
       using default value:  1.00000                                                                
       [Ben5                ] Use 0 [pelagic] or 1 [benthic] Dummy Food5                            
       using default value:  1.00000                                                                
       [Ben6                ] Use 0 [pelagic] or 1 [benthic] Dummy Food6                            
       using default value:  1.00000                                                                
       [Ben7                ] Use 0 [pelagic] or 1 [benthic] Dummy Food7                            
       using default value:  1.00000                                                                
       [Ben8                ] Use 0 [pelagic] or 1 [benthic] Dummy Food8                            
       using default value:  1.00000                                                                
       [Z_FFGrn             ]  Faecal fraction Greens for DEB Zooplankton                           
       using default value: 0.500000                                                                
       [Z_FFDiat            ]  Faecal fraction Diatoms for DEB Zooplankton                          
       using default value: 0.500000                                                                
       [Z_ALGFF01           ]  Faecal fraction Alg01 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF02           ]  Faecal fraction Alg02 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF03           ]  Faecal fraction Alg03 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF04           ]  Faecal fraction Alg04 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF05           ]  Faecal fraction Alg05 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF06           ]  Faecal fraction Alg06 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF07           ]  Faecal fraction Alg07 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF08           ]  Faecal fraction Alg08 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF09           ]  Faecal fraction Alg09 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF10           ]  Faecal fraction Alg10 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF11           ]  Faecal fraction Alg11 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF12           ]  Faecal fraction Alg12 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF13           ]  Faecal fraction Alg13 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF14           ]  Faecal fraction Alg14 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF15           ]  Faecal fraction Alg15 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF16           ]  Faecal fraction Alg16 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF17           ]  Faecal fraction Alg17 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF18           ]  Faecal fraction Alg18 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF19           ]  Faecal fraction Alg19 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF20           ]  Faecal fraction Alg20 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF21           ]  Faecal fraction Alg21 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF22           ]  Faecal fraction Alg22 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF23           ]  Faecal fraction Alg23 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF24           ]  Faecal fraction Alg24 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF25           ]  Faecal fraction Alg25 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF26           ]  Faecal fraction Alg26 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF27           ]  Faecal fraction Alg27 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF28           ]  Faecal fraction Alg28 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF29           ]  Faecal fraction Alg29 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_ALGFF30           ]  Faecal fraction Alg30 for DEB Zooplankton                            
       using default value: 0.500000                                                                
       [Z_FF01              ]  Faecal fraction Dummy Food1 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF02              ]  Faecal fraction Dummy Food2 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF03              ]  Faecal fraction Dummy Food3 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF04              ]  Faecal fraction Dummy Food4 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF05              ]  Faecal fraction Dummy Food5 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF06              ]  Faecal fraction Dummy Food6 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF07              ]  Faecal fraction Dummy Food7 for DEB Zoopl                            
       using default value: 0.500000                                                                
       [Z_FF08              ]  Faecal fraction Dummy Food8 for DEB Zoopl                            
       using default value: 0.500000                                                                
                                                                                                    
 Input for [NutUpt_Alg          ] Uptake of nutrients by growth of algae                            
       [fcPPGreeN           ] numerical maximum flux Greens                                         
       Using output from proces [PPrLim              ]                                              
       [NCRatGreen          ] N:C ratio Greens                                                      
       using default value: 0.160000                                                                
       [PCRatGreen          ] P:C ratio Greens                                                      
       using default value: 0.200000E-01                                                            
       [fcPPDiat            ] numerical maximum flux Diatoms                                        
       Using output from proces [PPrLim              ]                                              
       [NCRatDiat           ] N:C ratio Diatoms                                                     
       Using constant nr 34 with value: 0.150000                                                    
       [PCRatDiat           ] P:C ratio Diatoms                                                     
       Using constant nr 33 with value: 0.900000E-02                                                
       [SCRatDiat           ] Si:C ratio Diatoms                                                    
       Using constant nr 32 with value: 0.140000                                                    
       [DELT                ] timestep for processes                                                
       Using DELWAQ timestep in days                                                                
       [NH4                 ] Ammonium (NH4)                                                        
       Using substance nr   2                                                                       
       [NO3                 ] Nitrate (NO3)                                                         
       Using substance nr   3                                                                       
       [NH4KRIT             ] critical NH4 concentration                                            
       using default value: 0.100000E-01                                                            
                                                                                                    
 Input for [PPrLim              ] Limitation (numerical) on primary production                      
       [fPPGreen            ] net primary production of Greens                                      
       Using constant nr 20 with value:  0.00000                                                    
       [NCRatGreen          ] N:C ratio Greens                                                      
       using default value: 0.160000                                                                
       [PCRatGreen          ] P:C ratio Greens                                                      
       using default value: 0.200000E-01                                                            
       [fPPDiat             ] net primary production of Diatoms                                     
       Using output from proces [GroMrt_Dia          ]                                              
       [NCRatDiat           ] N:C ratio Diatoms                                                     
       Using constant nr 34 with value: 0.150000                                                    
       [PCRatDiat           ] P:C ratio Diatoms                                                     
       Using constant nr 33 with value: 0.900000E-02                                                
       [SCRatDiat           ] Si:C ratio Diatoms                                                    
       Using constant nr 32 with value: 0.140000                                                    
       [DELT                ] timestep for processes                                                
       Using DELWAQ timestep in days                                                                
       [NH4                 ] Ammonium (NH4)                                                        
       Using substance nr   2                                                                       
       [NO3                 ] Nitrate (NO3)                                                         
       Using substance nr   3                                                                       
       [PO4                 ] Ortho-Phosphate (PO4)                                                 
       Using substance nr   4                                                                       
       [Si                  ] dissolved Silica (Si)                                                 
       Using substance nr   5                                                                       
                                                                                                    
 Input for [GroMrt_Dia          ] Nett primary production and mortality diatoms                     
       [Diat                ] Diatoms                                                               
       Using substance nr   1                                                                       
       [LimDLdiat           ] daylength limitation function for Diatoms <0-1>                       
       using default value:  1.00000                                                                
       [LimNutDiat          ] nutrient limitation function Diatoms <0-1>                            
       Using output from proces [NLDiat              ]                                              
       [LimRadDiat          ] radiation limitation function Diatoms <0-1>                           
       Using output from proces [Rad_Diat            ]                                              
       [TFGroDiat           ] temperature function growth Diatoms <0-1>                             
       using default value:  1.00000                                                                
       [TFMrtDiat           ] temperature function mortality Diatoms <0-1>                          
       using default value:  1.00000                                                                
       [PPMaxDiat           ] maximum production rate Diatoms                                       
       Using constant nr 21 with value:  1.60000                                                    
       [MRespDiat           ] maintenance respiration Diatoms st.temp                               
       using default value: 0.360000E-01                                                            
       [GRespDiat           ] growth respiration factor Diatoms                                     
       using default value: 0.110000                                                                
       [Mort0Diat           ] mortality rate constant Diatoms                                       
       Using constant nr 27 with value: 0.700000E-01                                                
       [MortSDiat           ] mortality rate Diatoms at high salinity                               
       Using constant nr 28 with value: 0.700000E-01                                                
       [SalM1Diat           ] lower salinity limit for mortality Diatoms                            
       Using constant nr 30 with value:  18.0000                                                    
       [SalM2Diat           ] upper salinity limit for mortality Diatoms                            
       Using constant nr 31 with value:  35.0000                                                    
       [Salinity            ] Salinity                                                              
       Using segment function nr  3                                                                 
       [MinDiat             ] Minimum level Diatoms in mortality                                    
       Using constant nr 29 with value: 0.200000E-01                                                
                                                                                                    
 Input for [Rad_Diat            ] Light efficiency function diatoms                                 
       [Depth               ] depth of segment                                                      
       Using output from proces [DynDepth            ]                                              
       [Rad                 ] irradiation at the segment upper-boundary                             
       Using output from proces [CalcRad             ]                                              
       [RadSatDiat          ] total radiation growth saturation Diatoms                             
       Using constant nr 22 with value:  120.000                                                    
       [ExtVl               ] total extinction coefficient visible light                            
       Using function nr  2                                                                         
       [TFGroDiat           ] temperature function growth Diatoms <0-1>                             
       using default value:  1.00000                                                                
                                                                                                    
 Input for [NLDiat              ] Nutrient limiation function for diatoms                           
       [PrfNH4diat          ] ammonium preferency over nitrate Diatoms                              
       using default value:  1.00000                                                                
       [KMDINdiat           ] half-saturation value N Diatoms                                       
       Using constant nr 23 with value: 0.100000E-01                                                
       [KMPdiat             ] half-saturation value P Diatoms                                       
       Using constant nr 24 with value: 0.300000E-02                                                
       [KMSidiat            ] half-saturation value Si Diatoms                                      
       Using constant nr 25 with value: 0.500000E-01                                                
       [NH4                 ] Ammonium (NH4)                                                        
       Using substance nr   2                                                                       
       [NO3                 ] Nitrate (NO3)                                                         
       Using substance nr   3                                                                       
       [PO4                 ] Ortho-Phosphate (PO4)                                                 
       Using substance nr   4                                                                       
       [Si                  ] dissolved Silica (Si)                                                 
       Using substance nr   5                                                                       
                                                                                                    
 Input for [RearOXY             ] Reaeration of oxygen                                              
       [OXY                 ] Dissolved Oxygen                                                      
       Using substance nr   7                                                                       
       [Depth               ] depth of segment                                                      
       Using output from proces [DynDepth            ]                                              
       [Temp                ] ambient water temperature                                             
       Using segment function nr  2                                                                 
       [Velocity            ] horizontal flow velocity                                              
       using default value: 0.500000                                                                
       [VWind               ] wind speed                                                            
       Using constant nr 18 with value:  2.00000                                                    
       [SWRear              ] switch for oxygen reaeration formulation (1-13)                       
       using default value:  1.00000                                                                
       [KLRear              ] reaeration transfer coefficient                                       
       using default value:  1.00000                                                                
       [TCRear              ] temperature coefficient for rearation                                 
       using default value:  1.01600                                                                
       [DELT                ] timestep for processes                                                
       Using DELWAQ timestep in days                                                                
       [SaturOXY            ] saturation concentration                                              
       Using output from proces [SaturOXY            ]                                              
       [Salinity            ] Salinity                                                              
       Using segment function nr  3                                                                 
       [TotalDepth          ] total depth water column                                              
       Using output from proces [TotDepth            ]                                              
       [fcover              ] fraction of water surface covered <0-1>                               
       using default value:  0.00000                                                                
       [KLRearMax           ] maximum KLREAR oxygen for temp. correction                            
       using default value:  1000.00                                                                
       [KLRearMin           ] minimum rearation transfer coefficient oxygen                         
       using default value: 0.200000                                                                
       [Rain                ] rainfall rate                                                         
       using default value:  0.00000                                                                
       [coefAOxy            ] gas transfer Oxy coefficient transmission                             
       using default value:  1.66000                                                                
       [coefB1Oxy           ] gas transfer O2 coefficient wind scale 1                              
       using default value: 0.260000                                                                
       [coefB2Oxy           ] gas transfer O2 coefficient wind scale 2                              
       using default value:  1.00000                                                                
       [coefC1Oxy           ] gas transfer O2 coefficient rain scale 1                              
       using default value: 0.660000                                                                
       [coefC2Oxy           ] gas transfer O2 coefficient rain scale 2                              
       using default value:  1.00000                                                                
       [coefD1Oxy           ] fresh water coefficient1 for Schmidt nr Oxy                           
       using default value:  1800.06                                                                
       [coefD2Oxy           ] fresh water coefficient2 for Schmidt nr Oxy                           
       using default value:  120.100                                                                
       [coefD3Oxy           ] fresh water coefficient3 for Schmidt nr Oxy                           
       using default value:  3.78180                                                                
       [coefD4Oxy           ] fresh water coefficient4 for Schmidt nr Oxy                           
       using default value: 0.476080E-01                                                            
                                                                                                    
 Input for [SaturOXY            ] Saturation concentration oxygen                                   
       [Cl                  ] Chloride                                                              
       using default value:  20000.0                                                                
       [Temp                ] ambient water temperature                                             
       Using segment function nr  2                                                                 
       [SWSatOXY            ] switch for oxygen saturation formulation (1, 2)                       
       using default value:  1.00000                                                                
       [Salinity            ] Salinity                                                              
       Using segment function nr  3                                                                 
                                                                                                    
 Input for [Nitrif_NH4          ] Nitrification of ammonium                                         
       [ZNit                ] zeroth-order nitrification flux                                       
       using default value:  0.00000                                                                
       [NH4                 ] Ammonium (NH4)                                                        
       Using substance nr   2                                                                       
       [RcNit20             ] MM- nitrification rate at 20 oC                                       
       using default value: 0.100000                                                                
       [TcNit               ] temperature coefficient for nitrification                             
       using default value:  1.07000                                                                
       [OXY                 ] Dissolved Oxygen                                                      
       Using substance nr   7                                                                       
       [KsAmNit             ] half saturation constant for ammonium cons.                           
       using default value: 0.500000                                                                
       [KsOxNit             ] half saturation constant for DO cons.                                 
       using default value:  1.00000                                                                
       [Temp                ] ambient water temperature                                             
       Using segment function nr  2                                                                 
       [CTNit               ] critical temperature for nitrification                                
       using default value:  3.00000                                                                
       [Rc0NitOx            ] zero-order nitrification rate at neg. DO                              
       using default value:  0.00000                                                                
       [COXNIT              ] critical oxygen concentration for nitrification                       
       using default value:  1.00000                                                                
       [Poros               ] volumetric porosity                                                   
       using default value:  1.00000                                                                
       [SWVnNit             ] switch for old (0), new (1), TEWOR (2) version                        
       using default value:  0.00000                                                                
       [RcNit               ] first-order nitrification rate                                        
       Using parameter nr  1                                                                        
       [OOXNIT              ] optimum oxygen concentration for nitrification                        
       using default value:  5.00000                                                                
       [CFLNIT              ] oxygen function level for oxygen below COXNIT                         
       using default value:  0.00000                                                                
       [CurvNit             ] curvature of DO function for nitrification                            
       using default value:  0.00000                                                                
       [DELT                ] timestep for processes                                                
       Using DELWAQ timestep in days                                                                
                                                                                                    
 Input for [DenWat_NO3          ] Denitrification in water column                                   
       [ZDenWat             ] zero-order denitrification rate in water column                       
       using default value:  0.00000                                                                
       [NO3                 ] Nitrate (NO3)                                                         
       Using substance nr   3                                                                       
       [RcDen20             ] MM-denitrification reaction rate at 20 oC                             
       using default value: 0.100000                                                                
       [TcDenWat            ] temperature coefficient for denitrification                           
       using default value:  1.07000                                                                
       [OXY                 ] Dissolved Oxygen                                                      
       Using substance nr   7                                                                       
       [KsNiDen             ] half saturation constant for nitrate cons.                            
       using default value: 0.500000                                                                
       [KsOxDen             ] half saturation constant for oxygen inhib.                            
       using default value:  1.00000                                                                
       [Temp                ] ambient water temperature                                             
       Using segment function nr  2                                                                 
       [CTDEN               ] critical temperature for denitrification                              
       using default value:  2.00000                                                                
       [Rc0DenOx            ] zero-order denit. rate at low temperature                             
       using default value:  0.00000                                                                
       [COXDEN              ] critical oxygen concentration for denitrification                     
       using default value:  3.00000                                                                
       [Poros               ] volumetric porosity                                                   
       using default value:  1.00000                                                                
       [SWVnDen             ] switch to select old (0) or new (1) version                           
       using default value:  0.00000                                                                
       [RcDenWat            ] first-order denitrification rate in water column                      
       Using parameter nr  3                                                                        
       [OOXDEN              ] optimum oxygen concentration for denitrification                      
       using default value:  1.00000                                                                
       [Curvat              ] curvature of DO function for denitrification                          
       using default value:  1.00000                                                                
                                                                                                    
 Input for [DenSed_NO3          ] Denitrification in sediment                                       
       [ZDenSed             ] zeroth-order denitrification flux in the sediment                     
       using default value:  0.00000                                                                
       [NO3                 ] Nitrate (NO3)                                                         
       Using substance nr   3                                                                       
       [RcDenSed            ] first-order denitrification rate in the sediment                      
       Using parameter nr  2                                                                        
       [TcDen               ] temperature coefficient for denitrification                           
       using default value:  1.12000                                                                
       [Temp                ] ambient water temperature                                             
       Using segment function nr  2                                                                 
       [CTDEN               ] critical temperature for denitrification                              
       using default value:  2.00000                                                                
       [Depth               ] depth of segment                                                      
       Using output from proces [DynDepth            ]                                              
                                                                                                    
 Input for [Phy_dyn             ] Computation of phytoplankton - Dynamo                             
       [NAlgDynamo          ] number of algae types in DYNAMO                                       
       using default value:  2.00000                                                                
       [Diat                ] Diatoms                                                               
       Using substance nr   1                                                                       
       [Green               ] Algae (non-Diatoms)                                                   
       using default value:  0.00000                                                                
       [NCRatDiat           ] N:C ratio Diatoms                                                     
       Using constant nr 34 with value: 0.150000                                                    
       [NCRatGreen          ] N:C ratio Greens                                                      
       using default value: 0.160000                                                                
       [PCRatDiat           ] P:C ratio Diatoms                                                     
       Using constant nr 33 with value: 0.900000E-02                                                
       [PCRatGreen          ] P:C ratio Greens                                                      
       using default value: 0.200000E-01                                                            
       [SCRatDiat           ] Si:C ratio Diatoms                                                    
       Using constant nr 32 with value: 0.140000                                                    
       [SCRatGreen          ] Si:C ratio Greens                                                     
       using default value:  0.00000                                                                
       [DMCFDiat            ] DM:C ratio Diatoms                                                    
       using default value:  2.50000                                                                
       [DMCFGreen           ] DM:C ratio GreenS                                                     
       using default value:  2.50000                                                                
       [Ditochl             ] Chlorophyll-a:C ratio in Diatoms                                      
       using default value:  50.0000                                                                
       [Grtochl             ] Chlorophyll-a:C ratio in Greens                                       
       using default value:  50.0000                                                                
                                                                                                    
 Input for [CalcRad             ] Radiation at segment upper and lower boundaries                   
       [ExtVl               ] total extinction coefficient visible light                            
       Using function nr  2                                                                         
       [Depth               ] depth of segment                                                      
       Using output from proces [DynDepth            ]                                              
       [RadSurf             ] irradiation at the water surface                                      
       Using function nr  1                                                                         
       [a_enh               ] enhancement factor in radiation calculation                           
       using default value:  1.50000                                                                
       [Surf                ] horizontal surface area of a DELWAQ segment                           
       Using parameter nr  4                                                                        
       [SwEmersion          ] switch indicating submersion(0) or emersion(1)                        
       using default value:  0.00000                                                                
       [RadBot              ] irradiation at the segment lower-boundary                             
       Using output from proces [CalcRad             ]                                              
       [fRefl               ] fraction of radiation reflected at water surface                      
       Using constant nr 48 with value: 0.100000                                                    
                                                                                                    
 Input for [VertDisp            ] Vertical dispersion (segment -> exchange)                         
       [VertDisper          ] vertical dispersion                                                   
       Using segment function nr  1                                                                 
       [ScaleVdisp          ] scaling factor for vertical diffusion                                 
       Using constant nr 19 with value: 0.230000E-01                                                
                                                                                                    
 Input for [TotDepth            ] depth water column                                                
       [Depth               ] depth of segment                                                      
       Using output from proces [DynDepth            ]                                              
       [Surf                ] horizontal surface area of a DELWAQ segment                           
       Using parameter nr  4                                                                        
                                                                                                    
 Input for [DynDepth            ] dynamic calculation of the depth                                  
       [Volume              ] volume of computational cell                                          
       Using DELWAQ volume                                                                          
       [Surf                ] horizontal surface area of a DELWAQ segment                           
       Using parameter nr  4                                                                        
                                                                                                    
# determining the use of the delwaq input                                       
                                                                                
 info: constant [Tolerance ] is not used by the proces system                   
 info: constant [TcDecDiat ] is not used by the proces system                   
 info: constant [NOTHREADS ] is not used by the proces system                   
 info: constant [TimMultBl ] is not used by the proces system                   
                                                                                
# locating requested output from active processes                                                   
                                                                                                    
 output [LocalDepth          ] from proces [TotDepth  ]                                             
 output [Chlfa               ] from proces [Phy_dyn   ]                                             
 output [Phyt                ] from proces [Phy_dyn   ]                                             
 output [Rad                 ] from proces [CalcRad   ]                                             
 output [TotalDepth          ] from proces [TotDepth  ]                                             
 output [depth               ] from proces [DynDepth  ]                                             
 output [fppDiat             ] from proces [GroMrt_Dia]                                             
                                                                                                    
