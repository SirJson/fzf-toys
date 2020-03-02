function sshconfig () {
    foreach ($l in Get-Content ~/.ssh/config) {
        if ($l -match '^Host\s\w+$') {
            $h = -split $l
            Write-Output $h[1]
        }
    }
}

ssh @(sshconfig | fzf)
