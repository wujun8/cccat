
title="$(date +"%F %H:%M:%S") paoluz checkin"
echo $title

curlr=$(curl -sS "https://paoluz.link/user/checkin" -X "POST" -H "authority: paoluz.link" -H "content-length: 0" -H "accept: application/json, text/javascript, */*; q=0.01" -H "dnt: 1" -H "x-requested-with: XMLHttpRequest" -H "user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36" -H "origin: https://paoluz.link" -H "sec-fetch-site: same-origin" -H "sec-fetch-mode: cors" -H "sec-fetch-dest: empty" -H "referer: https://paoluz.link/user" -H "accept-language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7" -H "cookie: $CKPAOLUZ" --compressed)
echo $curlr
if [ -z "$curlr" ] ; then
    curlr="something is wrong"
    echo $curlr
fi
curlr="paoluz checkin $curlr"
curl -s -G "https://sc.ftqq.com/$SCKEY.send" --data-urlencode "text=$curlr" --data-urlencode "desp=$curlr"
