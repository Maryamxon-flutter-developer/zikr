import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MaterialApp(home: MyWidget()));

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int subhanallahCount = 0;
  int alhamdulillahCount = 0;
  int allahuAkbarCount = 0;
  int laIlahaIllallahCount = 0;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSound(String soundPath) async {
    try {
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 13, 44),
        title: const Text(
          "Saved Dhikr",
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
                  image: NetworkImage(
                    "https://png.pngtree.com/background/20210712/original/pngtree-blue-textured-muslim-background-picture-image_1174819.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                  children: [
                    buildDhikrContainer("Subhanallah", subhanallahCount, () {
                      setState(() {
                        subhanallahCount++;
                      });
                      playSound("assets/botton.mp3");
                    }),
                    const SizedBox(height: 20),
                    buildDhikrContainer("Alhamdulillah", alhamdulillahCount, () {
                      setState(() {
                        alhamdulillahCount++;
                      });
                      playSound("assets/botton.mp3");
                    }),
                    const SizedBox(height: 20),
                    buildDhikrContainer("Allahu Akbar", allahuAkbarCount, () {
                      setState(() {
                        allahuAkbarCount++;
                      });
                      playSound("assets/botton.mp3");
                    }),
                    const SizedBox(height: 20),
                    buildDhikrContainer("La ilaha illalloh", laIlahaIllallahCount, () {
                      setState(() {
                        laIlahaIllallahCount++;
                      });
                      playSound("assets/botton.mp3");
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDhikrContainer(String dhikr, int count, VoidCallback onPressed) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
        border: Border.all(
          color: const Color.fromARGB(255, 125, 117, 46),
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
                color: Color.fromARGB(255, 138, 129, 47),
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
