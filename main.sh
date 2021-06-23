title="$(date +"%F %H:%M:%S") CCCAT checkin"
echo $title
today=$(date +"%F")

if [[ "$today" != $(< run_today) ]] ; then
    curlr=$(python checkin.py)
    echo $curlr
    if [ -z "$curlr" ] ; then
        curlr="something is wrong"
        echo $curlr
    fi
    curlr=$(echo -e "CCCAT checkin $curlr" | sed 's/["\{}]//g')
    #curl -s -G "https://sc.ftqq.com/$SCKEY.send" --data-urlencode "text=$curlr" --data-urlencode "desp=$curlr"
    curl -sS "https://oapi.dingtalk.com/robot/send?access_token=$DDTOKEN" -X "POST" -H "Accept: application/json;charset=utf-8" -H "Content-Type: application/json;charset=utf-8" -d '{"msgtype": "text","text": {"content": "'"$curlr"'"}}' --compressed
    echo $today > run_today
else
    echo already run today @$today
    exit
fi

