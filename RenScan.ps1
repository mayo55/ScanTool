Param(
	[String]$filename
)

if ($filename -eq '') {
	echo "引数1：フルパスファイル名 が必要です。"
	exit 1
}

$scanDir = "C:\Scan\"
$trashDir = "C:\Scan\_trash\"

$filePath = Split-Path -Parent $filename

$oldList = Get-ChildItem -LiteralPath $filePath

$newList = Get-ChildItem $scanDir -File -Filter *.bmp

echo $newList.Length

$oldListIndex = [Array]::IndexOf($oldList.FullName, $filename)
echo $oldListIndex

$nowDate = Get-Date -Format "yyyyMMddHHmmss"
$trashAutoDir = Join-Path $trashDir $nowDate

New-Item $trashAutoDir -ItemType Directory

for ($i = 0; $i -lt $newlist.Length; $i++) {
	$oldFullName = $oldList[$oldListIndex + $i].FullName
	$newFullName = $newList[$i].FullName

	$oldFilename = Split-Path -Leaf $oldFullName
	$trashFullName = Join-Path $trashAutoDir $oldFilename

	echo "move ""${oldFullName}"" ""${trashFullName}"""
	echo "move ""${newFullName}"" ""${oldFullName}"""
	echo ""

	Move-Item -LiteralPath "${oldFullName}" "${trashFullName}"
	Move-Item -LiteralPath "${newFullName}" "${oldFullName}"
}
