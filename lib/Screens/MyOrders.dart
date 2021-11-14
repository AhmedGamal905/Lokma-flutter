import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lokma/Models/PreviousOrders.dart';
import 'package:lokma/helpers/constant/Colors.dart';
import 'package:lokma/helpers/constant/Routs.dart';
import 'package:lokma/services/CustomDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Dio dio = Dio();
  Future<PreviousOrders> _getOrders() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      Response response = await dio.get(
        Routs.myOrders,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + preferences.get('access_token'),
          },
        ),
      );
      if (response.statusCode == 200) {
        return PreviousOrders.fromJson(response.data);
      } else {
        return PreviousOrders();
      }
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
      appBar: AppBar(
        backgroundColor: CColors.orangeTheme,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'My Orders',
          style: TextStyle(
            color: CColors.whiteTheme,
            fontSize: 15,
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.orders.data.length,
              itemBuilder: (context, index) {
                Order order = snapshot.data.orders.data[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: CColors.textFelidTheme,
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            spreadRadius: 0),
                      ],
                      color: CColors.whiteTheme,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Order Id : " + order.id.toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Order created at : " + order.createdAt.toString(),
                            style: TextStyle(
                                color: CColors.blackTheme, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Total price : " + order.totalPrice.toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.00),
                          child: Text(
                            "Status : " + order.status.status.toString(),
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: CColors.orangeTheme,
              ),
            );
          }
        },
      ),
    );
  }
}
