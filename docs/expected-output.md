# Expected Output

## reports/license_report.txt

```text
LICENSE AUDIT REPORT
====================
Slack | IT | used=118/120 | renewal=21 days | RENEWAL_REVIEW | SEATS_OK
Zoom | Operations | used=52/80 | renewal=45 days | OK | SEATS_OK
Figma | Design | used=29/25 | renewal=12 days | RENEWAL_REVIEW | OVER_ALLOCATED
Notion | Product | used=41/60 | renewal=90 days | OK | SEATS_OK
Tableau | Data | used=32/30 | renewal=-5 days | OVERDUE | OVER_ALLOCATED
Miro | Design | used=18/40 | renewal=7 days | IGNORE | SEATS_OK
GitHub | Engineering | used=96/100 | renewal=30 days | RENEWAL_REVIEW | SEATS_OK
```

Malformed or invalid rows may be skipped with a message.

## reports/owner_report.txt

```text
OWNER SUMMARY
=============
IT: 1
Operations: 1
Design: 1
Product: 1
Data: 1
Engineering: 1
```

Inactive licenses and malformed records should not be counted.

## valid add-license input

```text
Application name: Asana
Owner team: Operations
Seats purchased: 50
Seats used: 38
Days until renewal: 28
Status: active
```

Expected new CSV row:

```text
Asana,Operations,50,38,28,active
```
