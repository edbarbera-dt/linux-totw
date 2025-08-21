# Linux ToTW

Clone the repository using `git clone https://github.com/edbarbera-dt/linux-totw.git`

## Prerequisites
- Install `git` if not already installed.
- Terminal of some sort:
  - On MacOS you can use the built-in Terminal app
  - On Windows use the WSL terminal

## Learning Outcomes
### Technical Skills:
- Navigate Unix file systems confidently
- Extract and filter log data using `grep`, `awk`, `sed`
- Manage file permissions and run scripts
- Chain commands for efficient data processing

### Dynatrace Value
- **Customer Credibility**: Handle technical discussions and troubleshooting with confidence
- **Troubleshooting**: Analyse customer logs and guide them through system issues
- **Professional Growth**: Communicate effectively with DevOps and SRE teams

## Stage 1
1. Navigate to `stage-1` directory.
2. List the contents of the current directory.
3. Create a new folder and move `move-me.txt` into it.
4. Create a new file called `new-file.txt` and write "Hello, world!" to it by using `nano`, `vim`, or `vi`.
5. Append contents of the file you just created to `output.txt` without using a text editor. Verify the contents of `output.txt`.
6. Remove `remove-me` folder. (This command is very powerful, but always use with caution!)
7. Change the permissions of `script.sh` to make it executable and run it.
8. Use a pipe to send the output of a command that lists the contents of `count-me` to the `wc -l` command to count the number of items in the folder - **this is your final answer!**

**BONUS: Repeat step 8 using `find`, but this time include files in subdirectories.**

**BONUS BONUS: Use `find` complete step 8 (hint: there's a handy flag to do just this!)**


## Stage 2
1. Navigate to `stage-2` directory.
2. Find all lines containing `ERROR` or `WARN` messages in `logs.csv`
3. Extract only the `Timestamp` and `Hostname` columns using `awk` for the log lines from step 2.
4. Use `sed` to replace all occurrences of "serviceB" with "WebApp" in `logs.csv`
5. Fetch the following paper from `https://api.isevenapi.xyz/api/iseven/69/` and write the output directly to a file.
6. Create an `alias` for a commonly used command; `cd ..`. Persist this by adding it to your shell configuration file (e.g., `~/.bashrc` or `~/.zshrc`).
7. Run `script.sh` and determine the size of the file created in MB - **this is your final answer!**

**BONUS: Are there any other commands you can create aliases for to help speed up your workflow?**
