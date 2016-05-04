EMAIL=$1
CATCHALL_EMAIL=$(echo $EMAIL | sed -e 's/.*@/thismail60xn0exists@/')
CATCHALL_RETURN=$(/usr/local/mailvalidator/mailvalidator $CATCHALL_EMAIL | awk '{print $2}' &)
RETURN=$(/usr/local/mailvalidator/mailvalidator $EMAIL | awk '{print $2}')
if [ "$CATCHALL_RETURN" -eq 250 ]; then
  echo 5050;
else
  echo $RETURN;
fi
