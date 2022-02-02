$DomainNameDNS = "lab.lab"
$DomainNameNetBios = "LAB"
$SafeModeClearPassword = ""
$SafeModeAdministratorPassword = ConvertTo-SecureString $SafeModeClearPassword -AsPlaintext -Force

$ForestConfiguration = @{
'-DatabasePath' = 'C:\Windows\NTDS';
'-DomainMode' = 'Default';
'-DomainName' = $DomainNameDNS;
'-DomainNetbiosName' = $DomainNameNetBios;
'-ForestMode' = 'Default';
'-InstallDns' = $true;
'-LogPath' = 'C:\Windows\NTDS'
'-NoRebootOnCompletion' = $false;
'-SysvolPath' = 'C:\Windows\SYSVOL'
'-Force' = $true
'-CreateDnsDelegation' = $false 
'-SafeModeAdministratorPassword' = $SafeModeAdministratorPassword }


Add-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -IncludeAllSubFeature

Import-Module ADDSDeployment
Install-ADDSForest @ForestConfiguration
