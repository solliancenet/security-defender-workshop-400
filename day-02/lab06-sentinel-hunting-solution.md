# Sentinel Extensibility + Hunting

## Solution

- If you were to open the user's Office 365 mailbox, you will see an email was sent to them
- Open the email, notice it has a file attached
- The file was downloaded and opened, you can see it in the user's download directory
- Open the file, review the macros inside it
- One of the macros asks for a password, in this case, the user did in fact type their password in
- The username and password were saved to a file on disk
- The macro proceeded to download a zip file and an encoded powershell command
- The powershell was executed using the username and password, the hacker got lucky and the password works
- The powershell command proceeded to enumerate all Azure Key Vaults
- All secrets were dumped out to a file and then emailed to the hacker
- The script also did the unthinkable, it deleted the users's key vaults after exporting all the keys
- The attack continued on using more traditional attacks such as process injection and mimikatz
- And just for fun, they encrypted all items in the user's onedrive
- Lastly, they placed a task schedule job on the machine called `User_Feed_Backup`
