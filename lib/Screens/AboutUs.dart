import 'package:flutter/material.dart';
import 'package:lokma/helpers/constant/Colors.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.orangeTheme,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'About Us',
          style: TextStyle(
            color: CColors.whiteTheme,
            fontSize: 15,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Lokma Restaurant',
            style: TextStyle(
              color: CColors.textFelidHintTheme,
              fontSize: 35,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/restaurant.jfif',
                  fit: BoxFit.cover,
                  height: 85,
                  width: 85,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Craving some delicious Greek food? Maybe you’re in the mood for a juicy steak? No matter what kind of meal you have in mind, The Spot Restaurant is ready to prepare it for you.',
              style: TextStyle(
                color: CColors.textFelidHintTheme,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Since 1973, The Spot Restaurant has been the go-to diner for residents of Binghamton, NY. Our diner serves breakfast all day, in addition to wholesome and flavorful dining options for lunch and dinner. From burgers to salads, seafood to pastas, you’ll find all kinds of hearty meals prepared fresh at The Spot Restaurant. Our diner also has a full bakery with delicious baked goods and other treats, including our famous cheesecake. Sounds delicious, right?',
              style: TextStyle(
                color: CColors.textFelidHintTheme,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'We’re here to serve you the best food around, whenever you’re looking for a great American restaurant in Binghamton, NY.',
              style: TextStyle(
                color: CColors.textFelidHintTheme,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
