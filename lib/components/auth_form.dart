import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/http_exception/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { login, register }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  AuthMode authMode = AuthMode.login;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final authData = {"email": "", "password": ""};

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Ocorreu um erro!"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> onSubmit() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    formKey.currentState?.save();

    setState(() => isLoading = true);
    Auth auth = Provider.of(context, listen: false);

    try {
      if (authMode == AuthMode.login) {
        // Login
        await auth.register(
          authData['email']!,
          authData['password']!,
          'signInWithPassword',
        );
      } else {
        // Registro
        await auth.register(
          authData['email']!,
          authData['password']!,
          'signUp',
        );
      }
    } on AuthException catch (error) {
      _showError(error.toString());
    } catch (error) {
      _showError('Ocorreu um erro inesperavel: $error');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size;

    return Card(
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceIn,
        padding: EdgeInsets.all(20),
        height: authMode == AuthMode.login ? 350 : 470,
        width: deviceWidth.width * 0.80,
        child: Form(
          key: formKey,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("E-mail")),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => authData["email"] = email ?? "",
                validator: (value) {
                  if (!value!.contains("@")) {
                    return "Email inválido";
                  }

                  if (value.trim().isEmpty) {
                    return "Email inválido";
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(label: Text("Senha")),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: passwordController,
                onSaved: (password) => authData["password"] = password ?? "",
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Senha inválida!";
                  }

                  return null;
                },
              ),
              //if (authMode == AuthMode.register)
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: authMode == AuthMode.register ? 60 : 0,
                child: AnimatedOpacity(
                  opacity: authMode == AuthMode.register ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: TextFormField(
                    decoration: InputDecoration(label: Text("Confirmar Senha")),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (authMode == AuthMode.register) {
                        if (value != passwordController.text) {
                          return "Senhas não são iguais!";
                        }

                        if (value!.trim().isEmpty) {
                          return "Senha inválida!";
                        }

                        return null;
                      }
                      return null;
                    },
                  ),
                ),
              ),

              SizedBox(
                child: isLoading == true
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: onSubmit,
                        child: authMode == AuthMode.login
                            ? Text("Entrar")
                            : Text("Registrar"),
                      ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (authMode == AuthMode.login) {
                      authMode = AuthMode.register;
                    } else {
                      authMode = AuthMode.login;
                    }
                  });
                },
                child: authMode == AuthMode.login
                    ? Text("Registrar")
                    : Text("Fazer Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
