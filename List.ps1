Param(
  #[parameter(mandatory=$true)][String]$File
  [String]$file = "",
  [String]$io = "",
  [String]$place = "",
  [String]$detail = "",
  [String]$notplace = "",
  [String]$notdetail = ""
)

ls |
  ? { $_.Name -match "$($file).*\.txt$" } |
  % { .\Parse.ps1 $_.Name } |
  ? { $_.IO -eq $io -and $_.Place -match $place -and $_.Detail -match $detail } |
  ? { $notplace -eq "" -or $_.Place -notmatch $notplace } |
  ? { $notdetail -eq "" -or $_.Detail -notmatch $notdetail }
