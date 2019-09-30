require 'selenium-webdriver'
require 'date'
require 'dotenv/load'
require 'google_drive'

logger = Logger.new(STDOUT)

driver = Selenium::WebDriver.for :remote, desired_capabilities: :chrome

def driver.find_and_wait_element(how, what)
  Selenium::WebDriver::Wait.new(timeout: 10).until{ find_element(how, what) }
  sleep 2
  find_element(how, what)
end

###

# ログイン
driver.navigate.to(ENV['URL'])
driver.find_and_wait_element(:id, 'login')
driver.find_element(:id, 'loginId').send_keys(ENV['LOGINID'])
driver.find_element(:id, 'passWord').send_keys(ENV['PASSWORD'])
driver.find_element(:xpath, '//*[@id="login"]/a').click

# `電力使用量・ご請求` へ
to_amount_claim = driver.find_and_wait_element(:xpath, '//*[@id="auto"]/section/div/div[2]/nav/ul/li[2]/p/a')
to_amount_claim.click

# `電力使用量を見る` へ
to_amount_confirmation = driver.find_and_wait_element(:id, 'submitReferenceCrrspndDetailsPrtl')
to_amount_confirmation.click

# 日付を指定
target_date = Date.today - 1
date_field = driver.find_and_wait_element(:id, 'EntryInputForm_entryModel_svcStrtDt')
date_field.clear
date_field.send_keys(target_date.strftime("%Y/%m/%d"))

# 表示形式を指定
time_indication_type = Selenium::WebDriver::Support::Select.new(driver.find_and_wait_element(:id, 'timeIndicationType'))
time_indication_type.select_by(:value, '1') # 24 時間表示

# 使用量データを抽出
data = driver.page_source.scan(/source\.data\.push\(\"(\d\.\d{2})\"\)/).flatten.map(&:to_f)

# Google SpreadSheet へ `data` を出力
session = GoogleDrive::Session.from_config('config.json')
ws = session.spreadsheet_by_key(ENV['SPREADSHEET_KEY']).worksheets[0]
48.times do |n|
  datetime = DateTime.parse(target_date.to_s) + Rational(0.5 * n, 24)
  new_row = ws.num_rows + 1
  ws[new_row, 1] = datetime.strftime("%Y/%m/%d %H:%M:%S")
  ws[new_row, 2] = data[n]
end
ws.save
