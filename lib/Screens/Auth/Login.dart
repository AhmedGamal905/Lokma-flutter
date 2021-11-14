import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokma/Helpers/Constant/AuthRouts.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customButton.dart';
import 'package:lokma/widgets/customField.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _phoneController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController?.dispose();
    _passwordController?.dispose();
  }

  Dio dio = Dio();

  Future<void> _logIn() async {
    if (!_globalKey.currentState.validate()) return;
    try {
      Map<String, String> data = {
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'mobile_token': 'test mobile_token'
      };

      Response response = await dio.post(
        AuthRouts.login,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/NavigationBar', (Route<dynamic> route) => false);
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
            'login',
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
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: SvgPicture.asset(
                      'assets/images/LokmaAppLogo.svg',
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Please enter your username or\n E-mail for Sign in",
                style: TextStyle(
                  color: CColors.lightBlackTheme,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            CustomTextField(
              obscureText: false,
              controller: _phoneController,
              hint: 'phone Number',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter phone number';
                }
                return null;
              },
              icon: Icons.phone,
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
                  return 'Enter Password ';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ForgotPassword');
                },
                child: Text(
                  "Forgot Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: CColors.lightBlackTheme,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            CustomButton(
              text: 'Login',
              onTap: () {
                _logIn();
              },
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don' have an account? ",
                  style: TextStyle(
                    color: CColors.lightBlackTheme,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/SignUp');
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      color: CColors.orangeTheme,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
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
