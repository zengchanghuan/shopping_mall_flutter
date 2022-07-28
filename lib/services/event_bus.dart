import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {
  late String str;

  ProductContentEvent(String string){
   str = string;
  }
}

//用户中心广播
class UserEvent {
  String str;

  UserEvent(this.str);
}

class AddressEvent{
  String str;
  AddressEvent(this.str);
}

//结算页面
class CheckOutEvent{
  String str;
  CheckOutEvent(this.str);
}