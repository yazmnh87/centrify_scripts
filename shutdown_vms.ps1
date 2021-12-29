
function shutoffvms(){
$authToken = 'Basic YmlsbDpHb2xmYXoxMjM0ISE='

$headers = @{
    Authorization= $authToken
}

$res = Invoke-WebRequest -Method 'GET' -Uri "http://127.0.0.1:8697/api/vms" -Headers $headers


$text= "HTTP/1.1 200 OK
Content-Length: 3398
Cache-Control: no-cache
Content-Type: application/vnd.vmware.vmw.rest-v1+json
Date: Mon, 11 Oct 2021 19:27:14 GMT

"
  
$test = $res.RawContent.Substring(158) | Out-String | ConvertFrom-Json

$headers1 = @{
    Authorization= $authToken
}



foreach($r in $test){
    Write-Host $r.id
    $id = $r.id
    Write-Host "http://127.0.0.1:8697/api/vms/$id/power"

    $res1 = Invoke-WebRequest -Method 'GET' -Uri "http://127.0.0.1:8697/api/vms/$id/power" -Headers $headers1
    $converted = $res1.RawContent.Substring(154) | Out-String | ConvertFrom-Json
    Write-Host $converted
    if($converted.power_state -eq "poweredOn"){
    Write-Host $converted.power_state

    $header2 = @{
            "Accept"="application/json"
            "Authorization"= $authToken
            "Content-Type"="application/vnd.vmware.vmw.rest-v1+json"
            } 

        
        Invoke-WebRequest -Method 'PUT' -Uri "http://127.0.0.1:8697/api/vms/$id/power" -Headers $header2 -Body "suspend"
    }

}
}

function testport ($hostname='localhost',$port=8697,$timeout=100) {
  $requestCallback = $state = $null
  $client = New-Object System.Net.Sockets.TcpClient
  $beginConnect = $client.BeginConnect($hostname,$port,$requestCallback,$state)
  Start-Sleep -milli $timeOut
  if ($client.Connected) { $open = $true } else { $open = $false }
  $client.Close()
  [pscustomobject]@{hostname=$hostname;port=$port;open=$open}
}



Start-Process cmd -FilePath "C:\Program Files (x86)\VMware\VMware Workstation\vmrest.exe" 
sleep 5
$result = testport
write-host $result



while(!$result.open){
sleep 1
$result = testport

}


if($result.open){
shutoffvms
}










