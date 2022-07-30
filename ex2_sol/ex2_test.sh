# To run this test locally, you have to run it within the InfluxDB Docker container,
# while mounting your code solution into /sol directory in the container
# docker run --rm --name influxdb -v /path/to/your/repo/DevSecOpsBIU11/ex2_sol:/sol -p 8086:8086 influxdb:1.8.10 bash /sol/ex2_test.sh

set -e

# start influxdb
influxd &

sleep 3
# create a db
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE hosts_metrics"

if [ -d "/sol" ]; then
  cd /sol
fi

chmod +x ./availabilityAgent.sh
./availabilityAgent.sh &

# wait for the availability tests to be performed at least 3 times
sleep 60

# get the tests data from influx
DATA=$(curl -G 'http://localhost:8086/query?pretty=true' --data-urlencode "db=hosts_metrics" -H "Accept: application/csv" --data-urlencode "q=SELECT * FROM \"availability_test\"")

echo "Your test data as found in InfluxDB:"
echo
echo "$DATA"
echo

if ! echo "$DATA" | grep -q 'name,tags,time,host,value'; then
  >&2 printf "Bad db columns. Expected 'name,tags,time,host,value'"
  exit 1
fi


if ! echo "$DATA" | grep -q "availability_test"; then
  echo "Bad measurement name. Expected 'availability_test'"
  exit 1
fi

for i in "127.0.0.1,1" "_gateway,0" "google.com,0" "10.0.0.34,0"
do
  RES_LINES=$(echo "$DATA" | grep $i | wc -l)
  IFS=',' read -ra SINGLE_TEST_DATA <<< "$i"
  if ((RES_LINES < 3)); then
    echo "Bad test results for ${SINGLE_TEST_DATA[0]}. Expected at least 3 availability test with result  ${SINGLE_TEST_DATA[1]}."
    exit 1
  fi
done

echo "WELL DONE!!! you've passed all tests!"