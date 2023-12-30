Param(
  #[parameter(mandatory=$true)][String]$File
  [String]$file
)

$v = [pscustomobject]@{
  In = 0; Out = 0; Total = 0;
  InMax = $null; OutMax = $null
}

$a = .\Parse.ps1 $file

$a | ? { $_.IO -eq "In" } | % { $v.In = $v.In + $_.Price }

$a | ? { $_.IO -eq "Out" } | % { $v.Out = $v.Out + $_.Price }

$a | ? { $_.IO -eq "In" } |
  % { if ($v.InMax.Price -lt $_.Price) { $v.InMax = $_ } }

$a | ? { $_.IO -eq "Out" } |
  % { if ($v.OutMax.Price -lt $_.Price) { $v.OutMax = $_ } }

$v.Total = $v.In - $v.Out

if ($v.InMax) {
  $v.InMax = "{0} {1} {2} {3}" -f $v.InMax.Date, $v.InMax.Price, $v.InMax.Place, $v.InMax.Detail
}

if ($v.OutMax) {
  $v.OutMax = "{0} {1} {2} {3}" -f $v.OutMax.Date, $v.OutMax.Price, $v.OutMax.Place, $v.OutMax.Detail
}


return $v


#function MaxObject($x) {
#  $max = [pscustomobject]@{
#    Date = $x.Date; Price = $x.Price; Place = $x.Place; Detail = $x.Detail 
#  }
#  return $max
#}
#.\Parse.ps1 $file | % { 
#  $x = $_
#  switch ($x.IO) {
#    "IN" { 
#        $v.In = $v.In + $x.Price 
#        if ($v.InMax.Price -lt $x.Price) {
#          $v.InMax = MaxObject($x)
#        }
#      }
#    "OUT" {
#        $v.Out = $v.Out + $x.Price
#        if ($v.OutMax.Price -lt $x.Price) {
#          $v.OutMax = MaxObject($x)
#        }
#      }
#    default { echo "illegal IO: $x" }
#  }
#}

