import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  // Future<DocumentSnapshot> trazerValor() async {
  //   return FirebaseFirestore.instance
  //       .collection('teste')
  //       .doc('c9gHHmwo3zbz6hQoYoFy')
  //       .get();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network('https://firebasestorage.googleapis.com/v0/b/restaurants-bars.appspot.com/o/poc_cover.png?alt=media&token=1987be43-2683-4d40-af16-482ec069b0bc'),
      ),
    );
  }
}
