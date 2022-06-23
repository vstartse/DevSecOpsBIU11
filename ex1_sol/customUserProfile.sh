echo Hello $USER

/usr/lib/update-notifier/apt-check --human-readable

if [[ -f "~/.token" && 'stat -c %a' != 600 ]] ; then
    echo 'Warning: .token file has too open permissions'
fi