Param(
  #[parameter(mandatory=$true)][String]$File
  [String]$file = "",
  [String]$io = "",
  [String]$place = "",
  [String]$detail = "",
  [String]$notplace = "",
  [String]$notdetail = ""
)

# example
# ./Sum.ps1 -File 2020 -IO In
# ./Sum.ps1 -File 2020 -IO In -Detail Wages
# ./Sum.ps1 -File 2020 -IO In -Place Merucari
# ./Sum.ps1 -File 2020 -IO Out 
# ./Sum.ps1 -File 2020 -IO Out -Place Amazon -Detail Kindle
# ./Sum.ps1 -File 2020 -IO Out -NotPlace Amazon

$sum = 0

ls |
  ? { $_.Name -match "$($file).*\.txt$" } |
  % { .\Parse.ps1 $_.Name } |
  ? { $_.IO -eq $io -and $_.Place -match $place -and $_.Detail -match $detail } |
  ? { $notplace -eq "" -or $_.Place -notmatch $notplace } |
  ? { $notdetail -eq "" -or $_.Detail -notmatch $notdetail } |
  % { $sum += $_.Price }

$sum
