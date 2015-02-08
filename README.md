# 歐付寶金流串接示範

- 有完整測試。
- 使用 [`allpay_client`](https://github.com/tonytonyjan/allpay) 串接歐付寶。
- 使用 `adminscaffold` 產生後台。

## 啟動

```
git clone
cd brainana_shop
bundle
cp config/application.yml.example config/application.yml
bin/rake db:fixtures:load
rails server
```