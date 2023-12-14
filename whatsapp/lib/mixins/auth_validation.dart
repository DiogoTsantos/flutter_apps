mixin AuthValidations {
  validName(String? name) {
    if ( name == null || name.isEmpty ) {
      return 'O Nome é um campo obrigatório';
    }

    if ( name.length < 3) {
      return 'O Nome precisa ter pelo menos 3 caracteres';
    }

    return null;
  }
  
  validPass(String? pass) {
    if ( pass == null || pass.isEmpty ) {
      return 'A Senha é um campo obrigatório';
    }

    if ( pass.length < 6) {
      return 'A Senha precisa ter pelo menos 6 caracteres';
    }

    return null;
  }

  validMail(String? mail) {
    if ( mail == null || mail.isEmpty ) {
      return 'O E-mail é um campo obrigatório';
    }

    final mailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if ( ! mailRegExp.hasMatch(mail)) {
      return 'E-mail inválido';
    }
  }
}