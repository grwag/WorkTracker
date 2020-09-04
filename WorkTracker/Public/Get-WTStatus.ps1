function Get-WTStatus {
    [CmdletBinding()]
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
