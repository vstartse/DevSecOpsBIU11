TEST_PERIODICITY=5

function test_host {
  local TESTED_HOST=$1


  RESULT=0
  if ping -c 1 "$TESTED_HOST"
  then
    RESULT=1
  fi
  TEST_TIMESTAMP="$(date +%s%N)"

  echo "Test result for $TESTED_HOST is $PING_LATENCY at $TEST_TIMESTAMP"
  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
}

while true
do
  while read TESTED_HOST; do
    test_host "$TESTED_HOST"
  done < hosts

  sleep "$TEST_PERIODICITY"
done
