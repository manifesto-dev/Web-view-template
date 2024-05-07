import 'package:web_app_template/business_logic/api_caller.dart';

class Repository {
  final APICaller _apiCaller = APICaller();
  Future getPolicy() async {
    _apiCaller.setUrl("/policy", false);
    var result = await _apiCaller.getData();
    return result;
  }
}
