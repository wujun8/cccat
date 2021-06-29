title="$(date +"%F %H:%M:%S") CCCAT checkin"
echo $title
today=$(date +"%F")

if [[ "$today" != $(< run_today) ]] ; then
    node checkin.js
    EXCODE=$?
    if [ "0" != "$EXCODE" ] ; then
        curlr="something is wrong"
        curlr=$(echo -e "CCCAT checkin $curlr" | sed 's/["\{}]//g')
        curl -sS "https://oapi.dingtalk.com/robot/send?access_token=$DDTOKEN" -X "POST" -H "Accept: application/json;charset=utf-8" -H "Content-Type: application/json;charset=utf-8" -d '{"msgtype": "text","text": {"content": "'"$curlr"'"}}' --compressed
    fi
    #curl -s -G "https://sc.ftqq.com/$SCKEY.send" --data-urlencode "text=$curlr" --data-urlencode "desp=$curlr"
    echo $today > run_today
else
    echo already run today @$today
    exit
fi
node checkin.js
