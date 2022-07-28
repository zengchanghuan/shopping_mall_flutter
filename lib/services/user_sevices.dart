import '../services/storage.dart';
import 'dart:convert';

class UserServices {
  static getUserInfo() async {
    String? userInfo = await Storage.getString('userInfo');
    if (userInfo != null) {
      List userInfoList = json.decode(userInfo);
      return userInfoList;
    } else {
      return [];
    }
  }

  static getUserLoginState() async {
    var userInfo = await UserServices.getUserInfo();
    if (userInfo.length > 0 && userInfo[0]["username"] != "") {
      return true;
    }
    return false;
  }

  static loginOut() {
    Storage.remove('userInfo');
  }
}
