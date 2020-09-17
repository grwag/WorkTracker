BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName
}

Describe 'Test-Function' {
    # It 'no op test' {
    #     $true | Should -BeFalse
    # }
}