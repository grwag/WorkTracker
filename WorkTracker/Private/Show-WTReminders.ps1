function Show-WTReminders {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $WorkDir = Get-WTWrokDir
    }
    
    process {
        Write-Host "Don't forget to..." -ForegroundColor Red -BackgroundColor Cyan
        $Reminders = @()
        $Reminders += Join-Path $WorkDir "daily_reminders.json"

        $Reminders | Foreach-Object {
            $r = Get-Content -Path $_ | ConvertFrom-Json
            Write-Host $r.reminders -ForegroundColor Blue
        }
    }
    
    end {
        
    }
}
