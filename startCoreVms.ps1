function startupBaseVMs(){
$vmsToStart = @("H36HALN6SUJKGR4VBBCTNG9DKUB12IMB", "AVHB6DIUSLOA9KM9KUCM6R1SLVCA4SKS", "Q59VIV7H78UU0JU91Q7T07ER9GL0HDT1","D5G1T7D885D27U5QIMMRB706HOEG9BFN","2GR6FG37063FHG4MLI0BMUG6FNSQ2SOI")

$header2 = @{
            "Accept"="application/json"
            "Authorization"= 'Basic YmlsbDpHb2xmYXoxMjM0ISE='
            "Content-Type"="application/vnd.vmware.vmw.rest-v1+json"
            } 

foreach($vm in $vmsToStart){
Write-Host $vm
Invoke-WebRequest -Method 'PUT' -Uri "http://127.0.0.1:8697/api/vms/$vm/power" -Headers $header2 -Body "on"
}

}

#Start-Process cmd -FilePath "C:\Program Files (x86)\VMware\VMware Workstation\vmrest.exe" 

startupBaseVMs