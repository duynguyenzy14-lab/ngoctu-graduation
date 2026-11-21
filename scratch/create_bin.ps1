# create_bin.ps1
$body = '{"wishes":[]}'
try {
  $res = Invoke-RestMethod -Uri 'https://api.jsonstorage.net/v1/json' -Method Post -Body $body -ContentType 'application/json'
  Write-Host "Created jsonstorage uri: $($res.uri)"
} catch {
  Write-Host "Error: $($_.Exception.Message)"
}
