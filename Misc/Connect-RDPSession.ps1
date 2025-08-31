function Connect-RDPSession {
  param(
    [Parameter(Mandatory = $true)]
    [string]$ComputerName
  )

  process {
    mstsc.exe /v:$ComputerName
  }
}