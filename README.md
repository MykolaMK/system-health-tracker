System Health Tracker & Log Analyzer

A lightweight Bash utility for monitoring Linux system metrics, parsing log files for brute-force login attempts, and creating optional user-driven directory backups.
Features

    System Health Monitoring: Collects key metrics including disk space (df -h), RAM usage (free -m), active user (whoami), and primary IP address.

    Security Log Analysis: Parses /var/log/auth.log for failed password attempts, extracting and counting source IP addresses to identify potential brute-force activity.

    Interactive Backup Utility: Interactive menu (case loop) asking the user whether to create an archived tarball (.tar.gz) of a specified directory.

    Automated Reporting: Generates timestamped log files in ./reports/report_YYYY-MM-DD.log.

Prerequisites

    OS: Linux (Tested on Ubuntu 24.04 LTS)

    Permissions: Read access to /var/log/auth.log

    Shell: Bash

Usage

    Clone the repository:
    Bash

    git clone [https://github.com/MykolaMK/system-health-tracker.git](https://github.com/MykolaMK/system-health-tracker.git)
    cd system-health-tracker

    Make the script executable:
    Bash

    chmod +x system_health.sh

    Run the script:
    Bash

    ./system_health.sh

Sample Output (Generated Report)
Plaintext

=== UŻYCIE DYSKU ===
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2        49G  7.5G   39G  17% /

=== UŻYCIE RAM ===
               total        used        free      shared  buff/cache   available
Mem:            7936        1254        4563          32        2398        6681

=== NAZWA UŻYTKOWNIKA ===
user

=== ADRES IP UŻYTKOWNIKA ===
192.168.1.100

Created as part of Junior SOC Analyst practical portfolio preparation.
> **Note on Localization:** The script interface, interactive prompts, and generated log headers use Polish for local system administration requirements. Technical documentation and commit history are maintained in English.