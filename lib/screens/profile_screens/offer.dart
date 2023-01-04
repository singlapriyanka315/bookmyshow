import 'package:flutter/material.dart';

class Offer_screen extends StatefulWidget {
  const Offer_screen({super.key});

  @override
  State<Offer_screen> createState() => _Offer_screenState();
}

class _Offer_screenState extends State<Offer_screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                  child: ListTile(
                    title: Text("Offers",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            ),
            body: Container(
                child: Column(children: [
              SizedBox(height: 115),
              Image.asset("assets/images/rewards.webp"),
              SizedBox(height: 50),
              Text("Opps! No Offers available",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ]))));
  }
}
