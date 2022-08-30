import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class formAuth extends StatefulWidget {
  formAuth({Key? key, required this.submitForm}) : super(key: key);

  final Function(String username, String email, String password, bool isLogin)
      submitForm;

  @override
  State<formAuth> createState() => _formAuthState();
}

class _formAuthState extends State<formAuth> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = false;
  String _username = '';
  String _email = '';
  String _password = '';

  void _trySubmbit() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitForm(_username, _email, _password, isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 200, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      onSaved: (value) {
                        _username = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return "Username minimal 4 karakter";
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Username"),
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    key: ValueKey('email'),
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Email tidak valid";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("Email"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return "Password minimal 6 karakter";
                      }
                    },
                    obscureText: true,
                    // keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text("Password"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _trySubmbit,
                    child: isLogin ? Text('Login') : Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: isLogin
                        ? Text("Create Account")
                        : Text("I Have Already Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
