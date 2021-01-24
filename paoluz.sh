
title="$(date +"%F %H:%M:%S") paoluz checkin"
echo $title

curlr=$(curl -sS "https://paoluz.link/user/checkin" -X "POST" -H "authority: paoluz.link" -H "content-length: 0" -H "accept: application/json, text/javascript, */*; q=0.01" -H "dnt: 1" -H "x-requested-with: XMLHttpRequest" -H "user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36" -H "origin: https://paoluz.link" -H "sec-fetch-site: same-origin" -H "sec-fetch-mode: cors" -H "sec-fetch-dest: empty" -H "referer: ttps://paoluz.link/user?__cf_chl_jschl_tk__=22bdfa25c51c6f806d2529ee82658b7af6911e6e-1611457600-0-ARqjkEkmKX9qg1Ee0xGJHxSOPsMwi8dxo1dPmFL0C_kP_E43QJ_Fvh-J8njgcswknbtLBvXD5zmkGzqgtT-S5MTyp7j-uZO1QHlM8OGuUICOUbZy3V5zJ_x6wsS4uWGV-ygPmOuujGYyDLa8xH3SzcGm8bLBahEGUmVXTAVNVrIaTqtZDyAev-z9PCZKSwuKfFYK1XVPA5ZVNukGL45qXf-SAzVwmhKVKrv_MrvQABqD6FZK0HzGhvEKNkAPsoNTy4hkN8wEOI8qOSyeBLEob6UPZesEBBxTIPuy3_G6QgR6UYkZpFFbtY1zf55jmYMSQF3QvVp_BuUisApVzaJk4rE_JCSeW8ZGUy6FY26bj9lpBQYmIaW9Paawh3uRA-_ojQ" -H "accept-language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7" -H "cookie: $CKPAOLUZ" --compressed)
curlr=$(echo -e $curlr)
echo $curlr
if [ -z "$curlr" ] ; then
    curlr="something is wrong"
    echo $curlr
fi
curlr="paoluz checkin $curlr"
curl -s -G "https://sc.ftqq.com/$SCKEY.send" --data-urlencode "text=$curlr" --data-urlencode "desp=$curlr"
