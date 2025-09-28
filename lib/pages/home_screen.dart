import 'package:flutter/material.dart';
import '../resposive_screen.dart'; // import helper file

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    // ✅ initialize responsive helper
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ecomerce"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text("WELLCOME!  .."),
            const SizedBox(height: 10),

            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                width: responsive.wp(90),   // 50% of screen width
                height: responsive.hp(20), // 10% of screen height
                child: Text(
                    "shope\n"
                        "NEW PRODUCT ",
                    style: TextStyle(fontSize: responsive.sp(8),fontFamily: "Cairo"),

                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
