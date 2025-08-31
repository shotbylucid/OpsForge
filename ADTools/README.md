# ADTools

PowerShell module for Active Directory automation and reporting.

## Description

ADTools provides a collection of PowerShell functions for managing Active Directory users, computers, groups, and performing AD-related administrative tasks and reporting.

## Functions

- **Get-ADUserDetail** - Retrieves detailed information about Active Directory users
- **Get-ADComputerDetail** - Gets comprehensive details about AD computer objects
- **Get-ADUserGroups** - Lists group memberships for Active Directory users
- **Get-ADMembershipRecursive** - Recursively retrieves group membership information
- **New-ADAccount** - Creates new Active Directory accounts _(WIP - may change)_

## Installation

```powershell
Import-Module .\ADTools.psd1
```

## Usage

Examples and detailed usage information for each function can be found in the Examples directory as they are developed.

## Notes

All IP addresses and domain names in this module are example values and should be replaced before use in any real environment.
