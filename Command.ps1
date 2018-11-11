$currentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition;
$title = "闪之轨迹"
$version = "`tV1.57"
$date = "180901"

Write-Host $title `n $version $date
Write-Host $currentDir

$PatchFileList = Get-ChildItem -r -n -File
$PatchFileHash = @{}

$SourceFileList = Get-ChildItem -r -n -File
$SourceFileHash = @{}

function Get-AllFileHash([array]$FileList) {
    $AllFileHash = @{}

    for ($i = 0; $i -lt $FileList.Count; $i++) {
        $AllFileHash[$FileList[$i]] = (Get-FileHash $FileList[$i] | Select-Object Hash).Hash
    }

    return $AllFileHash
}

function Get-PatchFileHash([array]$PatchFileList) {

    $PatchFileHash = Get-AllFileHash $PatchFileList

    return $PatchFileHash
}

function Get-SourceFileHash([array]$SourceFileList) {

    $SourceFileHash = Get-AllFileHash $SourceFileList

    return $SourceFileHash
}

$PatchFileHash = Get-PatchFileHash $PatchFileList
#$SourceFileHash = Get-SourcehFileHash $SourceFileList

function Get-FileHashList([array]$FileList,[array]$FileHash){

    for ($i = 0; $i -lt $FileList.Count; $i++) {
        Write-Host $FileList[$i] `t $FileHash.($FileList[$i]) 
    }

}

function Get-SourceFileHashList([array]$SourceFileList) {


    $SourceFileHashList = Get-FileHashList $SourceFileList

    return $SourceFileHashList
}

function Get-PatchFileHashList([array]$PatchFileList,[array]$PatchFileHash) {

    $PatchFileHashList = Get-FileHashList $PatchFileList $PatchFileHash

    return $PatchFileHashList
}

Get-PatchFileHashList $PatchFileList $PatchFileHash

#Write-Host $FileList.GetType()
#Write-Host $FileHash.GetType()
#Write-Host $FileList.Count
#Write-Host $FileHash.Count