input_file = "data/licenses.csv"

licenses = []

with open(input_file, "r") as file:
    next(file)

    for line in file:
        line = line.strip()

        if line == "":
            continue

        parts = line.split(",")

        if len(parts) != 6:
            print(f"Skipping malformed record: {line}")
            continue

        app_name = parts[0]
        owner = parts[1]
        seats_purchased = parts[2]
        seats_used = parts[3]
        days_until_renewal = parts[4]
        status = parts[5]

        if not seats_purchased.isdigit() or not seats_used.isdigit() or not days_until_renewal.lstrip("-").isdigit():
            print(f"Skipping invalid numeric value: {line}")
            continue

        seats_purchased = int(seats_purchased)
        seats_used = int(seats_used)
        days_until_renewal = int(days_until_renewal)

        license_record = (app_name, owner, seats_purchased, seats_used, days_until_renewal, status)
        licenses.append(license_record)

print("LICENSE AUDIT REPORT")
print("====================")

for license_record in licenses:
    app_name = license_record[0]
    owner = license_record[1]
    seats_purchased = license_record[2]
    seats_used = license_record[3]
    days_until_renewal = license_record[4]
    status = license_record[5]

    if status != "active":
        renewal_status = "IGNORE"
    elif days_until_renewal < 0:
        renewal_status = "OVERDUE"
    elif days_until_renewal <= 30:
        renewal_status = "RENEWAL_REVIEW"
    else:
        renewal_status = "OK"

    if seats_used > seats_purchased:
        seat_status = "OVER_ALLOCATED"
    else:
        seat_status = "SEATS_OK"

    print(f"{app_name} | {owner} | used={seats_used}/{seats_purchased} | renewal={days_until_renewal} days | {renewal_status} | {seat_status}")
