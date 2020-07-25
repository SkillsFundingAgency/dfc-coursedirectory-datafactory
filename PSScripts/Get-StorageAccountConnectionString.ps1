<#
.SYNOPSIS
Grants list,get permissions on supplied keyvault to supplied application identity

.DESCRIPTION
Grants list,get permissions on supplied keyvault to supplied application identity

.PARAMETER StorageaccountName
Name of the keyvault

.PARAMETER ResourceGroupName
Name of the resource group

.EXAMPLE
CopyFileToStorageAccount.ps1 -StorageaccountName "dfcdevcdtestdfblobstr" -ResourceGroupName dfc-dev-cd-df-rg 

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$StorageaccountName,
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]$ConnectionStringVariable
)



# Get Storage Account Key
Write-Verbose "Get Storage Account Key"
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -AccountName $storageAccountName).Value[0]
 
# Set AzStorageContext
Write-Verbose "Get Storage Account Context"
$connectionString = "DefaultEndpointsProtocol=https;AccountName=$($storageAccountName);AccountKey=$($storageAccountKey);EndpointSuffix=core.windows.net"

Write-Verbose "Get Storage Account Conn string $($connectionString)"

Write-Output "##vso[task.setvariable variable=$(ConnectionStringVariable);issecret=true]$($connectionString)" 







  