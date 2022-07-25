import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class ProductContentEvent {
  late String str;

  ProductContentEvent(String string){
   str = string;
  }
}
