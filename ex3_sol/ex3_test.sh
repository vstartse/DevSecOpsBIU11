set -e

# start influxdb
redis-server &

sleep 3

if [ -d "/sol" ]; then
  cd /sol
fi

chmod +x ./seat.sh

TEXT=$(./seat.sh lock "Oedipus_the_King" "Andreas" 56)

if echo "$TEXT" | grep -q "Seat was locked"; then
  echo "Expected 'Seat was locked' but found \'$TEXT\'"
  exit 1
fi

TEXT=$(./seat.sh lock "Oedipus_the_King" "Marios" 56)

if echo "$TEXT" | grep -q "This seat is currently locked by other customer, try again later"; then
  echo "Expected 'This seat is currently locked by other customer, try again later' but found \'$TEXT\'"
  exit 1
fi

TEXT=$(./seat.sh release "Oedipus_the_King" "Andreas" 56)

if echo "$TEXT" | grep -q "Seat was released"; then
  echo "Expected 'Seat was released' but found \'$TEXT\'"
  exit 1
fi

TEXT=$(./seat.sh book "Oedipus_the_King" "Marios" 56)

if echo "$TEXT" | grep -q "Booking failed, lock your seat before"; then
  echo "Expected 'Booking failed, lock your seat before' but found \'$TEXT\'"
  exit 1
fi

TEXT=$(./seat.sh lock "Oedipus_the_King" "Marios" 56)

if echo "$TEXT" | grep -q "Seat was locked"; then
  echo "Expected 'Seat was locked' but found \'$TEXT\'"
  exit 1
fi

TEXT=$(./seat.sh book "Oedipus_the_King" "Marios" 56)

if echo "$TEXT" | grep -q "Successfully booked this seat!"; then
  echo "Expected 'Successfully booked this seat!' but found \'$TEXT\'"
  exit 1
fi

TEXT=$(./seat.sh lock "Oedipus_the_King" "Andreas" 56)

if echo "$TEXT" | grep -q "Locking failed, seat is already booked"; then
  echo "Expected 'Locking failed, seat is already booked' but found \'$TEXT\'"
  exit 1
fi

echo "WELL DONE!!! you've passed all tests!"