# Import all functions (in Functions/ folder)
. \Functions\Get-ADUserDetail.ps1
. \Functions\Get-ADComputerDetail.ps1
. \Functions\Get-ADUserGroups.ps1
. \Functions\Get-ADMembershipRecursive.ps1

# Export them
Export-ModuleMember -Function Get-ADUserDetail, Get-ADComputerDetail, Get-ADUserGroups, Get-ADMembershipRecursive