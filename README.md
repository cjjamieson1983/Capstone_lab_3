# Lab 3: SaaS License Audit Troubleshooting Lab

## Scenario

You are a junior automation analyst on an internal IT operations team.

The company tracks software subscriptions in a simple CSV export. The finance and IT teams need a small internal command-line tool that can:

- audit SaaS licenses for renewal risk,
- identify seat over-allocation,
- summarize active licenses by owner team,
- add new license records,
- generate reports,
- archive reports for review.

A previous contractor started the tool, but it is broken. Your task is to troubleshoot and repair it.

The application contains both syntax errors and logic errors.

---

## Project Layout

```text
lab3-saas-license-troubleshooting/
├── README.md
├── evaluate_lab.sh
├── license_menu.sh
├── reset_lab.sh
├── archive/
├── data/
│   └── licenses.csv
├── docs/
│   └── expected-output.md
├── reports/
└── scripts/
    ├── add_license.py
    ├── license_audit.py
    └── owner_summary.py
```

---

## Setup

Move into the lab folder:

```bash
cd lab3-saas-license-troubleshooting
```

Make the shell scripts executable:

```bash
chmod +x license_menu.sh evaluate_lab.sh reset_lab.sh
```

Run the menu:

```bash
./license_menu.sh
```

You can also test each Python script directly:

```bash
python3 scripts/license_audit.py
python3 scripts/owner_summary.py
python3 scripts/add_license.py
```

---

## Business Rules

### License Audit

The license audit reads:

```text
data/licenses.csv
```

Each valid row has this format:

```text
app_name,owner,seats_purchased,seats_used,days_until_renewal,status
```

The license audit should classify each valid row with two statuses.

Renewal status:

| Rule | Status |
|---|---|
| inactive license | `IGNORE` |
| active and days_until_renewal < 0 | `OVERDUE` |
| active and days_until_renewal <= 30 | `RENEWAL_REVIEW` |
| active and days_until_renewal > 30 | `OK` |

Seat status:

| Rule | Status |
|---|---|
| seats_used > seats_purchased | `OVER_ALLOCATED` |
| otherwise | `SEATS_OK` |

Malformed records and rows with invalid numeric values should be skipped instead of crashing the program.

---

### Owner Summary

The owner summary should count only valid active licenses by owner team.

For the original data, the expected owner summary is:

```text
IT: 1
Operations: 1
Design: 1
Product: 1
Data: 1
Engineering: 1
```

Inactive licenses, malformed records, and records with invalid numeric values should not be counted.

---

### Add License

The add-license script should ask for:

```text
Application name
Owner team
Seats purchased
Seats used
Days until renewal
Status
```

It should reject:

```text
blank application name
blank owner
non-numeric seat counts
non-numeric renewal days
any status other than active or inactive
```

For valid input, it should append exactly one CSV row to:

```text
data/licenses.csv
```

Example valid row:

```text
Asana,Operations,50,38,28,active
```

---

### Bash Menu

The Bash menu should keep running until option `5` is selected.

| Option | Required Behavior |
|---:|---|
| `1` | Run `license_audit.py` and write `reports/license_report.txt` |
| `2` | Run `owner_summary.py` and write `reports/owner_report.txt` |
| `3` | Run `add_license.py` interactively |
| `4` | Copy generated `.txt` reports into `archive/` |
| `5` | Exit successfully |
| other input | Show invalid selection and continue |

---

## Suggested Troubleshooting Flow

1. Check Bash syntax:

```bash
bash -n license_menu.sh
```

2. Check Python syntax:

```bash
python3 -m py_compile scripts/license_audit.py
python3 -m py_compile scripts/owner_summary.py
python3 -m py_compile scripts/add_license.py
```

3. Run the Python files directly.

4. Run the menu options one at a time.

5. Compare your generated reports to:

```text
docs/expected-output.md
```

6. Run the evaluator.

---

## Evaluation

After repairing the lab, run:

```bash
./evaluate_lab.sh
```

A passing solution ends with:

```text
Results: 18 passed, 0 failed.
Lab 3 evaluation passed.
```

The evaluator temporarily modifies files while testing and restores the original data, reports, and archive contents before exiting.

---

## Reset

To manually restore the starting data and clear generated reports:

```bash
./reset_lab.sh
```

---

## Teardown

From the parent directory:

```bash
rm -rf lab3-saas-license-troubleshooting
```

Use `rm -rf` carefully.

---

## Reflection Questions

1. Which bugs were syntax errors?
2. Which bugs were logic errors?
3. Why should CSV input be validated before unpacking fields?
4. Why should automation tools skip bad records instead of crashing?
5. Why is it useful to test Python files directly before testing the Bash menu?
6. Why should the evaluator restore the original data after testing?
