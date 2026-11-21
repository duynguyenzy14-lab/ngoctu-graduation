# test_extendsclass.ps1
$body = '{"wishes":[]}'
try {
  $res = Invoke-RestMethod -Uri 'https://json-storage.extendsclass.com/bin' -Method Post -Body $body -ContentType 'application/json'
  Write-Host "extendsclass result: $($res | ConvertTo-Json -Compress)"
} catch {
  Write-Host "extendsclass error: $($_.Exception.Message)"
}
