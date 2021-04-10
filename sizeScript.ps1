
#Change file name, service name and max log size above which log has to be backed up
$fileName = ".\text.txt"
$maxLogSize = 50
$serviceName = "Test"
$logBackupLog = "backuplog.txt"

$fileSize = Get-ChildItem $fileName | %{[int]($_.length) / 1mb}

if ($fileSize -ge $maxLogSize){
	$logtime = (Get-Date).ToString("dd-MM-yyyy hh:mm:ss")
    
        Write-Output "$logtime : File Size :$fileSize MB. File is more than $maxLogSize MB"| Out-File $logBackupLog -Append
    Get-Service -Name $serviceName | Stop-Service
        Write-Output "$logtime : $serviceName service stopped" | Out-File $logBackupLog -Append
    $backupDate = (Get-Date).ToString("_ddMMyyyy_hhmm")
        Write-Output "$logtime : Backing up old log file..." | Out-File $logBackupLog -Append
    move-Item -Path $fileName -Destination ".\old\text$backupDate.txt"
        Write-Output "$logtime : Creating New log file" | Out-File $logBackupLog -Append
    New-Item -Path .\ -Name "text.txt"
    Get-Service -Name $serviceName | Start-Service 
        Write-Output "$logtime : $serviceName service Started" | Out-File $logBackupLog -Append
}
