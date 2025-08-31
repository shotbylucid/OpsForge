function Get-ADUserDetail {
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline)]
    [string]$UserID,

    [Parameter(Mandatory = $true)]
    [ValidateSet('prod', 'main', 'customer', 'sec')]
    [string]$Domain
  )

  process {
    # Use consistent global domain mapping check
    if (-not $Global:DomainMap.ContainsKey($Domain)) {
      throw "Invalid domain code '$Domain'. Valid options: $($Global:DomainMap.Keys -join ', ')"
    }

    $fqdn = $Global:DomainMap[$Domain]

    try {
      # Only request needed properties for better performance
      Get-ADUser -Identity $UserID -Server $fqdn -Properties Enabled, Info, DistinguishedName, CanonicalName, PasswordLastSet, LastLogonDate, LastBadPasswordAttempt, PasswordExpired, LockedOut |
      Select-Object Name, SamAccountName, Enabled, Info, DistinguishedName, CanonicalName, PasswordLastSet, LastLogonDate, LastBadPasswordAttempt, PasswordExpired, LockedOut,
      @{N = 'Domain'; E = { $Domain } },
      @{N = 'DomainFQDN'; E = { $fqdn } },
      @{N = 'QueryTime'; E = { Get-Date } }
    }
    catch {
      Write-Error "Failed to find user '$UserID' in domain '$fqdn': $($_.Exception.Message)"
      return $null
    }
  }
}