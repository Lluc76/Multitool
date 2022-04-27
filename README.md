# Multitool
I will create a new "multi-tool", that is, a program capable of performing various actions useful to our operating system. It will be compatible with Windows 10. All these options can be used locally or remotely, whether it is done by an organizer or a variety at once.

Utilities:

Do Backups:
It will allow you to select which folders will be backed up
Where you wana do the backup and with possibilitie with save it on drive
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

Things to consider:

Execute remote commands:
 - You can connect via Computer DNSname
 - Ports 5985,5986
 - WinRM service running (on client execute "winrm quickconfig" if is not enabled)
 - Executer user needs to be an administrator on the remote machine or a member of the Remote Management Users group

Backup:
 - Destination field on csv must have the .zip format
 - If you don't want password make sure it dont have blank spaces, otherwise will encrypt the destination file with those blank spaces
 - Defining the directories you can use %username% as a system variable

Exit Codes:
 - Backup:
	 Exit with code 8 = 7Zip couldn't been installed

Cosas pendientes:
 - Revisar como subir archivo a drive a través de powershell
 - Revisar si por remoto funciona el %username%