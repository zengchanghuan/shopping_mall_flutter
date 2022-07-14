class FocusModel {

  //http://jdmall.itying.com/api/focus
  /*
  var temp = {
    "result": [
      {
        "_id": "59f6ef443ce1fb0fb02c7a43",
        "title": "笔记本电脑",
        "status": "1",
        "pic": "public\\upload\\UObZahqPYzFvx_C9CQjU8KiX.png",
        "url": "12"
      },
      {
        "_id": "5a012efb93ec4d199c18d1b4",
        "title": "第二个轮播图",
        "status": "1",
        "pic": "public\\upload\\f3OtH11ZaPX5AA4Ov95Q7DEM.png"
      },
      {
        "_id": "5a012f2433574208841e0820",
        "title": "第三个轮播图",
        "status": "1",
        "pic": "public\\upload\\s5ujmYBQVRcLuvBHvWFMJHzS.jpg"
      },
      {
        "_id": "5a688a0ca6dcba0ff4861a3d",
        "title": "教程",
        "status": "1",
        "pic": "public\\upload\\Zh8EP9HOasV28ynDSp8TaGwd.png"
      }
    ]
  };
  */

  String? sId; //String?表示可空类型
  String? title;
  String? status;
  String? pic;
  String? url;

  FocusModel({this.sId, this.title, this.status, this.pic, this.url});

  FocusModel.fromJson(Map jsonData) {
    sId = jsonData["_id"];
    title = jsonData["title"];
    status = jsonData['status'];
    pic = jsonData['pic'];
    url = jsonData['url'];
  }
}
