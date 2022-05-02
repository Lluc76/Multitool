# Multitool
I will create a new "multi-tool", that is, a program capable of performing various actions useful to our operating system. It will be compatible with Windows 10. All these options can be used locally or remotely, whether it is done by an organizer or a variety at once.

Utilities:

Do Backups:
It will allow you to select which folders will be backed up
The files will be compressed and you can choose if you want encrypt them with password

Optimization:
Clear temporary files
Focus the optimization of the computer on performance or image quality
Turn Windows Defender On or Off
Enable or Disable Firewall

Program Installer:
You will be able to select from an extensive list of which common applications to install and which not to do it
Last versions will be installed

Security:
List of open ports, close and in use
Hardening (Check that it is activated: Windows firewall, Windows Defender, protection against ransomware, disk encryption, secure login authentication, remote access disabled, automatic Windows updates, etc) and if not will show you that is not activated

Things to have in consideration:

Execute remote commands:
 - You can connect via Computer DNSname
 - Ports 5985,5986
 - WinRM service running (on client execute "winrm quickconfig" if is not enabled)
 - Executer user needs to be an administrator on the remote machine or a member of the Remote Management Users group
 - **You need to set the Execution Policy to RemoteSigned with "Set-ExecutionPolicy RemoteSigned"

Backup:
 - Destination field on csv must have the .zip format
 - If you don't want password make sure it dont have blank spaces, otherwise will encrypt the destination file with those blank spaces
 - Defining the directories you can use %username% as a system variable
 - If you want to extract the zip file encrypted with password you will need to use a 3rd party program, cause default file extractor of Windows 10 can't process the decryption
 - The backup script only will create a zip that a folder that at least contains 1 file

Exit Codes:
 - Backup:
         Exit with code 7 = NuGet couldn't been installed
	 Exit with code 8 = 7Zip couldn't been installed

Task Scheduler:
 - Parameters:
	-Note that the 1st parameter is required, and depending on which one you also need the "at" parameter with its corresponding value. In the column ReqParam you need to set the mandatory parameter (The 1st), at the ParamX and ValueX the parameter name and value respectively. (The name param in lowercase, otherwise the command will be skipped to avoid errors

	· once, [randomdelay [<TimeSpan>]], [repetitionduration <TimeSpan>], [repetitioninterval <TimeSpan>], at <DateTime>
	· weekly, [randomdelay [<TimeSpan>]], [weeksinterval <Integer>], at <DateTime>
	· daily, [randomdelay [<TimeSpan>]], [daysinterval <Integer>], at <DateTime>
	· atlogon, [randomdelay [<TimeSpan>]], [user [<user>]]
	· atstartup, [randomdelay [<TimeSpan>]]

	Meanings of the parameters:
		- once = Indicates that a trigger starts a task once at a time specified in the At parameter
		- weekly = Indicates that the trigger starts a task on a recurring weekly schedule
		- daily = Indicates that a trigger starts a task on a recurring daily schedule
		- atlogon = Indicates that a trigger starts a task when a user logs on
		- atstartup = Indicates that a trigger starts a task when the system is started
		- at = Specifies a date and time to trigger the task
		····················································
		- randomdelay = Specifies a random amount of time to delay the start time of the trigger. The delay time is a random time between the time the task triggers and the time that you specify in this setting.
		- repetitionduration = Specifies how long the repetition pattern repeats after the task starts
		- repetitioninterval = Repeats the task at the specified time interval
		- weeksinterval = Specifies the interval between the weeks in the schedule
		- daysinterval = Specifies the interval between the days in the schedule
		- user = Specifies the identifier of the user for a trigger that starts a task when a user logs on, by default is setted to all users

 - TimeSpan:
	· You can define the time with the following characters: [d, h, m, s, ms] for (days, hours, minutes, seconds and milliseconds)
	· If time is not defined correctly the command will be skipped to avoid errors
	· Example:
		a) 5 days, 5 hours and 2 seconds = 5d 5h 2s
		b) 10 minutes, 5 seconds and 200 milliseconds = 10m 5s 200ms

 - DateTime:
	· 

Cosas pendientes:
 - Agregar fichero de logs
 - Revisar si por remoto funciona el %username%
 - *Revisar instalar NuGet se muestra el output
 - Revisar NuGet no se puede eliminar
 - Crear tarea en Windows que ejecute el backup para definir una periodicidad
 - Antes de instalar 7Zip para powershell instalar proveedor NuGet y comprobar si existe en 2 directorios
 - Agregar posibilidad de que los backups se borren hayan pasado x cantidad de tiempo, para no ocupar demasiada memoria
 - Agregar posibilidad de programar tareas, borrar las creadas, etc
 - Al crear tarea copiar script a una carpeta custom en alguna ruta interna para que el task scheduler encuentre siempre el script
 - Todos los prerequisitos se puedan aplicar con 1 script
 - Testear backups con NAS
 - Especificar versiones anteriores de Windows Server para comandos de powershell
 - Revisar que al ejecutar el script de backups mediante el task schedule use como usuario el que debería y no uno del sistema "interno", que lo ejecute silenciosamente
 - En los csv añadir campo de activado/desactivado por si se quiere guardar algo sin que se ejecute