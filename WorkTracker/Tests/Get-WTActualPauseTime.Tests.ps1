BeforeAll{

    $FunctionName = Split-Path $PSCommandPath -Leaf
    $FunctionName = $FunctionName -replace "\.Tests", ""
    $ModuleRoot = Split-Path $PSCommandPath -Parent
    $ModuleRoot = Split-Path $ModuleRoot -Parent
    
    $Function = Get-ChildItem -Path $ModuleRoot -Recurse -Filter $FunctionName

    Write-Host $Function
    
    .  $Function.FullName

    function Get-WTDate {
        
    }
}

Describe 'Get-WTActualPauseTime' {
    It 'returns correct value if no pause was made' {
        $StartTime = Get-Date "10/10/2020 00:00"
        $EndTime = Get-Date "10/10/2020 00:50"

        $WrokingEntry = @{
            Date = $StartTime.ToShortDateString()
            Start = $StartTime.Ticks
            PauseStart = 0
            PauseTotalInMinutes = 0
            WorkEnd = $EndTime.Ticks
            TotalWorkTime = 0
        }
        
        $ActualPause = Get-WTActualPauseTime -WorkingEntry $WrokingEntry
        $ActualPause.Minutes | Should -Be 0
    }

    It 'returns correct pause' {
        $StartTime = Get-Date "10/10/2020 00:00"
        $EndTime = Get-Date "10/10/2020 00:50"

        $WrokingEntry = @{
            Date = $StartTime.ToShortDateString()
            Start = $StartTime.Ticks
            PauseStart = 0
            PauseTotalInMinutes = 5
            WorkEnd = $EndTime.Ticks
            TotalWorkTime = 0
        }
        
        $ActualPause = Get-WTActualPauseTime -WorkingEntry $WrokingEntry
        $ActualPause.Minutes | Should -Be 5
    }

    It 'returns correct pause if still in pause mode' {
        $StartTime = Get-Date "10/10/2020 00:00"
        $EndTime = Get-Date "10/10/2020 00:50"
        $PauseStart = Get-Date "10/10/2020 00:40"

        Mock Get-WTDate { return $EndTime }

        $WrokingEntry = @{
            Date = $StartTime.ToShortDateString()
            Start = $StartTime.ToString("yyyyMMddHHmm")
            PauseStart = $PauseStart.ToString("yyyyMMddHHmm")
            PauseTotalInMinutes = 5
            WorkEnd = $EndTime.ToString("yyyyMMddHHmm")
            TotalWorkTime = 0
        }
        
        $ActualPause = Get-WTActualPauseTime -WorkingEntry $WrokingEntry
        $ActualPause.Minutes | Should -Be 15
    }
}