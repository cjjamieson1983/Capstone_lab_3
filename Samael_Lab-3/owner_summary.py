owner_counts = {}

with open("data/licenses.csv", "r") as file:
    next(file)

    for line in file:
        line = line.strip()

        if line == "":
            continue

        parts = line.split(",")

        if len(parts) != 6:
            continue

        app_name = parts[0]
        owner = parts[1]
        seats_purchased = parts[2]
        seats_used = parts[3]
        days_until_renewal = parts[4]
        status = parts[5]

        if not seats_purchased.isdigit() or not seats_used.isdigit() or not days_until_renewal.lstrip("-").isdigit():
            continue

        if status != "active":
            continue

        if owner in owner_counts:
            owner_counts[owner] += 1
        else:
            owner_counts[owner] = 1

print("OWNER SUMMARY")
print("=============")

for owner, count in owner_counts.items():
    print(f"{owner}: {count}")
