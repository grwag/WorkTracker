BeforeAll {

    # Test setup - Pester v5 Setup Syntax
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    $ModulePath = (Get-ChildItem -Path $ModuleRoot -Filter "*.psd1").FullName
    $ModuleName = (Get-ChildItem -Path $ModuleRoot -Filter "*.psd1").BaseName

    $ModuleManifest = (Get-ChildItem -Path $ModuleRoot -Filter "*.psd1").FullName
    $Manifest = Test-ModuleManifest -Path $ModuleManifest -ErrorAction Stop -WarningAction SilentlyContinue

    $PublicPath = Join-Path $moduleRoot 'Public'
    $PublicFunctions = (Get-ChildItem -Path $PublicPath -Filter "*.ps1" -Recurse).BaseName
}

Describe -Name 'Module Structure' {

    Context 'Module Manifest' {
        It -Name 'has a valid manifest' {
            { $Manifest | Should -Not -Throw }
        }

        It -Name 'has a valid name in the Manifest' {
            $Manifest.Name | Should -Be $moduleName
        }

        It -Name 'has a valid root module' {
            $Manifest.RootModule | Should -Be ($moduleName + ".psm1")
        }

        It -Name 'has version set in the Manifest' {
            $Manifest.Version | Should -Not -BeNullOrEmpty
        }
        
        It -Name 'has CompanyName set in the Manifest' {
            $Manifest.CompanyName | Should -Not -BeNullOrEmpty
        }

        It -Name 'has a valid description' {
            $Manifest.Description | Should -Not -BeNullOrEmpty
        }

        It -Name 'has a valid author' {
            $Manifest.Author | Should -Not -BeNullOrEmpty
        }

        It -Name 'has a valid guid' {
            { [guid]::Parse($Manifest.Guid) } | Should -Not -Throw
        }

        It -Name 'has a valid copyright' {
            $Manifest.CopyRight | Should -Not -BeNullOrEmpty
        }

        It -Name 'has the same number of exported public functions for function ps1 files' {
            ($Manifest.ExportedFunctions.GetEnumerator() | Measure-Object).Count | Should -Be ($PublicFunctions | Measure-Object).Count
        }
        
        It -Name 'has all of its public functions exported' {
            $Expected = $Manifest.ExportedFunctions.Values.Name | Sort-Object
            $Actual = $PublicFunctions | Sort-Object
            $Actual | Should -Be $Expected
        }
    }

    Context "Module Functions" {

        $FunctionsPath = Split-Path $PSCommandPath -Parent
        $FunctionsPath = Join-Path $FunctionsPath "Functions"

        $Funcs = Get-ChildItem -Path $FunctionsPath -Filter "*.ps1" -Recurse

        $Funcs | ForEach-Object {

            It 'test'  -TestCases @(@{function = $_ }) {
                $FunctionContents = $null
                $PsParserErrorOutput = $null
                $FunctionContents = Get-Content -Path $Function.FullName
                [System.Management.Automation.PSParser]::Tokenize($FunctionContents, [ref]$PsParserErrorOutput)

                ($PsParserErrorOutput | Measure-Object).Count | Should -Be 0
                Clear-Variable -Name ÜsParserErrorOutput -Force -ErrorAction Stop
            }
        }
    }
}