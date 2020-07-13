<#
.SYNOPSIS
Grants list,get permissions on supplied keyvault to supplied application identity

.DESCRIPTION
Grants list,get permissions on supplied keyvault to supplied application identity

.PARAMETER DataFactoryName
Name of the keyvault

.PARAMETER ResourceGroupName
Name of the resource group

.PARAMETER StopYesOrNo
Name of the service principal

.EXAMPLE
StartOrStopAzureDataFactoryTriggers.ps1 -ResourceGroupName "dfc-dev-cd-df-rg" -DataFactoryName "dfc-dev-cd-test-df" -StartYesOrNo Yes  -Verbose
StartOrStopAzureDataFactoryTriggers.ps1 -ResourceGroupName "dfc-dev-cd-df-rg" -DataFactoryName "dfc-dev-cd-test-df" -StartYesOrNo No  -Verbose

#>
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$DataFactoryName,
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]$StartYesOrNo
)


Write-Verbose "Fetch a list of Data Factory Triggers"
$DataFactoryTriggers = Get-AzDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName

if ($DataFactoryTriggers) {
    Write-Verbose "Data Factory Trigger(s) found"
    foreach ($trigger in $DataFactoryTriggers) {
        if ("Yes" -eq $StartYesOrNo) {
            Write-Verbose "Starting Trigger $($trigger.Name)"
            Start-AzDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $trigger.Name -Force           
        } else {
            Write-Verbose "Stopping Trigger $($trigger.Name)"
            Stop-AzDataFactoryV2Trigger -ResourceGroupName $ResourceGroupName -DataFactoryName $DataFactoryName -Name $trigger.Name -Force
        }
    }
} else {
    Write-Verbose "No Data Factory Triggers found"
}








  