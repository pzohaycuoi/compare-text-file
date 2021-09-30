param(
  # path to source file need to compare
  [string]
  $SourceFile,
  
  # path to file need to compare
  [String]
  $CompareFile
)

# both compared file need to be in the same folder
# because I use relative path

$srcFileData = Get-Content -Path .\$SourceFile
$compFileData = Get-Content -Path .\$CompareFile

# get the date and time for exported file name
$getDateForFileName = Get-Date -Format ddMMyy-hhmmss

# need 2 files: one for holding the diff and other for the same
# file type is txt
$diffDataFileName = "diff-$($getDateForFileName).txt"
$sameDataFileName = "same-$($getDateForFileName).txt"

# loop through each row in source file
# check if row exsit in compared file
# export diff to $diffDataFileName, same to $sameDataFileName
# exported file will be in the same location the script run
foreach ($row in $srcFileData) {
  if ($compFileData -contains $row) {
    $row | Out-File -FilePath .\$sameDataFileName -Append -Force
  } else {
    $row | Out-File -FilePath .\$diffDataFileName -Append -Force
  }
}