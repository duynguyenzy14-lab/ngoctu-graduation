$t = [IO.File]::ReadAllText('C:\Users\Tu Nguyen\OneDrive\Documents\GitHub\ngoctu-graduation\graduation_files\style.css')
$o = $t.Split('{').Length - 1
$c = $t.Split('}').Length - 1
Write-Host ("{ = " + $o + "  } = " + $c + "  Match: " + ($o -eq $c))
