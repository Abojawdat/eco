import 'package:flutter/material.dart';
import '../resposive_screen.dart'; // your responsive helper

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ecomerce"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text("WELLCOME!  .."),
            const SizedBox(height: 10),

            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: responsive.wp(90),
                height: responsive.hp(20),
                // ← Row places text and image side-by-side
                child: Row(
                  children: [
                    // Text area (left)
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SHOP THE",
                            style: TextStyle(
                              fontSize: responsive.sp(6),
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "NEW PRODUCT",
                            style: TextStyle(
                              fontSize: responsive.sp(5),
                              fontFamily: "Cairo",
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: responsive.wp(2)), // spacing

                    // Image area (right)
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/elctric.png', // <-- your asset path
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover, // use cover or contain as you prefer
                          semanticLabel: 'Product image',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
