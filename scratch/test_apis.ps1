# test_apis.ps1
$body = '{"wishes":[]}'

# 1. Test npoint.io
try {
  $res1 = Invoke-RestMethod -Uri 'https://api.npoint.io' -Method Post -Body $body -ContentType 'application/json'
  Write-Host "npoint result: $($res1 | ConvertTo-Json -Compress)"
} catch {
  Write-Host "npoint error: $($_.Exception.Message)"
}

# 2. Test kvdb.io
try {
  $bucket = Invoke-RestMethod -Uri 'https://kvdb.io' -Method Post
  Write-Host "kvdb bucket: $bucket"
  if ($bucket) {
    Invoke-RestMethod -Uri "https://kvdb.io/$bucket/wishes" -Method Put -Body $body -ContentType 'application/json'
    $getKv = Invoke-RestMethod -Uri "https://kvdb.io/$bucket/wishes"
    Write-Host "kvdb test get: $($getKv | ConvertTo-Json -Compress)"
  }
} catch {
  Write-Host "kvdb error: $($_.Exception.Message)"
}
