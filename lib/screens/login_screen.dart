import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/registration_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/screens/todo_list_screen.dart';
import 'package:todo_app_with_flutter_and_firebase/service/auth_service.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/custom_raised_button.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/custom_text_field.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/loader.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  bool shouldNavigate = false;
  final GlobalKey<State> _loaderKey = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5d793),// RD's Update
      appBar: AppBar(
        backgroundColor: Colors.transparent,// RD's Update
        elevation: 0,// RD's Update
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 600,
                  child: Image(
                    image: AssetImage("images/todologin.png"),// RD's Update
                    fit: BoxFit.contain,
                  ),
                ),
                CustomTextField(
                  editingController: _emailController,
                  isObscure: false,
                  labelText: "Email",
                  textFieldValidator: emailValidation,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  editingController: _passwordController,
                  isObscure: true,
                  labelText: "Password",
                  textFieldValidator: passwordValidation,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRaisedButton(
                      textLabel: "Login",
                      onPressedExecution: onLogin,
                    ),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.black),// RD's Update
                    text: "Don't have an account ? ",
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationScreen(),
                                settings: RouteSettings(name: '/registration'),
                              ),
                            );
                          },
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String emailValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }
    return null;
  }

  String passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  void onLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Loader.showLoadingDialog(context, _loaderKey);
    shouldNavigate = await AuthService.loginWithEmailAndPassword(
        _emailController.text, _passwordController.text);
    if (shouldNavigate) {
      Navigator.of(_loaderKey.currentContext, rootNavigator: true).pop();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => TodoListScreen(),
            settings: RouteSettings(name: '/todo_list'),
          ),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(_loaderKey.currentContext, rootNavigator: true).pop();
    }
  }
}
