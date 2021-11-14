import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customButton.dart';
import 'package:lokma/widgets/customField.dart';
import 'package:lokma/Helpers/Constant/AuthRouts.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _phoneController;
  TextEditingController _passwordController;
  TextEditingController _repasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _repasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
  }

  Dio dio = Dio();
  Future<void> _signUp() async {
    if (!_globalKey.currentState.validate()) return;
    try {
      Map<String, String> data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'password_confirmation': _repasswordController.text,
        'password': _passwordController.text,
        'mobile_token': 'mobile_token test',
      };

      Response response = await dio.post(
        AuthRouts.register,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/Verificate', (Route<dynamic> route) => false);
      } else {}
      Map value = response.data;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('access_token', value['access_token']);
    } on DioError catch (e) {
      Future.error(e);
      return showDialog(
        context: context,
        builder: (conx) => CustomDialog(
          title: 'Oh somethin went wrong!',
          body: e.response.statusMessage.toString(),
          buttonText: 'cancel',
          buttonOnPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.whiteTheme,
      appBar: AppBar(
        backgroundColor: CColors.whiteTheme,
        centerTitle: true,
        elevation: 0,
        title: Title(
          color: CColors.blackTheme,
          child: Text(
            "Create Account",
            style: TextStyle(
              fontSize: 16.0,
              color: CColors.blackTheme,
            ),
          ),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(
              height: 55,
            ),
            Text(
              "Please enter Your First name, Last \nname, E-mail and password",
              style: TextStyle(
                color: CColors.lightBlackTheme,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 55,
            ),
            CustomTextField(
              controller: _nameController,
              obscureText: false,
              hint: 'Name',
              icon: Icons.person,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter youName';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _emailController,
              obscureText: false,
              hint: 'E-mail',
              icon: Icons.email_outlined,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter you E-mail';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              obscureText: false,
              controller: _phoneController,
              hint: 'Phone',
              icon: Icons.phone,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter you Phone';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              obscureText: true,
              controller: _passwordController,
              hint: 'Password',
              icon: Icons.lock_outline,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter you Password';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              obscureText: true,
              controller: _repasswordController,
              hint: 'Re-Enter Password',
              icon: Icons.lock_outline,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Re-Enter you Password';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By creating this account i agree to food delivery App ",
                        style: TextStyle(
                          color: CColors.lightBlackTheme,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            color: CColors.orangeTheme,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Text(
                        " and ",
                        style: TextStyle(
                          color: CColors.lightBlackTheme,
                          fontSize: 10,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Privecy Poilcy",
                          style: TextStyle(
                            color: CColors.orangeTheme,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            CustomButton(
              text: "Create Account",
              onTap: () {
                _signUp();
              },
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
