# 0365Slack

The purpose of this project is to automate administration and reporting tasks relating to Office 365 and Slack.

## Contents

Get-DiscrepancyReport: Takes a list of O365 users from Get-MsolUser (MSOnline Module) and a list of users from Get-SlackUser (PSSlack Module) and compares full name, first name, last name, and job title in order to identify discrepancies.