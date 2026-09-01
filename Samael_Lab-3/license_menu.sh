#!/usr/bin/env bash

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_ROOT" || exit 1

while true
do
    echo
    echo "============================"
    echo " SaaS License Audit System"
    echo "============================"
    echo "1 - Run License Audit"
    echo "2 - Run Owner Summary"
    echo "3 - Add License Record"
    echo "4 - Archive Reports"
    echo "5 - Exit"
    echo

    if ! read -r -p "Select option: " choice
    then
        echo "Input closed. Exiting."
        exit 1
    fi

    case "$choice" in
        1)
            python scripts/license_audit.py > reports/license_report.txt
            echo "License report generated."
            ;;
        2)
            python scripts/owner_summary.py > reports/owner_report.txt
            echo "Owner report generated."
            ;;
        3)
            python scripts/add_license.py
            ;;
        4)
            cp reports/*.txt archive/
            echo "Reports archived."
            ;;
        5)
            echo "Goodbye."
            exit 0
            ;;
        *)
            echo "Invalid selection."
            ;;
    esac
done
