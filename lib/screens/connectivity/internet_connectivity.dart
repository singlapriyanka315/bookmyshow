import 'package:flutter/material.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionStatusBars extends StatelessWidget {
  const ConnectionStatusBars({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectionStatusBar(
      height: double.infinity,
      title: Text(
        "Internet Connection is Not Found, Please Check Your Internet",
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}