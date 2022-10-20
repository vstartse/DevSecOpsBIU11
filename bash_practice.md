# Bash Practice

## User greeting

Write a program which gets username from the user and prints a greeting message. 

Running example:
```shell
$ bash my-program.sh John
>> Hello John
```

<details>
  <summary>Solution</summary>

  ```shell
  #!/bin/bash
  echo "Hello $1"
  ```

</details>

## User input validation

Write a program which gets username from the user, if the username is not empty, the program prints a greeting message, otherwise it prints "Bad username". 

Running example:
```shell
$ bash my-program.sh John
>> Hello John

$ bash my-program.sh
>> Bad username
```

<details>
  <summary>Solution</summary>

  ```shell
  #!/bin/bash
  if [[ -z "$1" ]]; then
    echo "Bad username"
  else
    echo Hello $1
  fi
  ```
</details>


## Multiple User greeting

Write a program which gets list of usernames, the program prints a greeting message for each username

Running example:
```shell
$ bash my-program.sh John Dan Kevin
>> Hello John
>> Hello Dan
>> Hello Kevin
```

<details>
  <summary>Solution</summary>

  ```shell
  #!/bin/bash
  for USERNAME in $@
  do
    echo "Hello $USERNAME"
  done
  ```
</details>

## File exists

Write a program that checks if file exists in a given directory

Running example:
```shell
$ bash my-program.sh some_file some_dir 
>> some_file exists in some_dir

$ bash my-program.sh some_other_file some_dir 
>> some_other_file does not exist in some_dir
```

<details>
  <summary>Solution</summary>

  ```shell
  #!/bin/bash
  if [[ -x "$2/$1" ]]; then
    echo "$1 exists in $2"
  else
    echo "$1 does not exist in $2"
  fi

  ```
</details>

## File or directory?

Write a program that checks if a given input is a file, directory or something else.

Running example:
```shell
$ bash my-program.sh /etc/group 
>> /etc/group is a file!

$ bash my-program.sh /etc/systemd 
>> /etc/systemd is a directory!

$ bash my-program.sh /etc/resolv.conf 
>> /etc/resolv.conf is something else!
```

<details>
  <summary>Solution</summary>

  ```shell
  #!/bin/bash
  if [[ -f "$1" ]]; then
    echo "$1 is a file!"
  elif [[ -d "$1" ]]; then
    echo "$1 is a directory!"
  else
    echo "$1 is something else!"
  fi
  ```
</details>

## CPU Temperature

In Linux systems, the CPU temperature can be found in the file `/sys/class/thermal/thermal_zone0/temp`. 
Write a program that run forever (`while true`...) and print the CPU temperature every 1 second.

**Bonus 1:** try to divide the value in 1000 to get the temperature in Celsius.

**Bonus 2:** try to override the previous printed value, so the user won't see a new line every second, but feel it as a real time temperature clock. [hint](https://stackoverflow.com/questions/39229946/bash-overwrite-previous-echo-command).

Running example:
```shell
$ bash my-program.sh 
>> 41000
>> 41000
>> 41000
>> 41000
>> ...
>> ...

```

<details>
  <summary>Solution</summary>

  ```shell
  #!/bin/bash
  while true
  do
    cat /sys/class/thermal/thermal_zone0/temp
    sleep 1
  done
  ```
</details>

<details>
  <summary>Bonus 1 solution</summary>

  ```shell
  #!/bin/bash
  while true
  do
    TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
    echo $((TEMP/1000))    
    sleep 1
  done
  ```
</details>


<details>
  <summary>Bonus 2 solution</summary>

  ```shell
  #!/bin/bash
  while true
  do
   TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
   C_TEMP=$((TEMP/1000))
   printf "%d\r" "$C_TEMP"        
   sleep 1  
  done
  ```
</details>

