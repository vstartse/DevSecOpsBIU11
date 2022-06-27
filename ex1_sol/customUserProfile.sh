# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi

echo "****Hello $USER****"

# User specific environment and startup programs
PATH=$PATH:$HOME/bin

export PATH

echo “##############################################################”
echo ” Welcome to my linux station Mr `whoami` “
echo “##############################################################”

# displays the number of updates
updates=$(/usr/lib/update-notifier/apt-check --human-readable)
if [ ${updates:0:1} != 0 ]; then
   echo -e "$updates"
fi

if [[ -f $FILE && "stat -c "%a" $FILE" -ne 600  ]] ; then
  echo "**Warning: .token file has too open permissions**"
fi
