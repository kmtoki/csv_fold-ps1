Param(
  #[parameter(mandatory=$true)][String]$File
  [String]$file
)

cat $file -Encoding utf8 | 
  % { $_ -replace "\s+", " " } |
  ConvertFrom-Csv -Delimiter " " |
  % { $_.Price = [int]$_.Price; $_ }
