TEST_PERIODICITY=5

while true
do
  while read TESTED_HOST; do
      RESULT=0
      if ping -c 1 -W 2 "$TESTED_HOST"
      then
        RESULT=1
      fi
      TEST_TIMESTAMP="$(date +%s%N)"

      echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done < hosts

  sleep "$TEST_PERIODICITY"
done
