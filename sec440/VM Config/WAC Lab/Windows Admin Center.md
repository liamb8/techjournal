# Windows Admin Center



### Install Commands:

​       Download Windows Admin Center msi file

- `Invoke-WebRequest 'https://aka.ms/WACDownload' -OutFile "$pwd\WAC.msi"`

  Install Windows Admin Center 

- `$msiArgs = @("/i", "$pwd\WAC.msi", "/qn", "/L*v", "log.txt", "SME_PORT=6516", "SSL_CERTIFICATE_OPTION=generate") `

- `Start-Process msiexec.exe -Wait -ArgumentList $msiArgs`

Allow RDP on Wks1

- Control Panel -> System and Security -> System -> Allow Remote Access