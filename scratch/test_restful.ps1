# test_restful.ps1
$body = '{"name": "Ngoctu Guestbook", "data": {"wishes": [{"name": "Ban A", "message": "Chuc mung Tu"}]}}'
try {
  $res = Invoke-RestMethod -Uri 'https://api.restful-api.dev/objects' -Method Post -Body $body -ContentType 'application/json'
  Write-Host "restful-api result: $($res | ConvertTo-Json -Compress)"
} catch {
  Write-Host "restful-api error: $($_.Exception.Message)"
}
