import 'dart:math';

import 'package:gsheets/gsheets.dart';

class gSheetApi {
//numberofTodo
  static int numberofTransection = 0;

  static double income = 0;
  static double expense = 0;
  static double balance = 0;

//list of current-Todo
  static List<List<dynamic>> currentTransections = [];

// last accessed time!
  static var lastAc = '';

//gsheet creds
  static const _credentials = r'''{
  "type": "service_account",
  "project_id": "gsheets-378105",
  "private_key_id": "7ae6d927c720d0b6279ec368f9afec0a83f4937d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCJMEWgz91aQoa3\npRD+CVg5JNdtiFqtj4LSO2bCsK1Lg5l7L9Ll9uPzMgOsThLVkItazWzo+bhQMgkc\n1vDXHe5GdkwOvI/+tx2UHiLzJrbHr78fFkQuNDt6KmdTSt0yuBznqX2usKveoTpb\n2r5JE4qhe92B22ke1qaXbNgXN2Ev5zY/Hgvd6UDw9wtoccMVLX4Z9JoaJrvB2qVS\nQ89CmbuH66ZE6RcHCVeRm5bo4jhhA+NRN9F14raDMwoJ8u80M2SKnADrMMpBV31r\nIpa/uSnihl9vKoAXaCDq7zauNtqR60vdtk6jG6N58PU4kWrBe24OkaxuH9YX/6w2\nsJzQ9igPAgMBAAECggEAI1FyG3xoGByYYh70yPHO7Kc3btNzxMr1evof8m9Zrd8r\nXDNrsBhnhuyRVYKkBqc3uSC5sSDY+oxnHC2Zw0fJWAqMeh7BU2oBC2jWxpJo6++q\n3G33D44S4diY0TCs0ankhx9zY83H8YDAbXVbF6UYQ4qH9C5wWagZK1KyLwfq1VHo\nfxWPonvEO/0MSmbKebw/TVHcKV9MKcXZPXgwwTIY+CfqLEZgCp2KrOiQ8H/H4kyL\nTH/bzM3kyzRxYjeaNThEY9mzfAdVZFFHgNMKz1xl7yCCMsJuIGiOtv3sMYtZoUeB\n0AbLShCGS+SSYbxQp6C84j3m4SQZlR032XlpKfyawQKBgQC7bTfk0Z6uUaEUmQpg\nIdk/kPM3GzobXRRg6t4FfJYIOB4SDGLP/7DYl7bM8IXxRihh+qizce/CCGMgarJB\nkLhC6ppJ6Mi3SneIawDIJQfsgeqH08FIa+2UryIqzUktU0nvWpwZwvTseweC/M0Q\nNXjLe37wtPYLDcpNpr8rYHZlrQKBgQC7YaXWkcM/mV5V3NSuFF10KdKCgblwjUlR\nGVNdWycco6qVvDfrPzggn4jP5t7CpI/MN2/LpV1ijxCKehgRlhdULg46QrKVJ5H4\nXguJ3TkcL5fRALJmHfbb3mLJXjRGPYVGTkp3n8JyGotHKuoRaeFOpw8yNYmGMkiY\nHk7egznkKwKBgE2DffpENzwgxl2ebYwUc6S2bd/8gquOcz8h43ChdeswSj9sn/El\n7h2loRRg5QRD36+l2t9b36x/i398oPw8vffuzqCChYBIa+cfWdNsfTpzAGvsR6OL\n/1XemGLbQ8hbCdjTwHtnBaRHvXOO2cA6XRrKmFU0gg1QRrqWm7l0y4KBAoGATNH3\nn0Qa+9PwrNrgBo4q0hjjSMXONKp3yFvNpZRdMIyYvtJvSm6coCNHf5Ry9vFoUpzX\npHGjG2jzqxHrFCqoXcaT5qa5eBTE70H/EQI1C60nXHQgr2TRc8p0TYHlhHZsUSp/\ntRM2MHlZaE/brk/uIsSyoi74tp+ey16Bjw/ViAkCgYAhWSo9psL/PYxaqE+RdfeL\nL6Qr/o0Hg+Ncet1WCLq6q6MsYy4bgTuKv6zC/wLxEJBdlGUCgdQjuKMRlI9V8CxA\nTPDjFP5FA1P8aYgRvXgmKVWjUhCqQN8aH8wuJqY217srkg/0Paf3C++V2frltmet\nJO9CV/9tMjink2AXRROxLA==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-expenditures@gsheets-378105.iam.gserviceaccount.com",
  "client_id": "102718705051172776437",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-expenditures%40gsheets-378105.iam.gserviceaccount.com"
}''';

//googlesheed id
  static final _gSheetsId = '1-nW5Z2RCEicRlSty0n2paQGKXyYu1Bqa_nMfIxd_pLc';
  static bool loading = true;
//init gsheet
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _workSheet;

  Future init() async {
//fetch the spreadsheet by its id
    final excelSheet = await _gsheets.spreadsheet(_gSheetsId);

//fetch worksheet by its title {mine is 2023}
    _workSheet = excelSheet.worksheetByTitle('Sheet2023');

    //get last ac value
    lastAc = await _workSheet!.values.value(column: 6, row: 1);
    numberofTransection = await _workSheet!.rowCount;
    var all = await _workSheet?.values.map.allRows();
    for (var i = 0; i < all!.length; i++) {
      print(all[i]);
    }
// insert data into excelsheet
    _workSheet!.values
        .insertValue(DateTime.now().toIso8601String(), column: 5, row: 1);
    // getCurrentTodo();
    loadAllTransections();
  }

  static Future postNew(
      String transectionName, String money, bool isIncome) async {
    var currentTime = DateTime.now().toIso8601String();
    if (_workSheet == null) return print('error------------------------------');
    numberofTransection++;

    // if (isIncome == true) {
    //   income = income += double.parse(money.toString());
    // } else {
    //   expense = expense += double.parse(money.toString());
    // }
    // balance += balance + double.parse(money.toString());
    currentTransections.add([
      transectionName,
      money,
      isIncome == true ? 'income' : 'expense',
      currentTime
    ]);
    await _workSheet!.values.appendRow([
      transectionName,
      money,
      isIncome == true ? 'income' : 'expense',
      currentTime
    ]);
  }

  static List<List<dynamic>> efficientList = [];

//count notes and load notes
  // static Future getCurrentTodo() async {
  //   while ((await _workSheet!.values
  //           .value(column: 1, row: numberofTransection + 1)) !=
  //       '') {
  //     //if not empty then keep incrementing the numberofTodo
  //     numberofTransection++;
  //     // efficientList.add([]);
  //     print('counting::: $numberofTransection');

  //     // var result =
  //     //     await _workSheet!.values.value(column: 3, row: numberofTodo + 1);
  //     // print(result);
  //   }
  //   //after counting...load the todo!
  //   loadAllTransections();
  //   // recalculate data!
  // }

//loadAllTodos
  static Future loadAllTransections() async {
    for (int i = 1; i < numberofTransection; i++) {
      final String transectionName =
          await _workSheet!.values.value(column: 1, row: i + 1);
      final String money =
          await _workSheet!.values.value(column: 2, row: i + 1);
      final String incomeOrexpense =
          await _workSheet!.values.value(column: 3, row: i + 1);

      if (currentTransections.length < numberofTransection) {
        currentTransections.add([transectionName, money, incomeOrexpense]);
      }
    }

    print(currentTransections);

    loading = false;
  }

// calculate income expense
  static void CalcuateAll() {
    //use for loop
    for (var i = 0; i < currentTransections.length; i++) {
      //if income
      if (currentTransections[i][2] == 'income') {
        income += double.parse(currentTransections[i][1]);
      } else {
        expense += double.parse(currentTransections[i][1]);
      }
    }

    balance = income - expense;
  }
}
