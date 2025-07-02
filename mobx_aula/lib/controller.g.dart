// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on ControllerBase, Store {
  Computed<String>? _$mailAndPasswordComputed;

  @override
  String get mailAndPassword => (_$mailAndPasswordComputed ??= Computed<String>(
          () => super.mailAndPassword,
          name: 'ControllerBase.mailAndPassword'))
      .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: 'ControllerBase.isValid'))
      .value;

  late final _$mailAtom = Atom(name: 'ControllerBase.mail', context: context);

  @override
  String get mail {
    _$mailAtom.reportRead();
    return super.mail;
  }

  @override
  set mail(String value) {
    _$mailAtom.reportWrite(value, super.mail, () {
      super.mail = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: 'ControllerBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$userIsLoggedAtom =
      Atom(name: 'ControllerBase.userIsLogged', context: context);

  @override
  bool get userIsLogged {
    _$userIsLoggedAtom.reportRead();
    return super.userIsLogged;
  }

  @override
  set userIsLogged(bool value) {
    _$userIsLoggedAtom.reportWrite(value, super.userIsLogged, () {
      super.userIsLogged = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('ControllerBase.login', context: context);

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase', context: context);

  @override
  void setMail(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setMail');
    try {
      return super.setMail(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mail: ${mail},
password: ${password},
userIsLogged: ${userIsLogged},
isLoading: ${isLoading},
mailAndPassword: ${mailAndPassword},
isValid: ${isValid}
    ''';
  }
}
