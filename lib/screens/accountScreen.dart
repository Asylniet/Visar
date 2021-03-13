import 'package:flutter/material.dart';
import 'package:visar/colors.dart';

GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
bool disabled = true;
Color _iconColor = blue;
String _login;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

  PageController _pageController;
class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Авторизуйтесь",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w200,
              color: blue,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              constraints: BoxConstraints(
                minHeight: 100.0,
                maxHeight: 500.0,
              ),
              color: white,
              height: 10,
              child: PageView(
                controller: _pageController,
                children: [
                  Login(),
                  Container(
                    color: blue,
                    width: 100,
                    height: 100,
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            padding: EdgeInsets.all(0),
            color: Colors.transparent,
            disabledElevation: 0.0,
            disabledColor: Colors.transparent,
            elevation: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              decoration: BoxDecoration(
                  color: disabled ? blue.withOpacity(0.8) : blue,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                    )
                  ]),
              child: Text(
                "Продолжить →",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: disabled ? white.withOpacity(0.8) : white,
                ),
              ),
            ),
            onPressed: disabled
                ? null
                : () {
                  setState(() {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 250), curve: Curves.fastOutSlowIn);
                  });
                  },
          )
        ],
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: _iconColor,
          ),
          child: TextFormField(
            validator: (String text) {
              if (text.isEmpty) {
                return "Введите имя";
              }
            },
            onSaved: (String text) {
              setState(() {
                _login = text;
                _pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
              });
            },
            onEditingComplete: () {
              if (!_loginFormKey.currentState.validate()) {
                setState(() {
                  _iconColor = Colors.red;
                });
                return;
              } else {
                _loginFormKey.currentState.save();
                setState(() {
                  _iconColor = blue;
                });
              }
            },
            decoration: InputDecoration(
              labelText: "Логин",
              labelStyle: TextStyle(fontSize: 20),
              prefixIcon: Icon(
                Icons.person,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: blue),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
