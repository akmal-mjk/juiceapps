import 'package:flutter/material.dart';
import 'package:juiceapps/pages/product/homescreen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 40),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 241, 126, 12),
            image: DecorationImage(
              image: AssetImage('images/bg.png'),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Merasa Haus? Juice aja!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
            const SizedBox(height: 90),
            Material(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const productPages(),
                      ));
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    child: const Text(
                      "Mulai Aplikasi",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
