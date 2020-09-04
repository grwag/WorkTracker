function Test-WTWorkDay {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $Date = Get-Date
    }
    
    process {
        $WorkEntryPath = Get-WTWorkingEntryPath -Date $Date.ToShortDateString()
        if(-not (Test-Path -Path $WorkEntryPath)){
            return $false
        }

        $LedgerPath = Get-WTLedgerPath

        if(-not (Test-Path -Path $LedgerPath)){
            return $false
        }

        $Ledger = Import-Csv -Path $LedgerPath

        $Today = $Ledger | Where-Object {
            $_.Date -eq $Date.ToShortDateString()
        }

        return $Today.Count -gt 0
    }
    
    end {
        
    }
}
