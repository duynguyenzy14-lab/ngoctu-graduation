# test_jsonhosting.ps1
$body = '{"wishes":[]}'
try {
  $res = Invoke-RestMethod -Uri 'https://jsonhosting.com/api/json' -Method Post -Body $body -ContentType 'application/json'
  Write-Host "jsonhosting result: $($res | ConvertTo-Json -Compress)"
} catch {
  Write-Host "jsonhosting error: $($_.Exception.Message)"
}
