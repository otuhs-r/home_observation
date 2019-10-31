var spreadsheetId = PropertiesService.getScriptProperties().getProperty('SHEET_ID');

function remo() {
  var data = getDevicesData();
  writeNewestEvents(
    {
      te: data[0].newest_events.te.val,	// 気温
      hu: data[0].newest_events.hu.val,	// 湿度
      il: data[0].newest_events.il.val,	// 照度
    },
    SpreadsheetApp.openById(spreadsheetId).getSheetByName('log').getDataRange().getValues().length + 1
  );
}

function getDevicesData() {
  var remo_url = "https://api.nature.global/1/devices";
  var remo_access_token = PropertiesService.getScriptProperties().getProperty('REMO_ACCESS_TOKEN');
  var headers = {
    "Content-Type" : "application/json;",
    'Authorization': 'Bearer ' + remo_access_token
  };
  var params = {
    "method": "get",
    "headers": headers
  };
  
  return JSON.parse(UrlFetchApp.fetch(remo_url, params));
}

function writeNewestEvents(events, row) {
  var sheet = SpreadsheetApp.openById(spreadsheetId).getSheetByName('log');
  sheet.getRange(row, 1).setValue(new Date());
  sheet.getRange(row, 2).setValue(events.te);
  sheet.getRange(row, 3).setValue(events.hu);
  sheet.getRange(row, 4).setValue(events.il);
}
