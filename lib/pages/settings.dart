import 'package:flutter/material.dart';
import 'package:namaz_vakti_app/main.dart';
import 'package:provider/provider.dart';
import 'package:namaz_vakti_app/change_settings.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
      ),
      body: const SettingsCard(),
    );
  }
}

class SettingsCard extends StatelessWidget {
  static Locale? preLang;
  const SettingsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    preLang = Provider.of<ChangeSettings>(context).locale;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(MainApp.currentHeight! < 700.0 ? 5.0 : 15.0),
          child: Column(
            children: [
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SwitchListTile(
                    title: const Text('Koyu Tema'),
                    value: Provider.of<ChangeSettings>(context).isDark,
                    onChanged: (_) =>
                        Provider.of<ChangeSettings>(context, listen: false).toggleTheme(),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SwitchListTile(
                    title: const Text('Geçişli Arka Plan'),
                    value: Provider.of<ChangeSettings>(context).gradient,
                    onChanged: (_) =>
                        Provider.of<ChangeSettings>(context, listen: false).toggleGrad(),
                  ),
                ),
              ),
              Card(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListTile(
                    title: const Text('Tema Rengi'),
                    trailing: FilledButton.tonal(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Renk Seçimi'),
                            content: const SizedBox(
                              height: 200,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ColorCircle(col: Colors.blueGrey),
                                        ColorCircle(col: Colors.red),
                                        ColorCircle(col: Colors.blue),
                                        ColorCircle(col: Colors.green),
                                        ColorCircle(col: Colors.yellow),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ColorCircle(col: Colors.amber),
                                        ColorCircle(col: Colors.grey),
                                        ColorCircle(col: Colors.indigo),
                                        ColorCircle(col: Colors.lightBlue),
                                        ColorCircle(col: Colors.lightGreen),
                                        ColorCircle(col: Colors.lime),
                                        ColorCircle(col: Colors.orange),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        ColorCircle(col: Colors.pink),
                                        ColorCircle(col: Colors.purple),
                                        ColorCircle(col: Colors.teal),
                                        ColorCircle(col: Colors.brown),
                                        ColorCircle(col: Colors.cyan),
                                        ColorCircle(col: Colors.deepOrange),
                                        ColorCircle(col: Colors.deepPurple),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Tamam'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(Icons.color_lens),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  const ColorCircle({super.key, required this.col});
  final MaterialColor col;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: const CircleBorder(),
        color: col,
        child: TextButton(
          child: Container(),
          onPressed: () {
            Provider.of<ChangeSettings>(context, listen: false).changeCol(col);
            Provider.of<ChangeSettings>(context, listen: false).saveCol(col);
          },
        ),
      ),
    );
  }
}
