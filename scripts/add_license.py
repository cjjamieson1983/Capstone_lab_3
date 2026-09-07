app_name = input("Application name: ")
owner = input("Owner team: ")
seats_purchased = input("Seats purchased: ")
seats_used = input("Seats used: ")
days_until_renewal = input("Days until renewal: ")
status = input("Status: ")

if app_name == "" or owner == "":
    print("Application name and owner are required.")

elif not seats_purchased.isdigit() or not seats_used.isdigit() or not days_until_renewal.lstrip("-").isdigit():
    print("Seat counts and renewal days must be whole numbers.")

elif status != "active" and status != "inactive":
    print("Status must be active or inactive.")

else:
    new_license = f"{app_name},{owner},{seats_purchased},{seats_used},{days_until_renewal},{status}\n"

    with open("data/licenses.csv", "a") as file:
        file.write(new_license)

    print(f"{app_name} added successfully.")
