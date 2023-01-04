import 'package:flutter/material.dart';

class Reward_screen extends StatefulWidget {
  const Reward_screen({super.key});

  @override
  State<Reward_screen> createState() => _Reward_screenState();
}

class _Reward_screenState extends State<Reward_screen> {
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
                    title: Text("My Rewards",
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
              Text("No rewards yet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
            ]))));
  }
}
