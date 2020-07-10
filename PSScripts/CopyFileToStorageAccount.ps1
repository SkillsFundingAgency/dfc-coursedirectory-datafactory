<#
.SYNOPSIS
Grants list,get permissions on supplied keyvault to supplied application identity

.DESCRIPTION
Grants list,get permissions on supplied keyvault to supplied application identity

.PARAMETER StorageaccountName
Name of the keyvault

.PARAMETER ResourceGroupName
Name of the resource group

.PARAMETER LocalFilePath
Name of the service principal

.PARAMETER LocalFileName
Name of the service principal

.EXAMPLE
CopyFileToStorageAccount.ps1 -StorageaccountName "dfcdevcdtestdfblobstr" -ResourceGroupName dfc-dev-cd-df-rg -LocalFilePath "C:\Users\olusolaadio\ncds\dfc-coursedirectory-datafactory\data" -LocalFileName "Regions.json" -verbose

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$StorageaccountName,
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]$LocalFilePath,
    [Parameter(Mandatory=$true)]
    [string]$LocalFileName
)

$storageContainerName = "open-data"


# Get Storage Account Key
Write-Verbose "Get Storage Account Key"
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -AccountName $storageAccountName).Value[0]
 
# Set AzStorageContext
Write-Verbose "Get Storage Account Context"
$destinationContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

$openDataContainer = Get-AzStorageContainer -Name $storageContainerName -Context $destinationContext

if (!$openDataContainer) {
    New-AzStorageContainer -Context $destinationContext -Name $storageContainerName
}

$BlobName="RegionData/$($LocalFileName)"
$localFile = "$($LocalFilePath)\$($LocalFileName)"
Write-Verbose "Full local file path $localFile"
Set-AzStorageBlobContent -File $localFile -Container $storageContainerName -Blob $BlobName -Context $destinationContext -Force  








  