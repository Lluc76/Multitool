#Reads the csv file and every row is inserted into array called $csv
Function read_csv{
    Param ($file)
    $global:csv = Import-Csv -Path .\$file
}