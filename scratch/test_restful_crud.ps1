# test_restful_crud.ps1
$id = "ff808181a09d98f701a1fe4fe584112c"
try {
  $getObj = Invoke-RestMethod -Uri "https://api.restful-api.dev/objects/$id"
  Write-Host "GET success: $($getObj.name)"
  
  $newBody = '{"name": "Ngoctu Guestbook", "data": {"wishes": [{"name": "Ban A", "message": "Chuc mung Tu"}, {"name": "Ban B", "message": "Hen gap 28.11"}]}}'
  $putObj = Invoke-RestMethod -Uri "https://api.restful-api.dev/objects/$id" -Method Put -Body $newBody -ContentType 'application/json'
  Write-Host "PUT success: $($putObj.data.wishes.Count) wishes"
} catch {
  Write-Host "Error: $($_.Exception.Message)"
}
