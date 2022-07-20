import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'storage.dart';

class SearchServices {
  static setHistoryData(keywords) async {
    /*
          1、获取本地存储里面的数据  (searchList)

          2、判断本地存储是否有数据

              2.1、如果有数据 

                    1、读取本地存储的数据
                    2、判断本地存储中有没有当前数据，
                        如果有不做操作、
                        如果没有当前数据,本地存储的数据和当前数据拼接后重新写入           


              2.2、如果没有数据

                    直接把当前数据放在数组中写入到本地存储
      
      
      */
    //注意：新版shared_preferences增加了可空类型，如果为空不会报错了，所以这里直接可以判断。
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      var hasData = searchListData.any((v) {
        return v == keywords;
      });
      if (!hasData) {
        if (kDebugMode) {
          print(keywords);
        }
        searchListData.add(keywords);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } else {
      List tempList = [];
      tempList.add(keywords);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  static getHistoryList() async {
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      return searchListData;
    }
    return [];
  }

  static clearHistoryList() async {
    await Storage.remove('searchList');
  }

  static removeHistoryData(keywords) async {
    //注意：新版shared_preferences的可空类型
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      searchListData.remove(keywords);
      await Storage.setString('searchList', json.encode(searchListData));
    }
  }
}
