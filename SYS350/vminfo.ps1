Clear-Host
function Option {
Write-Host "=============== Hyper-V VM Info ==============="

Write-Host "1: Get VM Info (IPs, PowerState, and Name)"
Write-Host "2: Get Specific VM Info "
Write-Host "3: Start a VM "
Write-Host "4: Stop a VM "
Write-Host "5: Create a VM Checkpoint "
Write-Host "6: Change VM Network Adapter "
Write-Host "7: Change number of VM Processors "
Write-Host "8: Restore VM to latest Snapshot "
Write-Host "0: Exit the Program"
} 

do
 {
    Option
    $option = Read-Host `n"Please choose an option: "
    switch ($option)
    { 
    '1' {
    Get-VM -Name *
    Get-VM -Name * | select -ExpandProperty networkadapters | select vmname, ipaddresses
    }
    '2' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '

    Get-VM -Name $vmname | select -Property CreationTime, state, Generation, MemoryAssigned, Path    
    }
    '3' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '

    Start-VM -Name $vmname
    }
    '4' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '

    Stop-VM -Name $vmname
    }
    '5' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '
    $snapname = Read-Host -Prompt 'Enter a name for the snapshot: '

    Get-VM -Name $vmname | Checkpoint-VM -SnapshotName $snapname
    }
    '6' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '
    $netname = Read-Host -Prompt 'Enter the network name to change to: '

    Connect-VMNetworkAdapter -VMName $vmname -SwitchName $netname
    }
    '7' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '
    $numcpus = Read-Host -Prompt 'Enter the number of CPUs you want: '

    Set-VMProcessor -VMName $vmname -Count $numcpus
    }
    '8' {
    $vmname = Read-Host -Prompt 'Enter a VM name: '
    $checkname = Read-Host -Prompt 'Enter the name of the Checkpoint to restore to: '

    Restore-VMSnapshot -Name $checkname -VMName $vmname
    }
    }
}
until ($option -eq '0')

Write-Host "Exiting Goodbye"
