# Resource lock with Redis

In this exercise, you will implement a bash program which reserves seats for a digital ticketing solution, using Redis database. 
In simple words: whenever a customer wants to book a seat for an event (e.g. for a theatre show), your bash program will lock the selected seats for a period of time, such that other customers won't be able to book for those seats.


## Preliminaries

1. Open (or clone if you didn't do it yet: Git -> clone...) [our shared git repo](https://github.com/alonitac/DevSecOpsBIU11.git) in PyCharm, checkout branch `main` and pull the repository ![Pull Button](img/pull.png) to get an up-to-date version of branch main.
   From Pycharm button right bar, create your own git branch `bash_ex3/<alias>`, while
   `<alias>` is your name. e.g. `bash_ex3/alonit`. The branch name must start with `bash_ex3/`. Make sure your new branch is created from branch `main`.

2. [Install Docker on your Ubuntu](https://docs.docker.com/engine/install/ubuntu/) if needed.

## Guidelines

In order to book a seat, first this seat must be locked by a customer. The lock is valid for 600 seconds. Then the customer that locked the seat can book it during the given locking time. Once seat was booked, the lock is being released and this seat cannot be locked anymore. 

1. Run Redis in a Docker container by:
   ```shell
   docker run --rm -p 6378:6379 --name some-redis redis
   ```  
   Your Redis server will be accessible in localhost:6378
2. You are given a solution skeleton in `ex3_sol/seats.sh`. Your goal is to implement the functions `lock`, `release` and `book`. Read the documentation attached at the top of each function.
3. Here is an example of how your program should behave:
   ```
   >> ./seat.sh lock "Oedipus_the_King" "Andreas" 56
   Seat was locked
   
   >> ./seat.sh lock "Oedipus_the_King" "Marios" 56
   This seat is currently locked by other customer, try again later
   
   >> ./seat.sh release "Oedipus_the_King" "Andreas" 56
   Seat was released
   
   >> ./seat.sh book "Oedipus_the_King" "Marios" 56
   Booking failed, please lock the seat before
   
   >> ./seat.sh lock "Oedipus_the_King" "Marios" 56
   Seat was locked
   
   >> ./seat.sh book "Oedipus_the_King" "Marios" 56
   Successfully booked this seat!
   
   >> ./seat.sh lock "Oedipus_the_King" "Andreas" 56
   Locking failed, seat is already booked
   ```

## Submission

_Commit_ and _push_ `ex3_sol/seat.sh` file **only**. Make sure your solution passing the pre-submit tests.


## Good luck
Feel free to ask any questions!

