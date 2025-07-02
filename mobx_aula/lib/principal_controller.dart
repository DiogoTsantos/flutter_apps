import 'package:mobx/mobx.dart';
import 'package:mobx_aula/item_controller.dart';

part 'principal_controller.g.dart';

class PrincipalController = PrincipalControllerBase with _$PrincipalController;

abstract class PrincipalControllerBase with Store {
  @observable
  String newItem = '';

  @action
  void setNewItem( String value ) => newItem = value;

  @observable
  ObservableList<ItemlController> items = ObservableList<ItemlController>();

  @action
  void addItem() {
    if ( newItem.isEmpty ) return;
    items.add(ItemlController(title: newItem));
    newItem = '';
  }
}