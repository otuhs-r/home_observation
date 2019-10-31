[![Actions Status](https://github.com/otuhs-r/home_observation/workflows/scraping%20electric%20power%20consumption/badge.svg)](https://github.com/otuhs-r/home_observation/actions)

# おうち監視

## センサー情報のロギング

- [Nature Remo API](https://developer.nature.global/) を使用して 1 分おきに部屋の気温・湿度・照度を Google スプレッドシートに記録

## 帰宅時に照明 ON

- [Sesame Webhooks](https://docs.candyhouse.co/#sesame-webhook) で鍵の状態が変化したら GAS へリクエスト送信
- 5 分前の部屋の照度が低ければ、帰宅時と判断して照明を ON に
  - 記録しているセンサー情報を参照

## 使用電力のスクレイピング

- 日電の電気使用量ページからデータを取得して Google スプレッドシートに記録
- GitHub Actions で毎日定期実行
