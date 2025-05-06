import subprocess
import argparse
import os

# Define colors
CYAN = "\033[1;36m"
RESET = "\033[0m"

# ASCII art
ascii_art = f"""
{CYAN}####################################################################################################
#                                                                                                  #
#   ________  ___  _________               ________  _______   ________  ________  _________       #
#  |\   ____\|\  \|\___   ___\            |\   __  \|\  ___ \ |\   ____\|\   __  \|\  ____  \      #
#  \ \  \___|\ \  \|___ \  \_|____________\ \  \|\  \ \   __/|\ \  \___|\ \  \|\  \ \ \ \ \  \     #
#   \ \  \  __\ \  \   \ \  \|\____________\ \   _  _\ \  \_|/_\ \  \    \ \  \ \  \ \ \ \ \  \    #
#    \ \  \|\  \ \  \   \ \  \|____________|\ \  \ \  \ \ \  \_|\ \  \____\ \  \_\  \ \ \ \ \  \   #
#     \ \_______\ \__\   \ \__\              \ \__\ \ _\ \_______\ \_______\ \_______\ \ \ \ \  \  #
#      \|_______|\|__|    \|__|               \|__|\|__|\|_______|\|_______|\|_______|\|__| \|__|  #
####################################################################################################{RESET}
"""

# Helper function to run subprocess
def run_script(args):
    try:
        process = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = process.communicate()
        if stdout:
            print(stdout)
        if stderr:
            print(f"Error: {stderr}")
    except Exception as e:
        print(f"Exception occurred: {e}")

# Process API Key Input
def process_api_key(api_key_type, api_key, api_secret=None, tenant_id=None):
    api_key_type = api_key_type.lower()
    script_name_1 = 'api.sh'
    script_name_2 = 'api2.sh'
    script_name_3 = 'api3.sh'

    if api_key_type == "mapbox api key":
        run_script(['C:/Program Files/Git/bin/bash.exe', script_name_1, api_key_type, api_key])
    elif api_key_type == "microsoft azure tenant":
        if not (api_key and api_secret and tenant_id):
            print("Missing required fields for Azure Tenant")
            return
        run_script(['C:/Program Files/Git/bin/bash.exe', script_name_3, api_key, api_secret, tenant_id])
    elif api_key_type in ["microsoft teams webhook", "slack webhook"]:
        run_script(['C:/Program Files/Git/bin/bash.exe', script_name_1, api_key_type, api_key])
    else:
        if api_secret:
            run_script(['C:/Program Files/Git/bin/bash.exe', script_name_2, api_key_type, api_key, api_secret])
        else:
            run_script(['C:/Program Files/Git/bin/bash.exe', script_name_1, api_key_type, api_key])

# Load from file and process each line
def load_api_keys_from_file(file_path):
    if not os.path.isfile(file_path):
        print(f"File not found: {file_path}")
        return

    with open(file_path, 'r') as f:
        for line in f:
            parts = [p.strip() for p in line.strip().split(",")]
            if len(parts) >= 2:
                api_key_type = parts[0]
                api_key = parts[1]
                api_secret = parts[2] if len(parts) > 2 else None
                tenant_id = parts[3] if len(parts) > 3 else None
                print(f"\nProcessing: {api_key_type}")
                process_api_key(api_key_type, api_key, api_secret, tenant_id)
            else:
                print(f"Skipping malformed line: {line.strip()}")

# Main menu (interactive mode)
def main_menu():
    while True:
        print("\nGitHub Recon Tool")
        print("1. Search GitHub with Dorks")
        print("2. Test API Key")
        print("3. Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            result = subprocess.run(['python3', 'github-dork.py'], capture_output=True, text=True)
            print(result.stdout)
        elif choice == "2":
            api_key_type = input("Enter API Key type: ").strip()
            api_key_type = api_key_type.lower()
            if api_key_type == "mapbox api key":
                api_key = input("Enter API Key or Access Token: ")
                process_api_key(api_key_type, api_key)
            elif api_key_type == "microsoft azure tenant":
                client_id = input("Enter Client ID: ")
                client_secret = input("Enter Client Secret: ")
                tenant_id = input("Enter Tenant ID: ")
                process_api_key(api_key_type, client_id, client_secret, tenant_id)
            elif api_key_type in ["microsoft teams webhook", "slack webhook"]:
                webhook = input("Enter Webhook URI: ")
                process_api_key(api_key_type, webhook)
            else:
                api_key = input("Enter API Key or Access Token: ")
                api_secret = input("Enter API Secret (leave blank if not needed): ")
                process_api_key(api_key_type, api_key, api_secret if api_secret else None)
        elif choice == "3":
            print("Exiting...")
            break
        else:
            print("Invalid choice. Please try again.")

# Entry point
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="GitHub Recon + API Testing Tool", add_help=False)
    parser.add_argument("-l", "--load", help="Load API key(s) from a file")
    parser.add_argument("-h", "--help", action="store_true", help="Show help message")

    args = parser.parse_args()

    print(ascii_art)

    if args.help:
        print("""
Usage:
  script.py             Run in interactive mode
  script.py -l file.txt Load API key(s) from file
  script.py -h          Show this help message

File Format:
  Each line should be:
  API_KEY_TYPE,API_KEY,API_SECRET(optional can be secret, data centre, etc.),TENANT_ID(optional)
        """)
    elif args.load:
        load_api_keys_from_file(args.load)
    else:
        main_menu()
