import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namaz_vakti_app/pages/timesPage/detailed_times.dart';
import 'package:namaz_vakti_app/pages/timesPage/location.dart';
import 'package:namaz_vakti_app/change_settings.dart';
import 'package:namaz_vakti_app/time_data.dart';
import 'package:provider/provider.dart';
import 'package:hijri/hijri_calendar.dart';

class Times extends StatelessWidget {
  const Times({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Vakitler'),
      ),
      body: const TimesBody(),
    );
  }
}

class TimesBody extends StatefulWidget {
  const TimesBody({super.key});

  @override
  State<TimesBody> createState() => _TimesBodyState();
}

class _TimesBodyState extends State<TimesBody> {
  String miladi = '';
  String hicri = '';
  int count = 0;
  DateTime customDate = DateTime.now();
  static bool alertOpen = false;

  void _checkWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (alertOpen == false) {
        _showWifiAlert();
        alertOpen = true;
      }
    } else {
      Provider.of<TimeData>(context, listen: false).switchClock(true);
      Provider.of<TimeData>(context, listen: false).loadPrayerTimes(DateTime.now());
    }
  }

  void _showWifiAlert() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('İnternet Bağlantısı Gerekli'),
          content: const Row(
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Text("Devam etmek için lütfen Wi-Fi'yi yada Mobil Veri'yi etkinleştirin."),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Servisler internet olmadan düzgün çalışmayacaktır.'),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.wifi_off,
                  size: 45,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tekrar Dene'),
              onPressed: () {
                Navigator.pop(context);
                alertOpen = false;
                _checkWifi();
              },
            ),
          ],
        ),
      ),
    );
  }

//DATE PICKER İLE İSTENİLEN TARİHİ SEÇME
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 1, 1),
      lastDate: DateTime(DateTime.now().year, 12, 31),
    );

    if (pickedDate != null && pickedDate != customDate) {
      setState(() {
        customDate = pickedDate;
      });
    }
  }

  //AÇILIŞTA İLK OLARAK O GÜNÜN TARİHİNİ ALMA
  @override
  void initState() {
    super.initState();
    _checkWifi();
    miladi = DateFormat('dd MMMM yyyy', 'tr').format(DateTime.now().add(Duration(days: count)));
    hicri = HijriCalendar.fromDate(DateTime.now().add(Duration(days: count + 1)))
        .toFormat('dd MMMM yy');
    Provider.of<TimeData>(context, listen: false).changeTime(miladi);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Card(
                          child: Center(
                            child: Stack(
                              children: [
                                //TARİHİ SEÇEN BUTON
                                Center(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor:
                                            Theme.of(context).textTheme.displayMedium!.color),
                                    onPressed: () async {
                                      var now = DateTime.now();
                                      await _selectDate(context);
                                      Provider.of<TimeData>(context, listen: false)
                                          .switchLoading(true);
                                      setState(() {
                                        count = customDate
                                            .difference(
                                                DateTime(now.year, now.month, now.day, 00, 00))
                                            .inDays;
                                        if (count != 0) {
                                          Provider.of<TimeData>(context, listen: false)
                                              .switchClock(false);
                                        } else {
                                          Provider.of<TimeData>(context, listen: false)
                                              .switchClock(true);
                                        }
                                        miladi = DateFormat('dd MMMM yyyy', 'tr')
                                            .format(DateTime.now().add(Duration(days: count)));
                                        hicri = HijriCalendar.fromDate(
                                                DateTime.now().add(Duration(days: count)))
                                            .toFormat('dd MMMM yy');
                                      });
                                      Provider.of<TimeData>(context, listen: false).loadPrayerTimes(
                                          DateTime.now().add(Duration(days: count)));
                                      Provider.of<TimeData>(context, listen: false)
                                          .changeTime(miladi);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          miladi,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //BİR ÖNCEKİ GÜNE GEÇME
                                        IconButton(
                                          onPressed: () {
                                            Provider.of<TimeData>(context, listen: false)
                                                .switchLoading(true);
                                            setState(() {
                                              count--;
                                              if (count != 0) {
                                                Provider.of<TimeData>(context, listen: false)
                                                    .switchClock(false);
                                              } else {
                                                Provider.of<TimeData>(context, listen: false)
                                                    .switchClock(true);
                                              }
                                              miladi = DateFormat('dd MMMM yyyy', 'tr').format(
                                                  DateTime.now().add(Duration(days: count)));
                                              hicri = HijriCalendar.fromDate(
                                                      DateTime.now().add(Duration(days: count)))
                                                  .toFormat('dd MMMM yy');
                                            });
                                            Provider.of<TimeData>(context, listen: false)
                                                .loadPrayerTimes(
                                                    DateTime.now().add(Duration(days: count)));
                                            Provider.of<TimeData>(context, listen: false)
                                                .changeTime(miladi);
                                          },
                                          icon: const Icon(Icons.arrow_back_ios_new),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //BİR SONRAKİ GUNE GEÇME
                                        IconButton(
                                          onPressed: () {
                                            Provider.of<TimeData>(context, listen: false)
                                                .switchLoading(true);
                                            setState(() {
                                              count++;
                                              if (count != 0) {
                                                Provider.of<TimeData>(context, listen: false)
                                                    .switchClock(false);
                                              } else {
                                                Provider.of<TimeData>(context, listen: false)
                                                    .switchClock(true);
                                              }
                                              miladi = DateFormat('dd MMMM yyyy', 'tr').format(
                                                  DateTime.now().add(Duration(days: count)));
                                              hicri = HijriCalendar.fromDate(
                                                      DateTime.now().add(Duration(days: count)))
                                                  .toFormat('dd MMMM yy');
                                            });
                                            Provider.of<TimeData>(context, listen: false)
                                                .loadPrayerTimes(
                                                    DateTime.now().add(Duration(days: count)));
                                            Provider.of<TimeData>(context, listen: false)
                                                .changeTime(miladi);
                                          },
                                          icon: const Icon(Icons.arrow_forward_ios),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //HİCRİ TAKVİM
                      Expanded(
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  hicri,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //KONUM ARAMA BUTONU
                      const Expanded(
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                              child: Location(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //KONUM İSMİ YAZAN KISIM
                const Expanded(
                  child: Card(
                    child: Center(
                      child: CityNameCard(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //VAKİTLERİN OLDUĞU KISIM
          const Expanded(
            flex: 11,
            child: Card(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      PrayerTimesPage(),
                      DetailedTimesBtn(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//AYARLARDAN KONUM İSMİ BİLGİSİNİ ALIR VE EKRANA YAZAR
class CityNameCard extends StatefulWidget {
  const CityNameCard({super.key});

  @override
  State<CityNameCard> createState() => _CityNameCardState();
}

class _CityNameCardState extends State<CityNameCard> {
  static String? cityName;
  @override
  void initState() {
    super.initState();
    cityName = ChangeSettings.cityName;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TimeData>(context).cityState = ChangeSettings.cityState;
    Provider.of<TimeData>(context).city = ChangeSettings.cityName;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${Provider.of<TimeData>(context).cityState}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            width: 100.0,
            child: Divider(
              height: 20.0,
            ),
          ),
          Text(
            '$cityName',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

//VAKİTLERİN OLDUĞU KART
class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  PrayerTimesPageState createState() => PrayerTimesPageState();
}

class PrayerTimesPageState extends State<PrayerTimesPage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Provider.of<TimeData>(context).isLoading
          ? const Center(child: CircularProgressIndicator())
          : const MainTimes(),
    );
  }
}

//ANA VAKİTLER (TİMEDATA CLASSINDAN ÇEKER)
class MainTimes extends StatelessWidget {
  const MainTimes({
    super.key,
  });

  static TextStyle timeStyle = const TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey, // Kenar rengini belirleyin
                        width: 1.0, // Kenar kalınlığını belirleyin
                      ),
                      borderRadius:
                          BorderRadius.circular(10.0), // Kenarların yuvarlaklığını belirleyin
                    ),
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'İmsak',
                          style: timeStyle,
                        ),
                        Text(
                          'Sabah',
                          style: timeStyle,
                        ),
                        Text(
                          'Güneş',
                          style: timeStyle,
                        ),
                        Text(
                          'Öğle',
                          style: timeStyle,
                        ),
                        Text(
                          'İkindi',
                          style: timeStyle,
                        ),
                        Text(
                          'Akşam',
                          style: timeStyle,
                        ),
                        Text(
                          'Yatsi',
                          style: timeStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey, // Kenar rengini belirleyin
                        width: 1.0, // Kenar kalınlığını belirleyin
                      ),
                      borderRadius:
                          BorderRadius.circular(10.0), // Kenarların yuvarlaklığını belirleyin
                    ),
                    color: Theme.of(context).cardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).imsak ?? DateTime.now()),
                          style: timeStyle,
                        ),
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).sabah ?? DateTime.now()),
                          style: timeStyle,
                        ),
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).gunes ?? DateTime.now()),
                          style: timeStyle,
                        ),
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).ogle ?? DateTime.now()),
                          style: timeStyle,
                        ),
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).ikindi ?? DateTime.now()),
                          style: timeStyle,
                        ),
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).aksam ?? DateTime.now()),
                          style: timeStyle,
                        ),
                        Text(
                          DateFormat('HH:mm')
                              .format(Provider.of<TimeData>(context).yatsi ?? DateTime.now()),
                          style: timeStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            flex: 1,
            child: Clock(),
          ),
        ],
      ),
    );
  }
}

//GERİ SAYAN KISIM (TİMEDATA CLASSINDAKİ UPDATETİME FONKSİYONUNU KULLANIR)
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        if (DateTime.now().hour == 00 &&
            DateTime.now().minute == 00 &&
            DateTime.now().second == 01) {
          Navigator.popAndPushNamed(context, '/');
        }
        Provider.of<TimeData>(context, listen: false).updateTime();
      }
    });
  }

  final List<String> _prayList = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    _prayList[0] = 'İmsaka Kalan';
    _prayList[1] = 'Sabaha Kalan';
    _prayList[2] = 'Güneşe Kalan';
    _prayList[3] = 'Öğleye Kalan';
    _prayList[4] = 'İkindiye Kalan';
    _prayList[5] = 'Akşama Kalan';
    _prayList[6] = 'Yatsıya Kalan';
    _prayList[7] = 'İmsaka Kalan';
    return Provider.of<TimeData>(context).isEnabled == false
        ? IconButton.filledTonal(
            iconSize: 25,
            style: IconButton.styleFrom(shape: const CircleBorder()),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: const Icon(Icons.replay_outlined),
          )
        : Padding(
            padding: const EdgeInsets.fromLTRB(60, 5, 60, 5),
            child: SizedBox(
              height: 55,
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25), // Gölge rengi ve opaklığı
                          spreadRadius: 5, // Gölgenin yayılma alanı
                          blurRadius: 10, // Gölgenin bulanıklığı
                          offset: const Offset(0, 5), // Gölgenin yatay ve dikey kayması
                        ),
                      ],
                    ),
                    child: LinearProgressIndicator(
                      value: (Provider.of<TimeData>(context).mainDifference.inSeconds -
                              Provider.of<TimeData>(context).difference.inSeconds) /
                          Provider.of<TimeData>(context).mainDifference.inSeconds,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Theme.of(context).cardColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).cardTheme.color!),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              _prayList[Provider.of<TimeData>(context).pray],
                              style: const TextStyle(fontSize: 17.0),
                            ),
                            Provider.of<TimeData>(context).imsak != null
                                ? Text(
                                    '${(Provider.of<TimeData>(context).difference.inHours).toString().padLeft(2, '0')} : ${(Provider.of<TimeData>(context).difference.inMinutes % 60).toString().padLeft(2, '0')} : ${(Provider.of<TimeData>(context).difference.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                        fontSize: 17.0, fontWeight: FontWeight.bold),
                                  )
                                : const Text('0'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
