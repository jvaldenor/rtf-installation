while IFS=, read -r ip port; do
  port=$(echo $port | sed -e 's/\r//g')

  ##replace with nmap if needed
  nc -z -w1 $ip $port
  result1=$?

  if [ -z ${2+x} ]; then
    if [ "$result1" != 0 ]; then
      echo "port $port is closed"
    else
      echo "port $port is open"
    fi
  else
    if [ "$result1" != 0 ]; then
      status="closed"
    else
      status="open"
    fi
    echo "$ip,$port,$status" >> $2
  fi
done < $1
