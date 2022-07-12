set -e

# start influxdb
redis-server --port 6378 &

sleep 3

if [ -d "/sol" ]; then
  cd /sol
fi

echo
echo
echo '''
Running the following scenario:

./seat.sh lock "Oedipus_the_King" "Andreas" 56
./seat.sh lock "Oedipus_the_King" "Marios" 56
./seat.sh release "Oedipus_the_King" "Andreas" 56
./seat.sh book "Oedipus_the_King" "Marios" 56
./seat.sh lock "Oedipus_the_King" "Marios" 56
./seat.sh book "Oedipus_the_King" "Marios" 56
./seat.sh lock "Oedipus_the_King" "Andreas" 56

'''

chmod +x ./seat.sh

echo 'Execute: ./seat.sh lock "Oedipus_the_King" "Andreas" 56'
TEXT=$(./seat.sh lock "Oedipus_the_King" "Andreas" 56)

if ! echo "$TEXT" | grep -q "Seat was locked"; then
  echo "Expected 'Seat was locked' but found '$TEXT'"
  exit 1
fi

echo 'Execute: ./seat.sh lock "Oedipus_the_King" "Marios" 56'
TEXT=$(./seat.sh lock "Oedipus_the_King" "Marios" 56)

if ! echo "$TEXT" | grep -q "This seat is currently locked by other customer, try again later"; then
  echo "Expected 'This seat is currently locked by other customer, try again later' but found '$TEXT'"
  exit 1
fi

echo 'Execute: ./seat.sh release "Oedipus_the_King" "Andreas" 56'
TEXT=$(./seat.sh release "Oedipus_the_King" "Andreas" 56)

if ! echo "$TEXT" | grep -q "Seat was released"; then
  echo "Expected 'Seat was released' but found '$TEXT'"
  exit 1
fi

echo 'Execute: ./seat.sh book "Oedipus_the_King" "Marios" 56'
TEXT=$(./seat.sh book "Oedipus_the_King" "Marios" 56)

if ! echo "$TEXT" | grep -q "Booking failed, lock your seat before"; then
  echo "Expected 'Booking failed, lock your seat before' but found '$TEXT'"
  exit 1
fi

echo 'Execute: ./seat.sh lock "Oedipus_the_King" "Marios" 56'
TEXT=$(./seat.sh lock "Oedipus_the_King" "Marios" 56)

if ! echo "$TEXT" | grep -q "Seat was locked"; then
  echo "Expected 'Seat was locked' but found '$TEXT'"
  exit 1
fi

echo 'Execute: ./seat.sh book "Oedipus_the_King" "Marios" 56'
TEXT=$(./seat.sh book "Oedipus_the_King" "Marios" 56)

if ! echo "$TEXT" | grep -q "Successfully booked this seat!"; then
  echo "Expected 'Successfully booked this seat!' but found '$TEXT'"
  exit 1
fi

echo 'Execute: ./seat.sh lock "Oedipus_the_King" "Andreas" 56'
TEXT=$(./seat.sh lock "Oedipus_the_King" "Andreas" 56)

if ! echo "$TEXT" | grep -q "Locking failed, seat is already booked"; then
  echo "Expected 'Locking failed, seat is already booked' but found '$TEXT'"
  exit 1
fi

echo "WELL DONE!!! you've passed all tests!"