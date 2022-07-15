class ProductModel {
  /*
   {
    "_id": "5a0425bc010e711234661439",
    "title": "磨砂牛皮男休闲鞋-有属性",
    "cid": "5a042480010e711234661436",
    "price": 688,
    "old_price": "968",
    "pic": "public\\upload\\RinsvExKu7Ed-ocs_7W1DxYO.png",
    "s_pic": "public\\upload\\RinsvExKu7Ed-ocs_7W1DxYO.png_200x200.png"
  };
  */

  List<ProductItemModel> result = [];

  ProductModel({required this.result});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result.add(ProductItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result.map((v) => v.toJson()).toList();
    return data;
  }
}

class ProductItemModel {
  String? sId; //String? 表示可空类型
  String? title;
  String? cid;
  Object? price; //所有的类型都继承 Object
  String? oldPrice;
  String? pic;
  String? sPic;

  ProductItemModel(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['pic'] = pic;
    data['s_pic'] = sPic;
    return data;
  }
}
