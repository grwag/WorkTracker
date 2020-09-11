BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName
}

Describe 'Get-WTDate' {
    It 'returns date without seconds' {
        $Expected = [datetime]637354390804800369

        Mock Get-Date { return [datetime]637354391234800369 }

        Get-WTDate | Should -Be $Expected
    }
}