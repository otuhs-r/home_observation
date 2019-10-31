function doPost(e) {
  console.log("execute!");
  var sheet = SpreadsheetApp.openById(spreadsheetId).getSheetByName('log');
  var row_num = sheet.getDataRange().getValues().length;
  var il_5_minutes_ago = sheet.getRange(row_num - 5, 4).getValue();
  
  // 5 分前の部屋の照度が低いなら帰宅時
  if (il_5_minutes_ago < 50) {
    var ifttt_url = PropertiesService.getScriptProperties().getProperty('IFTTT_URL');
    var params = {
      "method": "post",
    };
    UrlFetchApp.fetch(ifttt_url, params);
  }
}
