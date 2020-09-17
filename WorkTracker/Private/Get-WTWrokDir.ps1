function Get-WTWrokDir {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        Join-Path $Env:APPDATA ".worktracker"
    }
    
    end {
        
    }
}
