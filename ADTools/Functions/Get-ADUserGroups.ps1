function Get-ADUserGroups {
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline)]
    [string]$UserID,

    [Parameter(Mandatory = $true)]
    [ValidateSet('prod', 'main', 'customer', 'sec')]
    [string]$Domain,

    [switch]$ShowGroupNames
  )

  process {
    if (-not $Global:DomainMap.ContainsKey($Domain)) {
      throw "Invalid domain code '$Domain'. Valid options: $($Global:DomainMap.Keys -join ', ')"
    }

    $fqdn = $Global:DomainMap[$Domain]

    try {
      $user = Get-ADUser -Identity $UserID -Server $fqdn -Properties MemberOf -ErrorAction Stop

      if ($ShowGroupNames) {
        $user.MemberOf | ForEach-Object {
          try {
            Get-ADGroup -Identity $_ -Server $fqdn | Select-Object Name, GroupScope, GroupCategory
          }
          catch {
            Write-Warning "Could not resolve group: $_"
          }
        }
      }
      else {
        return $user.MemberOf
      }
    }
    catch {
      Write-Error "Failed to get groups for '$UserID' in domain '$fqdn': $($_.Exception.Message)"
      return $null
    }
  }
}