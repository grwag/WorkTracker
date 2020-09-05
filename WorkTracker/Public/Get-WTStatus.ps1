function Get-WTStatus {
    [CmdletBinding()]
    [Alias('wtstat')]
    param (
        
    )
    
    begin {
    }
    
    process {
        Stop-WTWork -WhatIf
    }
    
    end {
        
    }
}
