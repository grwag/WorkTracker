BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName
}

Describe 'Get-WTLedgerPath' {
    It 'returns correct path' {
        Mock Get-Date { return @{Year = 2020; Month = 12} }

        Get-WTLedgerPath | Should -BeLike "*\.worktracker\Dezember_2020.csv"
    }
}