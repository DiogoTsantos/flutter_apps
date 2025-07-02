import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class Controller = ControllerBase with _$Controller;

// O mixin Store serve para geração dos códigos de forma automática.
abstract class ControllerBase with Store {
  ControllerBase() {
  // // Executado sempre que o estado é modificado.
    // autorun((_) {
    //   print(mail);
    //   print(password);
    // });
  }

  // @observable
  // int counter = 0;

  // @action
  // increment() {
  //   counter++;
  // }

  @observable
  String mail = '';

  @observable
  String password = '';

  @observable
  bool userIsLogged = false;

  @observable
  bool isLoading = false;

  @computed
  String get mailAndPassword => '$mail $password';

  @computed
  bool get isValid => mail.length >= 5 && password.length >= 5;


  @action
  void setMail(String value) => mail = value;

  @action
  void setPassword(String value) => password = value;


  @action
  Future<void> login() async {
    isLoading = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;

    userIsLogged = true;
  }



  // Observable<int> _counter = Observable<int>(0);
  // Action? increment;

  // Controller() {
  //   increment = Action(_incrementCounter);
  // }

  // _incrementCounter() {
  //   counter++;
  // }

  // int get counter => _counter.value;
  // set counter(int value) => _counter.value = value;
}