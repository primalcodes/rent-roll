# RentRoll Report

## Import process:
* Rails Console: `RentRollImport.new(file_path: 'file/path/to/file.csv').call`

## REPORT for a given date:
* Rake Task: `rake "reports:rent_roll['2020-12-01]"`
* Rails Console: `RentRollReport.new(date: Date.today).call`
