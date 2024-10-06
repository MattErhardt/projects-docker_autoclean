# Docker Autoclean

## Table of Contents
- [Description](#description)
- [How to Run](#how-to-run)
  - [Linux](#linux)
  - [Synology](#synology)

## Description
This is a repo to manage scripts meant to prune dangling images, unused images and unused data

## How to run
### Linux
#### Setup
1. Ensure you have `docker-cleanup.sh` created
   - Clone repo https://github.com/MattErhardt/projects-docker_autoclean.git
   or
   - Manually create `docker-cleanup.sh` by copying the code below:
    ```bash
     #!/bin/bash

    # Remove dangling images
    echo "Removing dangling images..."
    docker image prune -f

    # Remove all unused images
    echo "Removing unused images..."
    docker image prune -af

    # Optional: remove unused volumes and networks
    echo "Removing unused volumes and networks..."
    docker system prune -af

    echo "Docker cleanup completed."

    ```
2. Make the script an executable by running
   ```bash
   sudo chmod +x <path-to-script>/docker-cleanup.sh
   ```
### Running Manually
1. Run executable
```bash
sudo <path-to-executable>/docker-cleanup.sh
```
#### Automating script with cron
   1. **Open the Crontab:** Use the following command to edit the crontab file
   ```bash
   crontab -e
   ```
   2. **Add a Cron Job:** Add a line at the bottom of the file to schedule your cleanup script. For example, to run the script every Sunday at 2 AM, you would add:
   ```bash
   0 2 * * 0 <path-to-script>/docker_cleanup.sh
   ```
   **Cron Timing Format:**
   - `* * * * *` (Minute, Hour, Day of Month, Month, Day of Week)
   - For example: `0 2 * * 0` means "at 2:00 AM every Sunday"
   3. **Save and Exit:** Save the changes and exit the editor
   4. **Verify the Cron Job**
      1. **List Cron Jobs:** You can list your current cron jobs
      ```bash
      crontab -l
      ```
      2. **Check Logs:** If you want to monitor the execution, you can redirect the output of your script to a log file. Modify your cron job to:
      ```bash
      0 2 * * 0 /path/to/your/docker_cleanup.sh >> /path/to/your/cleanup.log 2>&1

      ```
### Synology
#### Setup
1. Ensure you have `docker-cleanup-synology.sh` created
   - Clone repo https://github.com/MattErhardt/projects-docker_autoclean.git
   or
   - Manually create `docker-cleanup-synology.sh` by copying the code below:
    ```bash
      #!/bin/bash

      # Remove dangling images
      echo "Removing dangling images..." >> /volume1/docker/projects-docker_autoclean/cleanup.log
      docker image prune -f >> /volume1/docker/projects-docker_autoclean/cleanup.log 2>&1

      # Remove all unused images
      echo "Removing unused images..." >> /volume1/docker/projects-docker_autoclean/cleanup.log
      docker image prune -af >> /volume1/docker/projects-docker_autoclean/cleanup.log 2>&1

      # Optional: remove unused volumes and networks
      echo "Removing unused volumes and networks..." >> /volume1/docker/projects-docker_autoclean/cleanup.log
      docker system prune -af >> /volume1/docker/projects-docker_autoclean/cleanup.log 2>&1

      echo "Docker cleanup completed." >> /volume1/docker/projects-docker_autoclean/cleanup.log
    ```
2. Make the script an executable by running
   ```bash
   sudo chmod +x <path-to-script>/docker-cleanup-synology.sh
   ```
#### Automating script with Task Scheduler
1. Log in to DSM: Access your Synology NAS via the web interface (DSM).

2. Open Task Scheduler: Navigate to Control Panel > Task Scheduler.

3. Create a New Task: Click on Create and select Scheduled Task > User-defined script.

4. Configure the Task:

   - General Tab:
     - Name: Give your task a meaningful name, e.g., "Docker Cleanup".
     - User: Choose root or an admin user that has permission to run Docker commands.
   - Schedule Tab:
     - Set the schedule as desired (e.g., every Sunday at 2 AM).
   - Task Settings Tab:
     - In the Run command field, enter the full path to your script:
        ```bash
        /bin/bash /volume1/docker/projects-docker_autoclean/docker-cleanup-synology.sh
        ```
5. Save the Task: 
   - Click OK to save your scheduled task.
6. Verify Task
   1. **Check Logs:** Ensure that your cleanup script logs output to /volume1/docker/projects-docker_autoclean/cleanup.log, which you can monitor for any issues.

   2. **Run the Task Manually:** You can manually run the task from the Task Scheduler to ensure it works correctly.

   3. **Monitor Scheduled Runs:** Keep an eye on the cleanup.log file to confirm that the script is running as scheduled.