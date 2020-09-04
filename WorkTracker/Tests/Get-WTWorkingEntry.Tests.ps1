BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName
    function Get-WTWorkingEntryPath {
        param (
            [Parameter(Mandatory = $true)]
            $Date
        )
    }
}


Describe 'Get-WTWorkingEntry' {
    It 'should create working extry file if it does not exist' {
        Mock Test-Path { return $false }
        Mock New-Item {}
        Mock Get-Content {}
        Mock Get-WTWorkingEntryPath { return "some path" }

        Get-WTWorkingEntry -Date "my date"
        Assert-MockCalled New-Item -Exactly 1
    }
}