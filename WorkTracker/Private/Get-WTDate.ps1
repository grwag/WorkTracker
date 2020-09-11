function Get-WTDate {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        $Now = Get-Date
        $Now.AddSeconds(-$Now.Second)
    }
    
    end {
        
    }
}
