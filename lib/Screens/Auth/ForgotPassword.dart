import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customButton.dart';
import 'package:lokma/widgets/customField.dart';
import 'package:lokma/Helpers/Constant/AuthRouts.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController?.dispose();
  }

  Dio dio = Dio();

  Future<void> _postData() async {
    if (!_globalKey.currentState.validate()) return;
    try {
      Map<String, String> data = {
        'phone': _phoneController.text,
      };

      Response response = await dio.post(
        AuthRouts.forgotPasword,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/Home');
      } else {}
      print(response.data.toString());
    } catch (e) {
      print(e.toString());
      Future.error(e);
      return showDialog(
        context: context,
        builder: (conx) => CustomDialog(
          title: 'Oh somethin went wrong!',
          body: e.toString(),
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
            'Forgot password',
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
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              obscureText: false,
              controller: _phoneController,
              hint: 'phone Number',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter phone number';
                  // ignore: missing_returnre
                }
                return null;
              },
              icon: Icons.phone,
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              text: 'Send code',
              onTap: () {
                _postData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
