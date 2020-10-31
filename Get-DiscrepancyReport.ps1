Function Get-DiscrepancyReport {
    param(
        $MsolUsers,
        $SlackUsers
    )

    $ReportItemTemplate = [PSCustomObject]@{
        Email            = $null
        MsolDisplayName  = $null
        SlackDisplayName = $null
        MsolFirstName    = $null
        SlackFirstName   = $null
        MsolLastName     = $null
        SlackLastName    = $null
        MsolTitle        = $null
        SlackTitle       = $null
        Discrepancy      = $null
    }

    [System.Collections.ArrayList]$ReportArray = @()

    foreach ($MsolUser in $MsolUsers) {
        if ($SlackUsers.email -contains $MsolUser.UserPrincipalName) {
            $SlackUser = $SlackUsers | Where-Object { $_.email -eq $MsolUser.UserPrincipalName } | Select-Object -First 1
            $ReportItem = $ReportItemTemplate

            $ReportItem.Email = $MsolUser.UserPrincipalName
            $ReportItem.MsolDisplayName = $MsolUser.DisplayName
            $ReportItem.SlackDisplayName = $SlackUser.DisplayName
            $ReportItem.MsolFirstName = $MsolUser.FirstName
            $ReportItem.SlackFirstName = $SlackUser.FirstName
            $ReportItem.MsolLastName = $MsolUser.LastName
            $ReportItem.SlackLastName = $SlackUser.Last_Name
            $ReportItem.MsolTitle = $MsolUser.Title
            $ReportItem.SlackTitle = $SlackUser.raw.profile.Title

            if ( $ReportItem.MsolDisplayName -ne $ReportItem.SlackDisplayName -or $ReportItem.MsolFirstName -ne $ReportItem.SlackFirstName -or `
                $ReportItem.MsolLastName -ne $ReportItem.SlackLastName -or $ReportItem.MsolTitle -ne $ReportItem.SlackTitle ) {
                    $ReportItem.Discrepancy = $true
            }
            else { $ReportItem.Discrepancy = $false }

            $ReportItem
        }
    }
}