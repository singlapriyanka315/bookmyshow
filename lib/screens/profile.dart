import 'package:bookmyapp/blocs/profile_bloc/profile_bloc.dart';
import 'package:bookmyapp/screens/profile_screens/account.dart';
import 'package:bookmyapp/screens/profile_screens/discount.dart';
import 'package:bookmyapp/screens/profile_screens/edit_profile.dart';
import 'package:bookmyapp/screens/profile_screens/offer.dart';
import 'package:bookmyapp/screens/profile_screens/orders.dart';
import 'package:bookmyapp/screens/profile_screens/rewards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  // AuthService authservice = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController myfirstnameController = TextEditingController();
  TextEditingController mylastnameController = TextEditingController();
  TextEditingController myemailController = TextEditingController();
  TextEditingController myphoneController = TextEditingController();
  var firstname;
  var lastname;
  var email;
  var phone;
  @override
  initState() {
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
  }

  var value;

  @override
  void dispose() {
    myfirstnameController.dispose();
    mylastnameController.dispose();
    myemailController.dispose();
    myphoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30.0, left: 1.0, right:1.0),
          child: Card(
            color: Color.fromARGB(255, 43, 56, 97),
            child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is ProfileLoading) {
                return ListTile(
                  title: Text("Hi!",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("Edit Profile >",
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onTap: () {},
                );
              } else if (state is ProfileLoaded) {
                return ListTile(
                  title: Text("Hi ${state.profileData['first name']}!",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("Edit Profile >",
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onTap: () {
                    splashColor:
                    Color.fromARGB(255, 48, 48, 48);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit_profile(),
                      ),
                    ).then((_) {
                      BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
                    });
                  },
                );
              } else {
                return ListTile(
                  title: Text("Hi!",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text("Edit Profile >",
                      style: TextStyle(color: Colors.white)),
                  trailing: Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  onTap: () {},
                );
              }
            }),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
          child: Card(
            color: Color.fromARGB(255, 123, 121, 121),
            child: ListTile(
              leading: Container(
                  child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              )),
              title: Text("Your Orders", style: TextStyle(color: Colors.white)),
              subtitle: Text("View all yor bookings & purchases",
                  style: TextStyle(color: Colors.white)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                splashColor:
                Color.fromARGB(255, 48, 48, 48);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order_screen(),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
          child: Card(
            color: Color.fromARGB(255, 123, 121, 121),
            child: ListTile(
              leading: Container(
                  child: Icon(
                Icons.settings_outlined,
                color: Colors.white,
              )),
              title: Text("Account & Settings",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("Location, Permissions & More",
                  style: TextStyle(color: Colors.white)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                splashColor:
                Color.fromARGB(255, 48, 48, 48);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Account_Screen(),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
          child: Card(
            color: Color.fromARGB(255, 123, 121, 121),
            child: ListTile(
              leading: Container(
                  child: Icon(
                TablerIcons.discount,
                color: Colors.white,
              )),
              title:
                  Text("Discount Store", style: TextStyle(color: Colors.white)),
              subtitle: Text("Discounts Collection",
                  style: TextStyle(color: Colors.white)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                splashColor:
                Color.fromARGB(255, 48, 48, 48);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Discount_screen(),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
          child: Card(
            color: Color.fromARGB(255, 123, 121, 121),
            child: ListTile(
              leading: Container(
                  child: Icon(
                TablerIcons.gift,
                color: Colors.white,
              )),
              title: Text("Rewards", style: TextStyle(color: Colors.white)),
              subtitle: Text(" ", style: TextStyle(color: Colors.white)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                splashColor:
                Color.fromARGB(255, 48, 48, 48);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reward_screen(),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 1.0),
          child: Card(
            color: Color.fromARGB(255, 123, 121, 121),
            child: ListTile(
              leading: Container(
                  child: Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
              )),
              title: Text("Offers", style: TextStyle(color: Colors.white)),
              subtitle: Text("  ", style: TextStyle(color: Colors.white)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onTap: () {
                splashColor:
                Color.fromARGB(255, 48, 48, 48);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Offer_screen(),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Image.asset("assets/images/cinema.webp"),
        )
      ],
    ));
    // },
    //);
  }
}
