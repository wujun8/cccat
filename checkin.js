const puppeteer = require('puppeteer')
const request = require('request')
const fs = require('fs')

async function openUserIndex(cookie, gui) {
  const browser = await puppeteer.launch({
      devtools: gui, //是否为每个选项卡自动打开DevTools面板
      defaultViewport: { width: 1000, height: 1200 }, //为每个页面设置一个默认视口大小
      ignoreHTTPSErrors: true //是否在导航期间忽略 HTTPS 错误
  })
  const page = await browser.newPage()
  page.on('response', response => {
    const req = response.request()
    if (!req.url().startsWith('https://cccat.')) {
      return
    }
    const headers = response.headers()
    const contentType = headers['content-type']
    if (403 == response.status() || contentType == null || contentType.includes('javascript') || contentType.includes('css')
     || contentType.includes('font') || contentType.includes('octet-stream') || contentType.includes('image')) {
      return
    }
    console.log(`url：${req.url()}，method：${req.method()}, status: ${response.status()} `)
    console.log('REQUEST HEADERS ', req.headers())
    console.log('RESPONSE HEADERS ', headers)
    if (200 != response.status() && 204 != response.status()) {
      let message = response.text()
      message.then(function (result) {
          console.log(`body：${result}`)
      })
      page.close()
      browser.close()
      openUserIndex(cookie, true)
    }
  })
  await page.setExtraHTTPHeaders({
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7",
    "cache-control": "max-age=0",
    "sec-ch-ua": "\" Not;A Brand\";v=\"99\", \"Google Chrome\";v=\"91\", \"Chromium\";v=\"91\"",
    "sec-ch-ua-mobile": "?0",
    "sec-fetch-dest": "document",
    "sec-fetch-mode": "navigate",
    "sec-fetch-site": "same-origin",
    "upgrade-insecure-requests": "1",
    "cookie": cookie
  })
  await page.goto('https://cccat.io/user/index.php', {
    timeout: 0,
    waitUntil: 'networkidle0'
  })
  
  const setCookie = page.cookies().then(async (cks) => {
    let ckExt = ''
    cks.forEach(element => {
      ckExt += element['name'] + '=' + element['value'] + ';'
    });
    cookie = ckExt + cookie
    console.log('new cookie ' + cookie)
    await page.setExtraHTTPHeaders({
      "cookie": cookie,
      "accept": "application/json, text/javascript, */*; q=0.01",
      "sec-fetch-dest": "empty",
      "sec-fetch-mode": "cors",
      "sec-fetch-site": "same-origin",
      "x-requested-with": "XMLHttpRequest"
    })
    page.on('dialog', async (dialog) => {
      console.log(dialog.message())
      const msg = dialog.message()
      const exec = require('child_process').exec
      exec(`NOTIFY_MESSAGE=${msg} ./ddtalk.sh`)
      await dialog.dismiss()
    })
    await page.click('#checkin1').then(async () => {
      await page.waitFor(3000)
    }).catch(async (error) => {
      console.log('Already checked in')
      await page.close()
      await browser.close()
    })
  })
  await setCookie
  if (page.isClosed()) {
    return
  }
  await page.waitFor(15000)
  await page.close()
  await browser.close()
}

openUserIndex(process.env.CK, false)
