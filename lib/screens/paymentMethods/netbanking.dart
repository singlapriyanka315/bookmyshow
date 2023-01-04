import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class NetBanking extends StatefulWidget {
  final int amount;
  NetBanking({required this.amount, super.key});

  @override
  State<NetBanking> createState() => _NetBankingState();
}

class _NetBankingState extends State<NetBanking> {
   final _formKey = GlobalKey<FormState>();
   TextEditingController vpnController = TextEditingController();
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
                  title: Text("NetBanking",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  child: Column(children: [
                           Divider(),
                ListTile(
                  title: Text("Amount Payable",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,  fontSize: 18)),
                  trailing: Text("₹${widget.amount}",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,  fontSize: 18)),
                ),
                Divider(),
                Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
                        controller: vpnController,
                        //obscureText:true,
                       
                          validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your Virtual Payment Address(VPA)!';
              }
              return null;
            },
             onEditingComplete: () {
                          if(vpnController.text.isNotEmpty){
                          FocusManager.instance.primaryFocus?.unfocus();
                          //  login();
                          }
                          else{
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Enter your Virtual Payment Address(VPA)",
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(200),
                          // ),
                        ),
                      ),
        ],
      )
                )
            
              ])),
            )));
  }
}
