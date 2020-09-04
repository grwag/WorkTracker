function Get-WTLedgerPath {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        $Date = Get-Date
        $Month = (Get-Culture).DateTimeFormat.GetMonthName($Date.Month)

        $FileName = $Month + "_" + $Date.Year
        $FileName += ".csv"

        $LedgerPath = Join-Path $Env:APPDATA ".worktracker"
        Join-Path $LedgerPath $FileName
    }
    
    end {
        
    }
}
