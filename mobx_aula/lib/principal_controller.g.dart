// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'principal_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PrincipalController on PrincipalControllerBase, Store {
  late final _$newItemAtom =
      Atom(name: 'PrincipalControllerBase.newItem', context: context);

  @override
  String get newItem {
    _$newItemAtom.reportRead();
    return super.newItem;
  }

  @override
  set newItem(String value) {
    _$newItemAtom.reportWrite(value, super.newItem, () {
      super.newItem = value;
    });
  }

  late final _$itemsAtom =
      Atom(name: 'PrincipalControllerBase.items', context: context);

  @override
  ObservableList<ItemlController> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<ItemlController> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$PrincipalControllerBaseActionController =
      ActionController(name: 'PrincipalControllerBase', context: context);

  @override
  void setNewItem(String value) {
    final _$actionInfo = _$PrincipalControllerBaseActionController.startAction(
        name: 'PrincipalControllerBase.setNewItem');
    try {
      return super.setNewItem(value);
    } finally {
      _$PrincipalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addItem() {
    final _$actionInfo = _$PrincipalControllerBaseActionController.startAction(
        name: 'PrincipalControllerBase.addItem');
    try {
      return super.addItem();
    } finally {
      _$PrincipalControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newItem: ${newItem},
items: ${items}
    ''';
  }
}
