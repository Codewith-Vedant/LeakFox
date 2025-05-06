import subprocess
import argparse
import os
import json
import re

# Color codes for styling
CYAN = "\033[96m"
RESET = "\033[0m"
RED = "\033[91m"
GREEN = "\033[92m"
YELLOW = "\033[93m"

# Banner
print(CYAN)
print("""
$$\\                          $$\\             $$$$$$$$\\                  
$$ |                         $$ |            $$  _____|                 
$$ |      $$$$$$\\   $$$$$$\\  $$ |  $$\\       $$ |    $$$$$$\\  $$\\   $$\\ 
$$ |     $$  __$$\\  \\____$$\\ $$ | $$  |      $$$$$\\ $$  __$$\\ \\$$\\ $$  |
$$ |     $$$$$$$$ | $$$$$$$ |$$$$$$  /       $$  __|$$ /  $$ | \\$ $$$/ 
$$ |     $$   ____|$$  __$$ |$$  _$$<        $$ |   $$ |  $$ | $$  $$<  
$$$$$$$$\\$$$$$$$\\ \\$$$$$$$  |$$ | \\$\\        $$ |   \\$$$$$$  |$$  /\\$$\\ 
\\________|\\_______| \\_______|\\__|  \\__|      \\__|    \\______/ \\__/  \\__|
      Missing API Key? LeakFox has you covered!
      Starting Mission...
""")
print(RESET)

def run_script(args, quiet=False):
    try:
        process = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = process.communicate()

        status = "failure"
        if stdout:
            status = clean_output(stdout, quiet=quiet)
        if stderr:
            status = clean_output(stderr, is_error=True, quiet=quiet)

        if quiet:
            if status == "success":
                print(f"{GREEN}[+] Success{RESET}")
            else:
                print(f"{RED}[-] Failure{RESET}")

    except FileNotFoundError:
        print(f"{RED}[!] Script not found: {args[1]}{RESET}")
    except Exception as e:
        print(f"{RED}[!] Error running script: {e}{RESET}")

def clean_output(output, is_error=False, quiet=False):
    skip_patterns = [
        r"^\s*% Total", r"^\s*\d+\s+\d+", r"^\s*Dload", r"^\s*\d+\s+\d+.*--:--:--",
        r"^HTTP/", r"^Content-Type:", r"^x-", r"^Server:", r"^Vary:", r"^Strict-Transport-Security:",
        r"^Content-Length:", r"^Connection:", r"^Date:", r"^Akamai-", r"^intuit_tid:", r"^Link:"
    ]

    lines = output.splitlines()
    printed = False

    for line in lines:
        line = line.strip()
        if is_error and "curl:" in line:
            if not quiet:
                print(f"{RED}[!] Error: {line}{RESET}")
            return "failure"
        elif not any(re.match(pat, line) for pat in skip_patterns):
            if not quiet:
                print(f"  {line}")
            printed = True

    if any(keyword in line for line in lines for keyword in ["{\"ok\":true", "\"status\":\"success\"", "\"access_token\""]):
        return "success"
    elif printed:
        return "success"
    return "failure"

def process_api_key(api_key_type, api_key, api_secret=None, tenant_id=None, quiet=False):
    try:
        api_key_type = api_key_type.lower()
        script_name_1 = 'api.sh'
        script_name_2 = 'api2.sh'
        script_name_3 = 'api3.sh'

        if not quiet:
            print(f"{YELLOW}[*] Output:{RESET}")

        if api_key_type == "mapbox api key":
            run_script(['C:/Program Files/Git/bin/bash.exe', script_name_1, api_key_type, api_key], quiet)
        elif api_key_type == "microsoft azure tenant":
            if not (api_key and api_secret and tenant_id):
                if not quiet:
                    print(f"{RED}[!] Missing required fields for Azure Tenant{RESET}")
                return
            run_script(['C:/Program Files/Git/bin/bash.exe', script_name_3, api_key, api_secret, tenant_id], quiet)
        elif api_key_type in ["microsoft teams webhook", "slack webhook"]:
            run_script(['C:/Program Files/Git/bin/bash.exe', script_name_1, api_key_type, api_key], quiet)
        else:
            if api_secret:
                run_script(['C:/Program Files/Git/bin/bash.exe', script_name_2, api_key_type, api_key, api_secret], quiet)
            else:
                run_script(['C:/Program Files/Git/bin/bash.exe', script_name_1, api_key_type, api_key], quiet)
    except Exception as e:
        if not quiet:
            print(f"{RED}[!] Unexpected error: {e}{RESET}")

def load_api_keys_from_file(file_path, quiet=False):
    try:
        if not os.path.isfile(file_path):
            print(f"{RED}[!] File not found: {file_path}{RESET}")
            return

        with open(file_path, 'r') as f:
            lines = f.readlines()
            if not lines:
                print(f"{RED}[!] API key file is empty or malformed.{RESET}")
                return

            for idx, line in enumerate(lines, 1):
                try:
                    parts = [p.strip() for p in line.strip().split(",")]
                    if len(parts) >= 2:
                        api_key_type = parts[0]
                        api_key = parts[1]
                        api_secret = parts[2] if len(parts) > 2 else None
                        tenant_id = parts[3] if len(parts) > 3 else None
                        if not quiet:
                            print(f"\n{GREEN}Processing line {idx}: {api_key_type}{RESET}")
                        process_api_key(api_key_type, api_key, api_secret, tenant_id, quiet)
                    else:
                        print(f"{RED}[!] Skipping malformed line {idx}: {line.strip()}{RESET}")
                except Exception as e:
                    print(f"{RED}[!] Error processing line {idx}: {e}{RESET}")
    except Exception as e:
        print(f"{RED}[!] Failed to load file: {e}{RESET}")

def main_menu():
    try:
        while True:
            print("\nAPI Testing Tool")
            print("1. Test API Key")
            print("2. Exit")
            choice = input("Enter your choice: ")

            if choice == "1":
                print(f"{YELLOW}Enter the API Key type exactly as one of the following supported types:{RESET}")
                with open("supported_api_keys.txt", "r") as f:
                    print(f.read())
                try:
                    api_key_type = input("Enter API Key type: ").strip().lower()
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
                except Exception as e:
                    print(f"{RED}[!] Error in input: {e}{RESET}")
            elif choice == "2":
                print("Mission Abort...")
                break
            else:
                print(f"{RED}[!] Invalid choice. Please try again.{RESET}")
    except KeyboardInterrupt:
        print("\nInterrupted by user. Exiting...")
    except Exception as e:
        print(f"{RED}[!] Unexpected error in main menu: {e}{RESET}")

if __name__ == "__main__":
    try:
        parser = argparse.ArgumentParser(description="Automated API Testing Tool", add_help=False)
        parser.add_argument("-l", "--load", help="Load API key(s) from a file")
        parser.add_argument("-q", "--quiet", action="store_true", help="Run in quiet mode")
        parser.add_argument("-h", "--help", action="store_true", help="Show help message")
        args = parser.parse_args()

        if args.help:
            print("""
Usage:
  LeakFox.py               Run in interactive mode
  LeakFox.py -l file.txt   Load API key(s) from file
  LeakFox.py -q            Run in quiet mode (minimal output)
  LeakFox.py -l file.txt -q  Load API key(s) from file with quiet mode
  LeakFox.py -h            Show help message

File Format:
  Each line should be:
  API_KEY_TYPE,API_KEY,API_SECRET(optional),TENANT_ID(only for microsoft azure tenant)
            """)
        elif args.load:
            load_api_keys_from_file(args.load, args.quiet)
        else:
            main_menu()
    except Exception as e:
        print(f"{RED}[!] Error starting application: {e}{RESET}")
    except KeyboardInterrupt:
        print("\nMission Abort...")
