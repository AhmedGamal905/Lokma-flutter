import 'package:lokma/helpers/constant/Routs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:lokma/widgets/customButton.dart';
import 'package:lokma/widgets/customField.dart';
import 'package:lokma/Provider/CartProvider.dart';

class StoreOrder extends StatefulWidget {
  @override
  _StoreOrderState createState() => _StoreOrderState();
}

class _StoreOrderState extends State<StoreOrder> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _addressController;
  TextEditingController _phoneController;
  TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
  }

  Dio dio = Dio();

  Future<void> _storeOrder() async {
    if (!_globalKey.currentState.validate()) return;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      Response response = await dio.post(
        Routs.storeMyOrder,
        data: {
          "address": _addressController.text,
          "longitude": 33.3,
          "latitude": 33.3,
          "delivery_date": "2020-08-29",
          "delivery_time": "من وقت الي وقت",
          "district": null,
          "reciver_phone": _phoneController.text,
          "reciver_name": null,
          "card_description": null,
          "rate": null,
          "comment": _noteController.text,
          "note": null,
          "total_price": context.read<CartProvider>().totalPrice,
          "type_payment": 0,
          "delivery_cost": ((context.read<CartProvider>().totalPrice) * 0.05),
          "tax": 1,
          "products": List<dynamic>.from(
            context.read<CartProvider>().cartItems.map((e) => e.toJson()),
          ),
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + preferences.get('access_token'),
          },
        ),
      );
      if (response.statusCode == 200) {
        context.read<CartProvider>().empty();
        return showDialog(
          context: context,
          builder: (conx) => CustomDialog(
            title: "",
            body: "Order successfully completed",
            buttonText: "Continue shopping!",
            buttonOnPressed: () {
              Navigator.pushNamed(context, '/NavigationBar');
            },
          ),
        );
      } else {}
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
    return Consumer<CartProvider>(
      builder: (context, cartModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: CColors.orangeTheme,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'checkout',
              style: TextStyle(
                color: CColors.whiteTheme,
                fontSize: 15,
              ),
            ),
          ),
          body: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/paying.svg',
                    height: 200,
                  ),
                ),
                CustomTextField(
                  hint: "Enter address in details",
                  icon: Icons.home,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  controller: _addressController,
                  obscureText: false,
                ),
                CustomTextField(
                  hint: "Enter your Phone number",
                  icon: Icons.phone,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the phone number';
                    }
                    return null;
                  },
                  controller: _phoneController,
                  obscureText: false,
                ),
                CustomTextField(
                  hint: "Note",
                  icon: Icons.notes,
                  validator: null,
                  controller: _noteController,
                  obscureText: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: 'Checkout!',
                    onTap: _storeOrder,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
