﻿
function Invoke-Process {
    [CmdletBinding()]
    [OutputType()]
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        
        [Alias('Executable')]
        [string] $Path,

        [Parameter(Mandatory = $true, Position = 2)]
        [string[]] $Params,

        [Parameter(Mandatory = $False, Position = 3 )]
        [switch] $ShowOriginalProgress
    )

    Invoke-TimeSignal -Start

    if (-not (Test-PathExists -Path $Path -Type Leaf)) {return}

    if (Test-PSFFunctionInterrupt) { return }

    $tool = Split-Path -Path $Path -Leaf

    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "$Path"
    
    if (-not $ShowOriginalProgress) {
        Write-PSFMessage -Level Verbose "Output and Error streams will be redirected (silence mode)"

        $pinfo.RedirectStandardError = $true
        $pinfo.RedirectStandardOutput = $true
    }

    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = "$($Params -join " ")"
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo

    Write-PSFMessage -Level Verbose "Starting the $tool" -Target "$($params -join " ")"
    $p.Start() | Out-Null
    
    if (-not $ShowOriginalProgress) {
        $stdout = $p.StandardOutput.ReadToEnd()
        $stderr = $p.StandardError.ReadToEnd()
    }

    Write-PSFMessage -Level Verbose "Waiting for the $tool to complete"
    $p.WaitForExit()

    if ($p.ExitCode -ne 0 -and (-not $ShowOriginalProgress)) {
        Write-PSFMessage -Level Host "Exit code from $tool indicated an error happened. Will output both standard stream and error stream."
        Write-PSFMessage -Level Host "Standard output was: \r\n $stdout"
        Write-PSFMessage -Level Host "Error output was: \r\n $stderr"

        Stop-PSFFunction -Message "Stopping because an Exit Code from $tool wasn't 0 (zero) like expected." -StepsUpward 1
        return
    }
    else {
        Write-PSFMessage -Level Verbose "Standard output was: \r\n $stdout"
    }

    Invoke-TimeSignal -End
}