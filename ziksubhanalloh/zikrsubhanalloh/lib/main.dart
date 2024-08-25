import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    ));

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final player = AudioPlayer();

  int subhanallahCount = 0;
  int alhamdulillahCount = 0;
  int allahuAkbarCount = 0;
  int laIlahaIllallahCount = 0;

  int subhanallahTotal = 0;
  int alhamdulillahTotal = 0;
  int allahuAkbarTotal = 0;
  int laIlahaIllallahTotal = 0;

  @override
  void initState() {
    super.initState();
    _loadCounts(); // Zikrlar sonini yuklash
  }

  Future<void> _loadCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      subhanallahCount = prefs.getInt('subhanallahCount') ?? 0;
      alhamdulillahCount = prefs.getInt('alhamdulillahCount') ?? 0;
      allahuAkbarCount = prefs.getInt('allahuAkbarCount') ?? 0;
      laIlahaIllallahCount = prefs.getInt('laIlahaIllallahCount') ?? 0;

      subhanallahTotal = prefs.getInt('subhanallahTotal') ?? 0;
      alhamdulillahTotal = prefs.getInt('alhamdulillahTotal') ?? 0;
      allahuAkbarTotal = prefs.getInt('allahuAkbarTotal') ?? 0;
      laIlahaIllallahTotal = prefs.getInt('laIlahaIllallahTotal') ?? 0;
    });
  }

  Future<void> _saveCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('subhanallahCount', subhanallahCount);
    prefs.setInt('alhamdulillahCount', alhamdulillahCount);
    prefs.setInt('allahuAkbarCount', allahuAkbarCount);
    prefs.setInt('laIlahaIllallahCount', laIlahaIllallahCount);

    prefs.setInt('subhanallahTotal', subhanallahTotal);
    prefs.setInt('alhamdulillahTotal', alhamdulillahTotal);
    prefs.setInt('allahuAkbarTotal', allahuAkbarTotal);
    prefs.setInt('laIlahaIllallahTotal', laIlahaIllallahTotal);
  }

  void _incrementCount(String zikr) {
    setState(() {
      if (zikr == "Subhanallah") {
        subhanallahCount++;
        if (subhanallahCount == 33) {
          subhanallahTotal += 33;
          subhanallahCount = 0;
        }
      } else if (zikr == "Alhamdulillah") {
        alhamdulillahCount++;
        if (alhamdulillahCount == 33) {
          alhamdulillahTotal += 33;
          alhamdulillahCount = 0;
        }
      } else if (zikr == "Allahu Akbar") {
        allahuAkbarCount++;
        if (allahuAkbarCount == 33) {
          allahuAkbarTotal += 33;
          allahuAkbarCount = 0;
        }
      } else if (zikr == "La ilaha illalloh") {
        laIlahaIllallahCount++;
        if (laIlahaIllallahCount == 33) {
          laIlahaIllallahTotal += 33;
          laIlahaIllallahCount = 0;
        }
      }
      _saveCounts(); // Ma'lumotni saqlash
      player.play(AssetSource('botton.mp3'));
    });
  }

  void _resetCount(String zikr) {
    setState(() {
      if (zikr == "Subhanallah") {
        subhanallahCount = 0;
      } else if (zikr == "Alhamdulillah") {
        alhamdulillahCount = 0;
      } else if (zikr == "Allahu Akbar") {
        allahuAkbarCount = 0;
      } else if (zikr == "La ilaha illalloh") {
        laIlahaIllallahCount = 0;
      }
      _saveCounts(); // Ma'lumotni saqlash
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 38, 1),
        title: const Text(
          "Saved Zikr",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 700,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/art.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 270),
                child: Column(
                  children: [
                    buildDhikrContainer("Subhanallah", subhanallahCount, subhanallahTotal),
                    const SizedBox(height: 20),
                    buildDhikrContainer("Alhamdulillah", alhamdulillahCount, alhamdulillahTotal),
                    const SizedBox(height: 20),
                    buildDhikrContainer("Allahu Akbar", allahuAkbarCount, allahuAkbarTotal),
                    const SizedBox(height: 20),
                    buildDhikrContainer("La ilaha illalloh", laIlahaIllallahCount, laIlahaIllallahTotal),
                    SizedBox(height: 10,),
                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDhikrContainer(String dhikr, int count, int total) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 121, 115, 106),
        border: Border.all(
          color: Color.fromARGB(255, 168, 157, 59),
          width: 5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dhikr,
              style: const TextStyle(
                color: Color.fromARGB(255, 250, 250, 247),
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(
                  '$count / $total',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _incrementCount(dhikr);
                  },
                  icon: const Icon(Icons.add, color: Color.fromARGB(255, 255, 253, 253)),
                ),
                IconButton(
                  onPressed: () {
                    _resetCount(dhikr);
                  },
                  icon: const Icon(Icons.cancel, color: Color.fromARGB(255, 227, 223, 223)),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
