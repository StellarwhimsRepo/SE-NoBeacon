
    $filePath = 'your save path here\SANDBOX_0_0_0_.sbs'
    
    [xml]$myXML = Get-Content $filePath
    $ns = New-Object System.Xml.XmlNamespaceManager($myXML.NameTable)
    $ns.AddNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")
    
    
    #delete grid if no beacon.
    $nodes = $myXML.SelectNodes("//SectorObjects/MyObjectBuilder_EntityBase[(@xsi:type='MyObjectBuilder_CubeGrid')]"  , $ns) 
    ForEach($node in $nodes){
        $beaconcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[@xsi:type='MyObjectBuilder_Beacon']", $ns).count
            IF($beaconcount -eq 0){
                 $node.ParentNode.RemoveChild($node)
            }
    }


    $myXML.Save($filePath)