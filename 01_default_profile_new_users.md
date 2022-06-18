# Default profile for new Linux Users

In this exercise, you will implement a bash script which applies default Bash profile configurations for new added Linux users.

## Perliminaries 

Open (or clone if you didn't do it yet: Git -> clone...) [our shared git repo](https://github.com/alonitac/DevOpsMay22.git) in PyCharm and pull the repository ![Pull Button](img/pull.png) to get an up-to-date version of the repository. 
From Pycharm button right bar, create your own git branch (Git branches will be discussed later):

![New Branch](img/branch.png)

Then change `<alias>` to your nickname. e.g. `bash_ex1/alonit`. The branch name must start with `bash_ex1/`

![Branch Name](img/branch2.png)

Great. Let's get started... 


## Background 

In many Linux systems, the `/etc/skel` directory provides a way to assure new users are added to your Linux system has default 
Bash profile configurations.
When adding a new user with **adduser**, it will create the user's home directory and copy files from `/etc/skel` to the new user's home directory.

## Guidelines

**Note:** should be done in Ubuntu systems.

1. In `/etc/skel` edit `.bash_profile` file using your favorite text editor (`nano`, `vi` etc...) as detailed below. If this file already exists, append your code at the end (it's highly recommended to making a backup copy before). 
   1. Greet the user. e.g. if the user is **john**, the message `Hello john` will be printed to stdout (standard output). 
   2. Print how many packages are outdated (`/usr/lib/update-notifier/apt-check --human-readable`).
   3. Given a file called `.token` in the home directory of the user, check the file permissions. If the octal representation of the permissions set is different from 600 (read and write by the user **only**), print a warning message to the user:  
      **Warning: .token file has too open permissions**   
      Use `stat -c "%a"` to get permissions set of the file in an octal form. Use _if_ statements to test if the file exists, and that the permissions are not equal to "600". 
2. Create a new Linux user using `adduser` command. If everything done well, the new user should have the custom script profile you created. 
3. Login to the new user terminal session: `su -l <username>`. Replace `<username>` to the created user.
   The output should be similar to:
   ![userlogin](img/userlogin.png)

## Submission 

When you're done with above section, copy your solution, which mean the code changes you've done in `/etc/skel/.bash_profile` into `ex1_sol/customUserProfile.sh` in our shared repository.   
For example, if your `/etc/skel/.bash_profile` file looks like:

```shell
# ....code written here before...

# your changes:
echo bla bla bla
....
echo bla bla bla

```

you should copy the following code into `ex1_sol/customUserProfile.sh`:
```shell
# your changes:
echo bla bla bla
....
echo bla bla bla
```

Finally, _commit_ ![commit](img/commit.png)  **only** `ex1_sol/customUserProfile.sh` file as your solution. After clicking on commit button, write a commit message and make sure only your single solution file is committed, as follows:  
![commitmsg](img/commitmsg.png)  

Then _push_ ![push](img/push.png) your solution to GitHub. Go to [action](https://github.com/alonitac/DevSecOpsBIU11/actions) and make sure your solution is passing the tests. You must see the following message:  
```text
WELL DONE!!! you've passed all tests!
```
Otherwise, your solution has to be fixed 

## Well done!
