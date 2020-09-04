function Add-WTWorkTimeToLedger {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $WorkingSummary
    )
    
    begin {
        $LedgerPath = Get-WTLedgerPath
    }
    
    process {
        if(-not (Test-Path -Path $LedgerPath)){
            New-Item -Path $LedgerPath -ItemType File -Force
        }

        $WorkingSummary | Export-Csv -Path $LedgerPath -Append
    }
    
    end {
        
    }
}
