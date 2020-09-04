pipeline {
    agent {
        label 'msbuild'
        
    }
    
    stages {
        stage('Test') {
            steps {
                powershell 'Invoke-Pester -OutputFile result.xml -OutputFormat NUnitXml'
            }
        }
        stage('Deploy') {
            steps {
                powershell '''
                    $Version = gitversion | ConvertFrom-Json
                    $Module = "WorkTracker"
                    Push-Location .\\$Module
                    Update-ModuleManifest -ModuleVersion $Version.AssemblySemVer -Path ($Module + (".psd1"))
                    // Publish-Module -Name (".\\" + $Module + ".psd1") -Repository nexus -Verbose -NugetApiKey cb1a446c-2954-300a-b047-5b806ee40f0e
                '''
            }
        }
    }
}
