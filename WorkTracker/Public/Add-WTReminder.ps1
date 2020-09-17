function Add-WTReminder {
    [CmdletBinding()]
    [Alias('wtrem')]
    param (
        [Parameter(Mandatory = $true)]
        $Reminder,
        [switch]$Daily
    )
    
    begin {
        $WorkDir = Get-WTWrokDir
    }
    
    process {
        $Reminders = @()
        if($Daily){
            $Reminders += Join-Path $WorkDir "daily_reminders.json"
        }

        $Reminders | Foreach-Object {
            if(-not (Test-Path $_)) {
                Write-Host "alf"
                New-Item -Path $_ -ItemType File | Out-Null
                $r = @{reminders = @()}
                Set-Content -Path $_ -Value ( $r | ConvertTo-Json )
            }

            $r = Get-Content -Path $_ | ConvertFrom-Json
            $r.reminders += ($Reminder + [System.Environment]::NewLine)

            Set-Content -Path $_ -Value ( $r | ConvertTo-Json )
        }
    }
    
    end {
        
    }
}
