BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName
    function Get-WTWorkingEntry {
        param (
            [Parameter(Mandatory = $true)]
            $Date
        )
    }
    function Set-WTWorkingEntry {
        param (
            [Parameter(Mandatory = $true)]
            $WorkingEntry
        )
    }

    function Test-WTWorkDay {
        param (
            
        )
    }
}

Describe 'Start-WTWork' {
    It 'does not start workday more than once' {
        Mock Test-Path { return $true }
        Mock Get-WTWorkingEntry { return "something" }
        Mock Set-WTWorkingEntry { }
        Mock Test-WTWorkDay { return $false}

        Start-WTWork | Should -Be -WarningVariable "Work today already started..."
    }
}