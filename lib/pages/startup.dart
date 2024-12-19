import 'package:flutter/material.dart';
import 'package:namaz_vakti_app/home_page.dart';
import 'package:namaz_vakti_app/pages/timesPage/location.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBack(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Hoşgeldiniz'),
          ),
          body: const StartupCard(),
        ),
      ),
    );
  }
}

class StartupCard extends StatelessWidget {
  const StartupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Theme.of(context).cardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logo.png',
                    height: 250,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    //KONUMU BULAN BUTON
                    child: Location(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
