function Get-ADComputerDetail {
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline)]
    [string]$ComputerID,

    [Parameter(Mandatory = $true)]
    [ValidateSet('prod', 'main', 'customer', 'sec')]
    [string]$Domain,

    [switch]$TestConnectivity
  )

  process {
    if (-not $Global:DomainMap.ContainsKey($Domain)) {
      throw "Invalid domain code '$Domain'. Valid options: $($Global:DomainMap.Keys -join ', ')"
    }

    $fqdn = $Global:DomainMap[$Domain]

    try {
      $computer = Get-ADComputer -Identity $ComputerID -Server $fqdn -Properties DNSHostName, Enabled, CanonicalName, DistinguishedName, LastLogonDate, OperatingSystem, IPv4Address, IPv6Address, MemberOf, Description

      $result = $computer | Select-Object Name, DNSHostName, Enabled, CanonicalName, DistinguishedName, LastLogonDate, OperatingSystem, IPv4Address, IPv6Address, MemberOf, Description,
      @{N = 'Domain'; E = { $Domain } },
      @{N = 'DomainFQDN'; E = { $fqdn } },
      @{N = 'QueryTime'; E = { Get-Date } }

      if ($TestConnectivity -and $computer.DNSHostName) {
        $result | Add-Member -NotePropertyName 'IsOnline' -NotePropertyValue (Test-Connection -ComputerName $computer.DNSHostName -Count 1 -Quiet)
      }

      return $result
    }
    catch {
      Write-Error "Failed to find computer '$ComputerID' in domain '$fqdn': $($_.Exception.Message)"
      return $null
    }
  }
}