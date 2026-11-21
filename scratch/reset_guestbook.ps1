# reset_guestbook.ps1
$id = "ff808181a09d98f701a1fe4fe584112c"
$body = '{"name": "Ngoctu Graduation Guestbook 2026", "data": {"wishes": []}}'
$putObj = Invoke-RestMethod -Uri "https://api.restful-api.dev/objects/$id" -Method Put -Body $body -ContentType 'application/json'
Write-Host "Reset guestbook: $($putObj.data.wishes.Count) wishes"
