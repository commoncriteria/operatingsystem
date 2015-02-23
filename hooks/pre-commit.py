import sys
import os
import os.path

MAX_COLL = 110
CHECK_DIR = "input"

errors = []

current_directory = os.getcwd()

# navigate to top level git directory
while True:
    try:
        os.stat(".git")
        break
    except (IOError, OSError):
        os.chdir("..")

# check column length for all files in CHECK_DIR except hidden files
try:
    os.chdir(os.path.join(os.getcwd(), CHECK_DIR))
    for filename in os.listdir(os.getcwd()):
        if filename.startswith("."):
            continue
        with open(filename, 'r') as f:
            line_number = 1
            for line in f:
                if len(line) > MAX_COLL:
                    errors.append((os.path.join(os.getcwd(), filename), line_number))
                line_number += 1
except (IOError, OSError):
    os.chdir(current_directory)
    print("ERROR: Couldn't find the {} directory for checking.")
    print("Please report this -- use 'git commit --no-verify' to commit changes anyway")
    sys.exit(1)

os.chdir(current_directory)

for error in errors:
    print("{}:{} too long".format(error[0], str(error[1])))
print("ERROR: Failed to commit")

if errors:
    sys.exit(1)
sys.exit(0)