function New-ADAccount {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Identity,

    [Parameter(Mandatory = $true)]
    [ValidateSet('prod', 'main', 'customer', 'sec')]
    [string]$Domain,

    [string]$FName,
    [string]$LName
  )

  process {
    if (-not $Global:DomainMap.ContainsKey($Domain)) {
      throw "Invalid domain code '$Domain'. Valid options: $($Global:DomainMap.Keys -join ', ')"
    }

    $fqdn = $Global:DomainMap[$Domain]

    try {
      New-ADUser -Name $Identity -Server $fqdn -Enabled false

      Get-ADUserDetail -UserID $Identity -Domain $Domain

    }
    catch {
      Write-Error "Failed to get connect to '$fqdn': $($_.Exception.Message)"
      return $null
    }
  }
}