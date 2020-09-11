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
}

Describe 'Test-Function' {
    It 'no op test' {
        Mock Test-Path { return $true } -ParameterFilter { $Path -eq "something" }
        Mock Test-Path { return $false } -ParameterFilter { $Path -ne "something" }
        Mock Get-WTWorkingEntry { return "something" }
        Mock Set-WTWorkingEntry { }

        Test-WTWorkDay | Should -BeFalse
    }
}