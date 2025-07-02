import 'package:mobx/mobx.dart';

part 'item_controller.g.dart';

class ItemlController = ItemControllerBase with _$ItemlController;

abstract class ItemControllerBase with Store {
  final String title;
  @observable
  bool checked = false;
  ItemControllerBase({required this.title});

  @action
  void changeChecked(bool? value) {
    if ( value == null ) {
      checked = false;
    } else {
      checked = value;
    }
  }
}