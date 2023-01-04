import 'package:flutter/material.dart';

class Discount_screen extends StatefulWidget {
  const Discount_screen({super.key});

  @override
  State<Discount_screen> createState() => _Discount_screenState();
}

class _Discount_screenState extends State<Discount_screen> {
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
                child: ListTile(
                  title: Text("Discounts",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            body: Container(
                child: Column(children: [
              SizedBox(height: 115),
              Image.asset("assets/images/rewards.webp"),
              SizedBox(height: 50),
              Text("No discount available",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ]))));
  }
}
