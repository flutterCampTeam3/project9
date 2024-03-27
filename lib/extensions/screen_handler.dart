import 'package:flutter/material.dart';

extension Screen on BuildContext {
  getWidth() {
    return MediaQuery.of(this).size.width;
  }

  push({required Widget view, required bool isPush}) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => view),
      (route) => isPush,
    );
  }

  getHeight() {
    return MediaQuery.of(this).size.height;
  }

  getMessagesBar({required String msg, required Color color}) {
    return ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            msg,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  // showSuccessSnackBar(
  //   BuildContext context,
  //   String msg,
  // ) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //     content: Text(
  //       msg,
  //       style: const TextStyle(
  //         color: Colors.white,
  //       ),
  //     ),
  //     backgroundColor: Colors.green,
  //   ));
  // }

  // showErrorSnackBar(
  //   BuildContext context,
  //   String msg,
  // ) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //     dismissDirection: DismissDirection.up,
  //     behavior: SnackBarBehavior.floating,
  //     margin: EdgeInsets.only(
  //         bottom: MediaQuery.of(context).size.height - 150,
  //         left: 10,
  //         right: 10),
  //     content: Text(
  //       msg,
  //       style: const TextStyle(
  //         color: Colors.white,
  //       ),
  //     ),
  //     backgroundColor: Colors.red,
  //   ));
  // }

  getMessages({required String msg, required Color color, int duration = 3}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: duration), () {
          Navigator.of(context).canPop();
        });

        return AlertDialog(
          backgroundColor: color,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              msg,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
