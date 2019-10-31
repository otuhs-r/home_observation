[![Actions Status](https://github.com/otuhs-r/home_observation/workflows/scraping%20electric%20power%20consumption/badge.svg)](https://github.com/otuhs-r/home_observation/actions)

# おうち監視

## センサー情報のロギング

- [Nature Remo API](https://developer.nature.global/) を使用して 1 分おきに部屋の気温・湿度・照度を Google スプレッドシートに記録
  - [リビングの環境監視ダッシュボードを６０分で作る方法（Nature Remo Cloud APIとGoogleサービス連携）](https://qiita.com/t-chi/items/01b9a9b98fbccef880c3) を参考にしています

## 帰宅時に照明 ON

- [Sesame Webhooks](https://docs.candyhouse.co/#sesame-webhook) で鍵の状態が変化したら GAS へリクエスト送信
- 5 分前の部屋の照度が低ければ、帰宅時と判断して照明を ON に
  - 記録しているセンサー情報を参照
  - 詳細は [こちらの記事](https://qiita.com/otuhs_d/items/039a77d4edbc542348ee) に書きました

## 使用電力のスクレイピング

- 日電の電気使用量ページからデータを取得して Google スプレッドシートに記録
- GitHub Actions で毎日定期実行
  - 詳細は [こちらの記事](https://qiita.com/otuhs_d/items/0953e237119178fd796e) に書きました
