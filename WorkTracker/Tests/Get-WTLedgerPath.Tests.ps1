﻿BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName

    function Get-WTWrokDir {
        
    }
}

Describe 'Get-WTLedgerPath' {
    It 'returns correct path' {
        Mock Get-Date { return [datetime]637354402200000000 }
        Mock Get-WTWrokDir { return "something\.worktracker"}

        Get-WTLedgerPath | Should -BeLike "*\.worktracker\September_2020.csv"
    }
}