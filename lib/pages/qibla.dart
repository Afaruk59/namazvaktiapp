import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:namaz_vakti_app/change_settings.dart';
import 'package:namaz_vakti_app/time_data.dart';
import 'package:provider/provider.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class Qibla extends StatelessWidget {
  const Qibla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kıble'),
      ),
      body: const QiblaCard(),
    );
  }
}

class QiblaCard extends StatefulWidget {
  const QiblaCard({super.key});

  @override
  State<QiblaCard> createState() => _QiblaCardState();
}

class _QiblaCardState extends State<QiblaCard> {
  static double? _direction = 0;
  static double? _target = 0;
  static double? _targetDir = 0;

  @override
  void initState() {
    super.initState();
    loadTarget();
    FlutterCompass.events!.listen((event) {
      if (mounted) {
        setState(() {
          _direction = event.heading;
          _targetDir = event.heading! - _target!;
        });
      }
    });
  }

  Future<void> loadTarget() async {
    String url =
        'https://www.namazvakti.com/XML.php?cityID=${ChangeSettings.cityID}'; // Çevrimiçi XML dosyasının URL'si

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = response.body;
      final document = xml.XmlDocument.parse(data);

      final cityinfo = document.findAllElements('cityinfo').first;

      _target = double.parse(cityinfo.getAttribute('qiblaangle')!);
      if (_target! > 180) {
        _target = (_target! + 180) * -1;
      }
    }
  }

  Widget _buildCompass() {
    if (_direction == null) {
      return const Text('Yön verisi bekleniyor...');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildDirectionText(),
                ],
              ),
            ],
          ),
        ),
        Stack(
          children: [
            Center(
              child: Transform.rotate(
                angle: ((_direction ?? 0) * (3.14159265358979323846 / 180) * -1),
                child: Image.asset('assets/img/compass.png'),
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: ((_targetDir ?? 0) * (3.14159265358979323846 / 180) * -1),
                child: Image.asset('assets/img/target.png'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDirectionText() {
    if (_direction! < _target! + 3 && _direction! > _target! - 3) {
      return SizedBox(
        height: 100,
        child: Image.asset('assets/img/qibla.png'),
      );
    } else {
      return Container(
        height: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: Center(
                          child: _buildCompass(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.grey, // Kenar rengini belirleyin
                                      width: 1.0, // Kenar kalınlığını belirleyin
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Kenarların yuvarlaklığını belirleyin
                                  ),
                                  color: Theme.of(context).cardColor,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        Provider.of<TimeData>(context).city!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 60,
                                        child: Divider(
                                          height: 15.0,
                                        ),
                                      ),
                                      Text(
                                        Provider.of<TimeData>(context).cityState!,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.grey, // Kenar rengini belirleyin
                                      width: 1.0, // Kenar kalınlığını belirleyin
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Kenarların yuvarlaklığını belirleyin
                                  ),
                                  color: Theme.of(context).cardColor,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${'Hedef:'} ${_target! < 0 ? (360 + _target!).toStringAsFixed(2) : _target!.toStringAsFixed(2)}°',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          '${_direction! < 0 ? (360 + _direction!).toStringAsFixed(2) : _direction!.toStringAsFixed(2)}°',
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
