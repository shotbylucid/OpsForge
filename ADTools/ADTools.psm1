<#
.NOTES
    All IP addresses and domain names in this module (including 'prod', 'main', 'customer', 'sec') are example values.
    They do NOT reflect real networks or organizations and should be replaced before use in any real environment.
#>


# Import all functions (in Functions/ folder)
. \Functions\Get-ADUserDetail.ps1
. \Functions\Get-ADComputerDetail.ps1
. \Functions\Get-ADUserGroups.ps1
. \Functions\Get-ADMembershipRecursive.ps1

# Export them
Export-ModuleMember -Function Get-ADUserDetail, Get-ADComputerDetail, Get-ADUserGroups, Get-ADMembershipRecursive