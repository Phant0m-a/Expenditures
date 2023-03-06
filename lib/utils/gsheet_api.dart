import 'package:gsheets/gsheets.dart';

class gSheetApi {
//numberofTodo
  static int numberofTodo = 0;

//list of current-Todo
  static List<List<dynamic>> currentTodo = [];

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
// insert data into excelsheet
    _workSheet!.values.insertValue('Expense loaded...', column: 1, row: 1);
    getCurrentTodo();
  }

  static Future postNew(
      String transectionName, String money, String isIncome) async {
    if (_workSheet == null) return print('error------------------------------');
    numberofTodo++;
    currentTodo
        .add([transectionName, money, isIncome == true ? 'income' : 'expense']);
    await _workSheet!.values.appendRow(
        [transectionName, money, isIncome == true ? 'income' : 'expense']);
  }

//count notes and load notes
  Future getCurrentTodo() async {
    while (await _workSheet!.values.value(column: 1, row: numberofTodo + 1) !=
        '') {
      //if not empty then keep incrementing the numberofTodo
      numberofTodo++;
    }

    //after counting...load the todo!
    loadAllTransections();
  }

//loadAllTodos
  Future loadAllTransections() async {
    for (var i = 0; i < numberofTodo; i++) {
      String transectionName =
          await _workSheet!.values.value(column: 1, row: i + 1);
      String money = await _workSheet!.values.value(column: 2, row: i + 1);

      String incomeOrexpense =
          await _workSheet!.values.value(column: 3, row: i + 1);

      if (currentTodo.length < numberofTodo) {
        currentTodo.add([money, transectionName, incomeOrexpense]);
      }
    }
    loading = false;
  }
}
