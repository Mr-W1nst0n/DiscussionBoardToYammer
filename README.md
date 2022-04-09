# DiscussionBoardToYammer

This is one way to migrate contents from a SharePoint Discussion Board list to Yammer Platform

## Requirement for Yammer
- Generate a Developer Token in Yammer *(https://www.yammer.com/client_applications)*
- Decode the Yammer GroupId Base64

```
$GroupId = 'eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyNzY0NDcxNTAwOSJ9
$decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($GroupId))
Write-Output $decoded
```

## Requirement for SharePoint
- Export Discussion Board list items in **_XLSX_** extension

## Current Limitations
- No **Reply** messages will be migrated *(Only the body of the discussion)*
