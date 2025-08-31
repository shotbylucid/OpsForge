<#
.NOTES
    All IP addresses and domain names in this module (including 'prod', 'main', 'customer', 'sec') are example values.
    They do NOT reflect real networks or organizations and should be replaced before use in any real environment.
#>


# Import all functions from Functions folder
$FunctionsPath = Join-Path $PSScriptRoot "Functions"
if (Test-Path $FunctionsPath) {
    Get-ChildItem -Path $FunctionsPath -Filter "*.ps1" | ForEach-Object {
        . $_.FullName
    }
}

# Export functions
Export-ModuleMember -Function Get-ADUserDetail, Get-ADComputerDetail, Get-ADUserGroups, Get-ADMembershipRecursive