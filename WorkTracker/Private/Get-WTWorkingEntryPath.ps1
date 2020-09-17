function Get-WTWorkingEntryPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Date
    )
    
    begin {
        
    }
    
    process {
        $WorkingEntryPath = Get-WTWrokDir
        $WorkingEntryPath = Join-Path $WorkingEntryPath ($Date + ".json")

        $WorkingEntryPath
    }
    
    end {
        
    }
}
