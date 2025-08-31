@{
  RootModule           = 'ADTools.psm1'
  ModuleVersion        = '1.0.0'
  GUID                 = '8a0558b7-5a5a-46f1-9a8b-bf4fc443d2fe'
  Author               = 'shotbylucid'
  Description          = 'ADTools: PowerShell module for Active Directory automation and reporting.'
  CompatiblePSEditions = @('Desktop', 'Core')
  FunctionsToExport    = @('Get-ADUserDetail', 'Get-ADComputerDetail', 'Get-ADMembershipRecursive', 'Get-ADUserGroups')
  PowerShellVersion    = '5.1'
  LicenseUri           = 'https://opensource.org/licenses/MIT'
  ProjectUri           = 'https://github.com/shotbylucid/OpsForge'
}
