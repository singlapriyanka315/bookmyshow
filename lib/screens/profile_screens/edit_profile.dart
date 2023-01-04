import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Edit_profile extends StatefulWidget {
  const Edit_profile({super.key});

  @override
  State<Edit_profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  //XFile ? image;

  var firstname;
  var lastname;
  var email;
  var phone;
  String imageUrl = " ";

  initState() {
    getUserProfile();
  }

  //final pickImage = ImagePicker();
  late File pickedImage;

  void getImage() async {
    final picture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    Reference ref =
        FirebaseStorage.instance.ref().child("assets/images/avatar.png");

    await ref.putFile(File(picture!.path));
    await ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        imageUrl = value;
      });
    });
  }

  updateData() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      'first name': fnamecontroller.text.trim(),
      'phone': mobilecontroller.text.trim(),
    }).then((value) {
      print("updated");
    });
  }

  var value;
//  late UserModel userModel;
  getUserProfile() async {
    User? user = await FirebaseAuth.instance.currentUser;
    await user?.reload();
    value = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    print(value.data()!['first name']);
    print(value.data()!['first name']);
    setState(() {
      firstname = value.data()!['first name'];
      //lastname = value.data()!['last name'];
      email = value.data()!['email'];
      phone = value.data()!['phone'];

      emailcontroller.text = '$email';
      mobilecontroller.text = '$phone';
      fnamecontroller.text = '$firstname';
     // lnamecontroller.text = '$lastname';
    });
    return value;
  }

  @override
  void dispose() {
    fnamecontroller.dispose();
    lnamecontroller.dispose();
    emailcontroller.dispose();
    mobilecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return BlocBuilder<ProfileBloc, ProfileState>(
    //builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(223, 24, 39, 0.9)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
          child: ListTile(
            title: Text("Edit Profile",
                style: TextStyle(color: Colors.black, fontSize: 22)),
          ),
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Column(children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 80,
                  // backgroundImage: imageUrl == " " ? Icon(Icons.person, color:Colors.white) : Image.network(imageUrl),
                  //child: ClipOval(child: SizedBox(width: 180, height: 180))),
                  child: imageUrl == " "
                      ? Image.asset("assets/images/avatar.png")
                      : Image.network(imageUrl),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          width: 115,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child:  TextFormField(
                controller: fnamecontroller,
                decoration: InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 79, 78, 78),
                              )),
                // decoration: const InputDecoration(
                //   icon: Icon(Icons.person),
                //   hintText: 'Name',
                // ),
              ),

          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child:  TextFormField(
                readOnly: true,
                controller: emailcontroller,
                decoration: InputDecoration(
                              labelText: "Email address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 79, 78, 78),
                              )),
              ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: TextFormField(
                controller: mobilecontroller,
                 decoration: InputDecoration(
                              labelText: "Mobile Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(200),
                              ),
                              prefixIcon: Icon(
                                Icons.call,
                                color: Color.fromARGB(255, 79, 78, 78),
                              )),
              ),
        ),
        SizedBox(
          height: 20,
          width: 115,
        ),
        SizedBox(
          width:350,
          child: CupertinoButton(
                padding: const EdgeInsets.all(10.0),
                color: Color.fromRGBO(223, 24, 39, 0.9),
                borderRadius: BorderRadius.circular(200),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              updateData();
              getUserProfile();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("✓ Profile updated successfully",
                        style: TextStyle(color: Colors.white)),
                    duration: Duration(milliseconds: 900),
                    backgroundColor: Color.fromARGB(255, 58, 126, 60)),
              );
              //getUserData();
            },
            child: const Text('Save Changes'),
          ),
        ),

        // Image.asset("assets/images/rewards.webp")
      ]))),
    );
    // },
    //);
  }
}
