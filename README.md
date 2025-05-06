# LeakFox

**LeakFox** is a powerful tool designed to **detect and validate API keys, secrets, and sensitive information**. It automates the process of testing API keys for functionality and helps identify potential vulnerabilities in your systems. LeakFox supports a wide range of API key types and provides detailed feedback for remediation.

---

## Features

### 1. **API Key Detection and Validation**
   - Supports **75 different API key types**.
   - Validates API keys to check their functionality and associated risks.
   - Helps prioritize remediation efforts for active and valid keys.

### 2. **Customizable Scanning**
   - Load API keys from a file for batch processing.
   - Supports interactive mode for manual API key testing.
   - Quiet mode for minimal output during automated scans.

### 3. **Extensive API Key Coverage**
   - Detects and validates API keys for platforms such as:
     - AWS
     - Google Cloud
     - Slack
     - Stripe
     - PagerDuty
     - And many more (see the full list below).

### 4. **Cross-Platform Support**
   - Works on both **Windows** and **Linux** systems.
   - Includes platform-specific scripts for enhanced compatibility.

### 5. **Detailed Reporting**
   - Provides clear and actionable feedback for each API key tested.
   - Highlights missing or invalid fields for specific API key types.

---

## Supported API Key Types

LeakFox supports the detection and validation of the following API key types:

1. AWS Access Key ID and Secret  
2. Google Maps API Key  
3. Slack Webhook  
4. Stripe Access Token  
5. PagerDuty API Token  
6. Microsoft Teams Webhook  
7. Twitter Bearer Token  
8. Shodan API Key  
9. Firebase Cloud Messaging Key  
10. GitLab Personal Access Token  
11. Mailgun Private Key  
12. SendGrid API Token  
13. Mapbox API Key  
14. HubSpot Private App API Key  
15. Spotify Access Token  
16. Heroku API Key  
17. Telegram Bot API Token  
18. Bit.ly Access Token  
19. Buildkite Access Token  
20. CircleCI Access Token  
21. Dropbox API Key  
22. Wakatime API Key  
23. New Relic Personal API Key  
24. Azure Application Insights API Key  
25. Datadog API Key  
26. Freshdesk API Key  
27. LinkedIn OAuth Key  
28. Salesforce API Key  
29. YouTube API Key  
30. Iterable API Key  
31. Visual Studio App Center API Token  
32. Asana Access Token  
33. Amplitude API Key  
34. Weglot API Key  
35. Calendly API Key  
36. Opsgenie API Key  
37. Bing Maps API Key  
38. ButterCMS API Key  
39. Razorpay API Key  
40. Contentful Access Token  
41. DeviantArt Secret  
42. Facebook App Secret  
43. PayPal Client ID and Secret  
44. Mailchimp API Key  
45. SauceLabs Access Key  
46. Twilio Account SID and Auth Token  
47. Twitter API Secret  
48. Grafana Access Token  
49. Help Scout OAuth Token  
50. IPStack API Key  
51. WP Engine API Key  
52. Bazaarvoice Passkey  
53. PivotalTracker API Token  
54. Square Auth Token  
55. NPM Token  
56. ORS API Key  
57. Delighted API Key  
58. Loqate API Key  
59. Cloudflare API Key  
60. Instagram Graph API Key  
61. Zapier Webhook Token  
62. Lokalise API Key  
63. Infura API Key  
64. JumpCloud API Key  
65. New Relic REST API Key  
66. Razorpay API Key  
67. Facebook Access Token  
68. Spotify Access Token  
69. Stripe Access Token  
70. SonarCloud Token  
71. Telegram Bot API Token  
72. PagerDuty API Token  
73. Slack API Token  
74. Microsoft Teams Webhook  
75. Travis CI API Token  

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Codewith-Vedant/leakfox.git
   cd leakfox
   pip install -r requirements.txt
   ```

---

## Usage

### 1. **Interactive Mode**
   Run LeakFox in interactive mode to manually test API keys:
   ```bash
   python LeakFox_Windows.py
   ```

### 2. **Load API Keys from a File**
   Test multiple API keys by loading them from a file:
   ```bash
   python LeakFox_Windows.py -l file.txt
   ```

### 3. **Quiet Mode**
   Run LeakFox in quiet mode for minimal output:
   ```bash
   python LeakFox_Windows.py -q
   ```

### 4. **Help**
   Display the help menu:
   ```bash
   python LeakFox_Windows.py -h
   ```

---

## File Format for API Keys

The file should contain one API key per line in the following format:
```
API_KEY_TYPE,API_KEY,API_SECRET(optional and it can be any secret, data centre, etc.),TENANT_ID(optional)
```

Example:
```
aws access key id and secret,AKIAIOSFODNN7EXAMPLE,wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
microsoft azure tenant,client_id,client_secret,tenant_id
mapbox api key,pk.eyJ1IjoiZXhhbXBsZSIsImEiOiJja2V5In0
```

---

## Requirements

1. Python 3.8+
2. pip
3. Bash (for running platform-specific scripts)
4. API Key file (optional)

---

## Security and Privacy

LeakFox only analyzes the provided API keys and does not retain any sensitive information. Ensure your API key files are stored securely and deleted after use.

---

## License

This project is licensed under the MIT License. See the LICENSE[LICENSE} file for details.
