const cloudflareScraper = require('cloudflare-scraper');

let data = {
headers: {
  'cookie': process.env.CK,
  'authority': 'cccat.io',
  'accept': 'application/json, text/javascript, */*; q=0.01',
  'dnt': '1',
  'x-requested-with': 'XMLHttpRequest',
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36',
  'sec-fetch-site': 'same-origin',
  'sec-fetch-mode': 'cors',
  'sec-fetch-dest': 'empty',
  'referer': 'https://cccat.io/user/index.php',
  'accept-language': 'zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7'
}
};
(async () => {
  try {
    const response = await cloudflareScraper.post("https://cccat.io/user/_checkin.php", data);
    console.log(response);
  } catch (error) {
    console.log(error);
  }
})();
