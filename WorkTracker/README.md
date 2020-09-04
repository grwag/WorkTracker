# WorkTracker
A simple module to track your working time
## Functions
### Start-WTWork
Starts the work day
### Suspend-WTWork
Suspends the work day (aka starts pause)
### Resume-WTWork
Resumes the work day (pause ends)
### Stop-WTWork
Stops the work day and writes the results to a ledger (csv file with the name Month_Year.csv)
### Get-WTStatus
Displays the status of your current work day
## Data
All data is saved in $Env:APPDATA/.worktracker
