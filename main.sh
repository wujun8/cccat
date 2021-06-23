title="$(date +"%F %H:%M:%S") CCCAT checkin"
echo $title
today=$(date +"%F")

if [[ "$today" != $(< run_today) ]] ; then
    curlr=$(curl -sS "https://cccat.io/user/_checkin.php$CFQUERY" -H "authority: cccat.io" -H "accept: application/json, text/javascript, */*; q=0.01" -H "dnt: 1" -H "x-requested-with: XMLHttpRequest" -H "user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36" -H "sec-fetch-site: same-origin" -H "sec-fetch-mode: cors" -H "sec-fetch-dest: empty" -H "referer: https://cccat.io/user/index.php" -H "accept-language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7" -H "cookie: $CK" --compressed)
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

