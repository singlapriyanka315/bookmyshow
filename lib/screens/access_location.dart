import 'package:bookmyapp/screens/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

class AccessLocation extends StatefulWidget {
  const AccessLocation({super.key});

  @override
  State<AccessLocation> createState() => _AccessLocationState();
}



class _AccessLocationState extends State<AccessLocation> {
  String? lat, long;
bool _isLoading = false;
Location location = new Location();
  getCurrentLocation() async {
    // try {
    //   LocationPermission permission = await Geolocator.checkPermission();
    //   print("permission");

    //   print(permission);
    //   if (permission == LocationPermission.denied ||
    //       permission == LocationPermission.deniedForever) {
    //     LocationPermission permission1 = await Geolocator.requestPermission();
    //     if (permission1 == LocationPermission.denied ||
    //         permission1 == LocationPermission.deniedForever) {
    //       print("I am in splash1");
    //       return showDialog<String>(
    //           context: context,
    //           barrierDismissible: false,
    //           builder: (BuildContext context) => AlertDialog(
    //                 title: Text(
    //                     "User denied permissions to access the device's location."),
    //                 content: Text(
    //                     "Please go to \"App Permissions\" allow app to access your device's location and restart the app again."),
    //                 actions: <Widget>[
    //                   TextButton(
    //                     child: Text("App Settings"),
    //                     onPressed: () {
    //                       openAppSettings();
    //                       //Navigator.of(context).pop();
    //                     },
    //                   ),
    //                   TextButton(
    //                     child: Text("Ok"),
    //                     onPressed: () {
    //                       SystemChannels.platform
    //                           .invokeMethod('SystemNavigator.pop');
    //                     },
    //                   ),
    //                 ],
    //               ));
    //     }
    //     // return Navigator.pushReplacement(
    //     //     context, MaterialPageRoute(builder: (context) => MainScreen()));
    //   } 
    //   else {
    //     return Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => MainScreen()));
    //   }
    // } 

    // catch (exception) {
    //   print('exception');
    //   print('exception is $exception');
    // }

   var serviceEnabled = await location.serviceEnabled();
   if (!serviceEnabled) {
   serviceEnabled = await location.requestService();
   if (!serviceEnabled) {
     return showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        "User denied permissions to access the device's location."),
                    content: Text(
                        "Please go to \"App Permissions\" allow app to access your device's location and restart the app again."),
                    actions: <Widget>[
                      TextButton(
                        child: Text("App Settings"),
                        onPressed: () {
                          openAppSettings();
                          //Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                      ),
                    ],
                  ));
   }
      else {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }

}
   else {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
  }




  @override
  initState() {
    getCurrentLocation();
    print("I am in accesslocation");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
