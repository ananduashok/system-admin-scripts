# System Admin Scripts

A collection of **Linux system administration scripts** designed to automate common operational tasks such as monitoring system health, checking network connectivity, analyzing login activity, and maintaining system logs.

These scripts are written in **Bash** and are intended to help system administrators simplify routine maintenance and troubleshooting.

---

## Features

- Automates common **system administration tasks**
- Helps monitor **system health and security**
- Useful for **Linux servers and virtual machines**
- Lightweight **Bash scripts with minimal dependencies**
- Easy to modify and extend

---

## Repository Structure

| Script | Description |
|------|-------------|
| `backup.sh` | Performs basic backup operations for important files or directories. |
| `cleanup.sh` | Cleans temporary files and unnecessary data to free system space. |
| `failed-login-monitor.sh` | Monitors and reports failed login attempts from system logs. |
| `network-connectivity-tester.sh` | Tests connectivity to remote hosts or services. |
| `nw-tester.sh` | Simple network testing utility. |
| `port-scanner.sh` | Scans open ports on a target host. |
| `security-update-log-cleaner.sh` | Cleans or manages security update logs. |
| `user-logins.sh` | Displays user login information and session details. |
| `vm-health-check.sh` | Performs a basic health check of a Linux VM (CPU, memory, disk usage etc). |

---

## Requirements

- Linux system
- Bash shell
- Standard Linux utilities such as:
  - `grep`
  - `awk`
  - `netstat` or `ss`
  - `df`
  - `top`
  - `ping`

Some scripts may require **sudo privileges** to access system logs or network information.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/ananduashok/system-admin-scripts.git
cd system-admin-scripts
```

Make scripts executable:

```bash
chmod +x *.sh
```

---

## Usage Examples

Run a script directly from the terminal.

### VM Health Check

```bash
./vm-health-check.sh
```

### Scan Open Ports

```bash
./port-scanner.sh <target-ip>
```

### Check Failed Login Attempts

```bash
./failed-login-monitor.sh
```

---

## Use Cases

These scripts are useful for:

- Linux system administrators
- DevOps engineers
- Server monitoring and troubleshooting
- Security monitoring
- Learning Bash automation

---

## Contributing

Contributions are welcome.

If you would like to improve the scripts:

1. Fork the repository
2. Create a new branch
3. Submit a Pull Request

---

## Author

**Anandu Ashok**  
System Administrator | DevOps & Data Science Enthusiast

GitHub:  
https://github.com/ananduashok
