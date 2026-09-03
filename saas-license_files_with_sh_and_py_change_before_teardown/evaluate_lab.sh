#!/usr/bin/env bash

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_ROOT" || exit 1

PASS_COUNT=0
FAIL_COUNT=0
TEMP_DIR="$(mktemp -d)"

pass() {
    echo "PASS - $1"
    PASS_COUNT=$((PASS_COUNT + 1))
}

fail() {
    echo "FAIL - $1"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

check_contains() {
    local label="$1"
    local content="$2"
    local expected="$3"

    if printf "%s" "$content" | grep -Fq "$expected"; then
        pass "$label"
    else
        fail "$label"
    fi
}

check_file_contains() {
    local label="$1"
    local file="$2"
    local expected="$3"

    if [ -f "$file" ] && grep -Fq "$expected" "$file"; then
        pass "$label"
    else
        fail "$label"
    fi
}

cleanup() {
    if [ -f "$TEMP_DIR/licenses.csv" ]; then
        cp "$TEMP_DIR/licenses.csv" data/licenses.csv
    fi

    rm -f reports/*.txt archive/*.txt

    if [ -d "$TEMP_DIR/reports" ]; then
        cp -R "$TEMP_DIR/reports/." reports/ 2>/dev/null
    fi

    if [ -d "$TEMP_DIR/archive" ]; then
        cp -R "$TEMP_DIR/archive/." archive/ 2>/dev/null
    fi

    rm -rf "$TEMP_DIR"
}

trap cleanup EXIT

mkdir -p data scripts reports archive
cp data/licenses.csv "$TEMP_DIR/licenses.csv"
mkdir -p "$TEMP_DIR/reports" "$TEMP_DIR/archive"
cp -R reports/. "$TEMP_DIR/reports/" 2>/dev/null
cp -R archive/. "$TEMP_DIR/archive/" 2>/dev/null

rm -f reports/*.txt archive/*.txt

echo "Running Lab 3 functional evaluation..."
echo

LICENSE_OUTPUT="$(python scripts/license_audit.py 2>&1)"
LICENSE_EXIT_CODE=$?

if [ "$LICENSE_EXIT_CODE" -eq 0 ]; then
    pass "license_audit.py exits successfully"
else
    fail "license_audit.py exits successfully"
fi

check_contains "license audit flags Slack renewal review" "$LICENSE_OUTPUT" "Slack | IT | used=118/120 | renewal=21 days | RENEWAL_REVIEW | SEATS_OK"
check_contains "license audit flags Figma seat over-allocation" "$LICENSE_OUTPUT" "Figma | Design | used=29/25 | renewal=12 days | RENEWAL_REVIEW | OVER_ALLOCATED"
check_contains "license audit flags Tableau overdue and over-allocated" "$LICENSE_OUTPUT" "Tableau | Data | used=32/30 | renewal=-5 days | OVERDUE | OVER_ALLOCATED"
check_contains "license audit ignores inactive Miro renewal" "$LICENSE_OUTPUT" "Miro | Design | used=18/40 | renewal=7 days | IGNORE | SEATS_OK"

SUMMARY_OUTPUT="$(python scripts/owner_summary.py 2>&1)"
SUMMARY_EXIT_CODE=$?

if [ "$SUMMARY_EXIT_CODE" -eq 0 ]; then
    pass "owner_summary.py exits successfully"
else
    fail "owner_summary.py exits successfully"
fi

check_contains "owner summary counts IT" "$SUMMARY_OUTPUT" "IT: 1"
check_contains "owner summary counts Design active licenses only" "$SUMMARY_OUTPUT" "Design: 1"
check_contains "owner summary counts Engineering" "$SUMMARY_OUTPUT" "Engineering: 1"

ADD_OUTPUT="$(printf 'Asana\nOperations\n50\n38\n28\nactive\n' | python scripts/add_license.py 2>&1)"
ADD_EXIT_CODE=$?

if [ "$ADD_EXIT_CODE" -eq 0 ]; then
    pass "add_license.py accepts valid input"
else
    fail "add_license.py accepts valid input"
fi

if grep -Fxq "Asana,Operations,50,38,28,active" data/licenses.csv; then
    pass "add_license.py appends a valid CSV record"
else
    fail "add_license.py appends a valid CSV record"
fi

cp data/licenses.csv "$TEMP_DIR/before_invalid_add.csv"
INVALID_ADD_OUTPUT="$(printf '\nOperations\n50\n38\n28\nactive\n' | python scripts/add_license.py 2>&1)"
INVALID_ADD_EXIT_CODE=$?

if [ "$INVALID_ADD_EXIT_CODE" -eq 0 ] && cmp -s "$TEMP_DIR/before_invalid_add.csv" data/licenses.csv; then
    pass "add_license.py rejects a blank app name without changing data"
else
    fail "add_license.py rejects a blank app name without changing data"
fi

cp "$TEMP_DIR/licenses.csv" data/licenses.csv
rm -f reports/*.txt archive/*.txt

MENU_OUTPUT="$(printf '1\n2\n4\n5\n' | bash license_menu.sh 2>&1)"
MENU_EXIT_CODE=$?

if [ "$MENU_EXIT_CODE" -eq 0 ]; then
    pass "license_menu.sh exits cleanly after option 5"
else
    fail "license_menu.sh exits cleanly after option 5"
fi

check_file_contains "menu creates license_report.txt" "reports/license_report.txt" "LICENSE AUDIT REPORT"
check_file_contains "menu creates owner_report.txt" "reports/owner_report.txt" "OWNER SUMMARY"
check_file_contains "archive contains license_report.txt" "archive/license_report.txt" "LICENSE AUDIT REPORT"
check_file_contains "archive contains owner_report.txt" "archive/owner_report.txt" "OWNER SUMMARY"

echo
echo "Results: $PASS_COUNT passed, $FAIL_COUNT failed."

if [ "$FAIL_COUNT" -eq 0 ]; then
    echo "Lab 3 evaluation passed."
    exit 0
else
    echo "Lab 3 evaluation failed. Continue troubleshooting the application code."
    exit 1
fi
