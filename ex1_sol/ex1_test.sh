set -e

# run student solution script
chmod +x ./customUserProfile.sh
./customUserProfile.sh

OUTPUT_FILE=terminal_output
function print_terminal_output {
  printf "\nYour terminal output: \n------------------------------------\n$(cat $OUTPUT_FILE)\n------------------------------------\n\n"
}

# create myuser
rm -f -r /home/myuser
userdel myuser
adduser myuser --gecos "" --disabled-password
echo "myuser:1234" | chpasswd


printf "Case 1: No .token file in user's home dir\n\n"

echo '1234' | sudo -S sleep 1 && su -l myuser -c "touch .token" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "Hello myuser" "$OUTPUT_FILE"; then
  >&2 printf "Bad greeting. Expected 'Hello myuser' to be found"
  exit 1
fi

if ! grep -q "updates can be applied immediately" "$OUTPUT_FILE"; then
  >&2 printf "Expected to get an outdated packages message"
  exit 1
fi

if grep -q ".token" "$OUTPUT_FILE"; then
  >&2 printf "There should not be any message regarding .token file since it doesn't exist yet"
  exit 1
fi

printf "Case 2: .token file with bad permissions\n\n"
echo '1234' | sudo -S sleep 1 && su -l myuser -c "chmod 600 .token" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "Warning: .token file has too open permissions" "$OUTPUT_FILE"; then
  >&2 printf "Expected a message regarding .token permissions: 'Warning: .token file has too open permissions'"
  exit 1
fi

printf "Case 3: .token file with right permissions\n\n"
echo '1234' | sudo -S sleep 1 && su -l myuser -c "chmod 600 .token" > $OUTPUT_FILE
print_terminal_output

if grep -q ".token" "$OUTPUT_FILE"; then
  >&2 printf "There should not be any message regarding .token file since it has good permissions set"
  exit 1
fi

echo "WELL DONE!!! you've passed all tests!"