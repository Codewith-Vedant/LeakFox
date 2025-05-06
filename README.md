# Git-recon

**Git-recon** is an advanced tool designed to **automate the discovery of sensitive data leaks** in GitHub repositories. By scanning for secrets like API keys, passwords, and configuration details, Git-recon empowers organizations to identify and address potential vulnerabilities effectively.


---

## Features
### 1. **Automated GitHub Reconnaissance**
   - Scans repositories for **credentials, secrets, and sensitive information** using an extensive dork list.
   - Supports file-specific searches (e.g., `.env`, `.config`, `.json`).
   - Detects sensitive data for platforms such as **AWS**, **Google Cloud**, **Slack**, and more.

### 2. **API Key Validation**
   - **Test the validity of discovered API keys** to assess their functionality and associated risks.
   - Helps prioritize remediation efforts for active keys.

---
## Different API Keys that can be validated
{List}
---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Codewith-Vedant/git-recon.git
   cd git-recon
   pip install -r requirements.txt

## Requirements to run the tool

1. Python
2. pip
3. GitHub API Token (for private repository scanning)
4. GitHub Personal Access Token (for public repository scanning)

## Security and Privacy

Git-recon only analyzes repositories accessible through the provided credentials and does not retain any sensitive information. Ensure your personal access tokens have the minimal necessary permissions to maintain security.
