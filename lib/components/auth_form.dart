import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';

enum AuthMode { login, register }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode authMode = AuthMode.login;
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final authData = {"email": "", "password": ""};

  Future<void> onSubmit() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    formKey.currentState?.save();

    setState(() => isLoading = true);
    Auth auth = Provider.of(context, listen: false);

    if (authMode == AuthMode.login) {
      // Login
      await auth.register(
        authData['email']!,
        authData['password']!,
        'signInWithPassword',
      );
    } else {
      // Registro
      await auth.register(authData['email']!, authData['password']!, 'signUp');
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size;
    return Card(
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        height: authMode == AuthMode.login ? 330 : 470,
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
              if (authMode == AuthMode.register)
                TextFormField(
                  decoration: InputDecoration(label: Text("Confirmar Senha")),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Senhas não são iguais!";
                    }

                    if (value!.trim().isEmpty) {
                      return "Senha inválida!";
                    }

                    return null;
                  },
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
                  if (authMode == AuthMode.login) {
                    setState(() {
                      authMode = AuthMode.register;
                    });
                  } else {
                    setState(() {
                      authMode = AuthMode.login;
                    });
                  }
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
