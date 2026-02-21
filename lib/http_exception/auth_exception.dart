class AuthException implements Exception {
  final Map<String, String> erros = {
    'EMAIL_EXISTS': 'O endereço de e-mail já está em uso por outra conta.',
    'OPERATION_NOT_ALLOWED':
        'O login com senha está desativado para este projeto.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente novamente mais tarde.',
    'EMAIL_NOT_FOUND':
        'Não existe registro de usuário correspondente a este identificador. O usuário pode ter sido excluído.',
    'INVALID_PASSWORD': 'A senha é inválida ou o usuário não possui uma senha.',
    'USER_DISABLED': 'A conta de usuário foi desativada por um administrador.',
    'INVALID_LOGIN_CREDENTIALS': 'Conta inválida!',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return erros[key].toString();
  }
}
