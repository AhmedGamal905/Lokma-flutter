import 'package:dio/dio.dart';
import 'package:lokma/Helpers/Constant/AuthRouts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customButton.dart';
import 'package:lokma/widgets/customField.dart';

class Verificate extends StatefulWidget {
  @override
  _VerificateState createState() => _VerificateState();
}

class _VerificateState extends State<Verificate> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _verificateCodeController;

  @override
  void initState() {
    super.initState();
    _verificateCodeController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _verificateCodeController?.dispose();
  }

  Dio dio = Dio();

  Future<void> _postData() async {
    if (!_globalKey.currentState.validate()) return;
    try {
      Map<String, String> data = {
        "verification_code": _verificateCodeController.text,
      };

      SharedPreferences preferences = await SharedPreferences.getInstance();

      Response response = await dio.post(
        AuthRouts.verification,
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + preferences.get('access_token'),
          },
        ),
      );
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/NavigationBar');
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
            'Verificate',
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
              height: 45,
            ),
            CustomTextField(
              obscureText: false,
              controller: _verificateCodeController,
              hint: 'verification code',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter your verification code';
                  // ignore: missing_returnre
                }
                return null;
              },
              icon: Icons.lock,
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              text: 'Verificate',
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
