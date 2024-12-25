import 'dart:async';
import 'package:flutter/material.dart';
import 'package:namaz_vakti_app/pages/qibla.dart';
import 'package:namaz_vakti_app/pages/settings.dart';
import 'package:namaz_vakti_app/pages/timesPage/times.dart';
import 'package:provider/provider.dart';
import 'package:namaz_vakti_app/change_settings.dart';

//GEÇİŞLİ ARKAPLAN WİDGETİ

class GradientBack extends StatelessWidget {
  const GradientBack({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Provider.of<ChangeSettings>(context).isDark == false
                ? Provider.of<ChangeSettings>(context).color.shade300
                : Provider.of<ChangeSettings>(context).color.shade800,
            Theme.of(context).colorScheme.surfaceContainer,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.01, 0.6],
        ),
      ),
      child: child,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return GradientBack(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        //SAYFALARIN KAYRIRILMASINI SAĞLAYAN WİDGET
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: const [
            Times(),
            Qibla(),
            Settings(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
            // Sayfalar arası geçişi PageView ile kontrol et
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          },
          //NAVIGATION BAR ELEMANLARI
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.schedule),
              icon: Icon(Icons.schedule),
              label: 'Vakitler',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.navigation),
              icon: Icon(Icons.navigation_outlined),
              label: 'Kıble',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Ayarlar',
            ),
          ],
        ),
      ),
    );
  }
}
