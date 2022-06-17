# Default profile for new Linux Users


In this exercise, you will need to read the **useradd** man pages, because we are going to use the /etc/skel
directory to hold default shell configuration files, which are copied to the home directory of each newly added
user.

## Background 

The `/etc/skel` directory provide a way to assure new users are added to your Linux system has default 
Bash configurations.
When adding a new user with **useradd**, use the `-m` parameter, which tells `useradd` to create the user's home directory and copy files from `/etc/skel` to the new user's home directory.