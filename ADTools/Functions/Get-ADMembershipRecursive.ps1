function Get-ADMembershipRecursive {
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline)]
    [string]$Identity,

    [Parameter(Mandatory = $true)]
    [ValidateSet('prod', 'main', 'customer', 'sec')]
    [string]$Domain
  )

  process {
    if (-not $Global:DomainMap.ContainsKey($Domain)) {
      throw "Invalid domain code '$Domain'. Valid options: $($Global:DomainMap.Keys -join ', ')"
    }

    $fqdn = $Global:DomainMap[$Domain]

    try {
      # Use Get-ADPrincipalGroupMembership for recursive lookup
      Get-ADPrincipalGroupMembership -Identity $Identity -Server $fqdn |
      Select-Object Name, GroupScope, GroupCategory, DistinguishedName |
      Sort-Object Name
    }
    catch {
      Write-Error "Failed to get recursive group membership for '$Identity' in domain '$fqdn': $($_.Exception.Message)"
      return $null
    }
  }
}