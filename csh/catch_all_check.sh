EMAIL=$1
RETURN=$(/usr/local/mailvalidator/mailvalidator -catchall $EMAIL | awk '{print $2}')
echo $RETURN;
