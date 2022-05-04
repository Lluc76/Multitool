# Multitool
I will create a new "multi-tool", that is, a program capable of performing various actions useful to our operating system. It will be compatible with Windows 10. All these options can be used locally or remotely, whether it is done by an organizer or a variety at once. The powershell version used is 5.1

Utilities:

Do Backups:
 - You can manage the backups from the target_backups.csv
 - It will allow you to select which folders will be backed up and where
 - The files will be compressed and you can choose if you want encrypt them with password
 - You can Enable/Disable a specific backup from the csv
 - The backup process will create a logfile to easy manage and 

Task Scheduler (for Powershell Scripts):
 - You can schedule tasks with custom names and parameters
 - Allows you Enable/Disable an specific task from the csv
 - You can delete a task with the name

Optimization:
 - Temp Cleaner:
 	- Clear temporary folders and files (You can modify the targets to clean)
 	- Allows you Enable/Disable an specific path from the csv
 - 
Focus the optimization of the computer on performance or image quality
Turn Windows Defender On or Off
Enable or Disable Firewall

*Program Installer:
You will be able to select from an extensive list of which common applications to install and which not to do it
Last versions will be installed

*Security:
List of open ports, close and in use
Hardening (Check that it is activated: Windows firewall, Windows Defender, protection against ransomware, disk encryption, secure login authentication, remote access disabled, automatic Windows updates, etc) and if not will show you that is not activated

Things to have in consideration:

 - Execute remote commands:
 	- You can connect via Computer DNSname
 	- Ports 5985,5986
 	- WinRM service running (on client execute "winrm quickconfig" if is not enabled)
 	- Executer user needs to be an administrator on the remote machine or a member of the Remote Management Users group
 	- **You need to set the Execution Policy to RemoteSigned with "Set-ExecutionPolicy RemoteSigned"

 - Backup:
 	- Destination field on csv must have the .zip format
 	- Defining the directories you can use %username% as a system variable
 	- If you want to extract the zip file encrypted with password you will need to use a 3rd party program, cause default file extractor of Windows 10 can't process the decryption
 	- The backup script only will create a zip that a folder that at least contains 1 file
 	- In the csv at the column "Enabled" needs to be "Yes" to proceed with the backup, otherwise will output that is disabled. This is useful if you want to maintain other backups routes there or this time don't want to backup some of them
 	- There are a log file that will be saved by default near the script, but you can change it modifying the value of the variable $path. The path must end with "\" character
 	- Before start with the compression function will check if the dependencies are installed, if can't be installed the operation will be aborted. The dependencies are the following: NuGet, 7Zip4PowerShell
 	- If the Backup Destination Folder doesn't exists will be created automatically
 	- After realize the compress function will check if was correctly created

 - Task Scheduler:
 	- At the column name you needs to introduce the name of the task you want to create, at path the location of the powershell script you want to create and at the program of the script
 	- In the csv at the column "Enabled" needs to be "Yes" to proceed with the creation of thetask, otherwise will output that is disabled. This is useful if you want to maintain other task configurations but you don't want to create it in that moment
 	- There are a log file that will be saved by default near the script, but you can change it modifying the value of the variable $path. The path must end with "\" character
 	- Parameters:
		Note that the 1st parameter is required, and depending on which one you also need the "at" parameter with its corresponding value. If you have doubts can see the documentation here: https://www.pdq.com/powershell/new-scheduledtasktrigger/

		- once, [randomdelay [TimeSpan]], [repetitionduration TimeSpan], [repetitioninterval TimeSpan], at DateTime
		- weekly, [randomdelay [TimeSpan]], [weeksinterval Integer], at DateTime, -DaysOfWeek DayOfWeek
		- daily, [randomdelay [TimeSpan]], [daysinterval Integer], at DateTime
		- atlogon, [randomdelay [TimeSpan]], [user [user]]
		- atstartup, [randomdelay [TimeSpan]]

	Meanings of the parameters:
		- once = Indicates that a trigger starts a task once at a time specified in the At parameter
		- weekly = Indicates that the trigger starts a task on a recurring weekly schedule
		- daily = Indicates that a trigger starts a task on a recurring daily schedule
		- atlogon = Indicates that a trigger starts a task when a user logs on
		- atstartup = Indicates that a trigger starts a task when the system is started
		- at = Specifies a date and time to trigger the task
		
		- randomdelay = Specifies a random amount of time to delay the start time of the trigger. The delay time is a random time between the time the task triggers and the time that you specify in this setting.
		- repetitionduration = Specifies how long the repetition pattern repeats after the task starts
		- repetitioninterval = Repeats the task at the specified time interval
		- weeksinterval = Specifies the interval between the weeks in the schedule
		- daysinterval = Specifies the interval between the days in the schedule
		- user = Specifies the identifier of the user for a trigger that starts a task when a user logs on, by default is setted to all users
		- daysofweek = Specifies an array of the days of the week on which Task Scheduler runs the task

******************************************************************

Cosas pendientes:
 - Revisar si por remoto funciona el %username%
 - Al crear tarea copiar script a una carpeta custom en alguna ruta interna para que el task scheduler encuentre siempre el script
 - Todos los prerequisitos se puedan aplicar con 1 script
 - Testear backups con NAS
 - Backups no se ejecuta en 2o plano
 - Revisar que al ejecutar el script de backups mediante el task schedule use como usuario el que debería y no uno del sistema "interno", que lo ejecute silenciosamente
 - Task Scheduler - Falta crear funciones para que el código quede más limpio
 - Comprobar que pasa si no se puede instalar nuget o 7Zip (ver log)
 - Task scheduler - Guardar task en DC o en Clientes