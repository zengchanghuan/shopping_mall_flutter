class CateModel {
  List<CateItemModel> result = [];

  CateModel({required result});

  CateModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result.add(CateItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result.isNotEmpty) {
      data['result'] = result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CateItemModel {
  String? sId; //String? 表示可空类型
  String? title;
  Object? status;
  String? pic;
  String? pid;
  String? sort;

  CateItemModel(
      {sId, title, status, pic, pid, sort});

  CateItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    return data;
  }
}
