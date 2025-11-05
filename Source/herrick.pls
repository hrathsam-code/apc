sFilename   dim     260
bStop       form    1

plfHerrick  plform  Herrick.plf

    winhide
    formload plfHerrick
    loop
        eventwait
    repeat until ( bStop )
    stop
    
wnMain_Load
    pack    sFilename with "c:\data\herrick.xml"
    tvMain.LoadXMLFile USING *FileName=sFilename
    return

wnMain_close
    set     bStop
    return
        
