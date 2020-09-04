function Get-WTWorkingEntryPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Date
    )
    
    begin {
        
    }
    
    process {
        $WorkingEntryPath = Join-Path $env:APPDATA ".worktracker"
        $WorkingEntryPath = Join-Path $WorkingEntryPath ($Date + ".json")

        $WorkingEntryPath
    }
    
    end {
        
    }
}
