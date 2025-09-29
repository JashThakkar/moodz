import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => MoodModel(), child: MyApp()),
  );
}

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = '🤪';
  String get currentMood => _currentMood;
  int hapCounter = 1;
  int sadCounter = 0;
  int exCounter = 0;
  List histList = ["🤪"];

  MaterialColor bgColor = Colors.yellow;
  void setHappy() {
    _currentMood = '🤪';
    histList.add(_currentMood);
    if (histList.length == 4){
      histList.removeAt(0);
    }
    bgColor = Colors.yellow;
    hapCounter = hapCounter + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = '😿';
    histList.add(_currentMood);
    if (histList.length == 4){
      histList.removeAt(0);
    }
    bgColor = Colors.blue;
    sadCounter = sadCounter + 1;

    notifyListeners();
  }

  void setExcited() {
    _currentMood = '🥳';
    histList.add(_currentMood);
    if (histList.length == 4){
      histList.removeAt(0);
    }
    bgColor = Colors.orange;
    exCounter = exCounter + 1;

    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood Toggle Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('How are you feeling?', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            MoodDisplay(),
            SizedBox(height: 50),
            MoodButtons(),
            SizedBox(height: 50),
            MoodCounter(),
            SizedBox(height: 50),
            MoodHist(),
          ],
        ),
      ),
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Container(
          color: moodModel.bgColor,
          alignment: Alignment.center,
          child: Text(
            moodModel.currentMood,
            style: TextStyle(fontSize: 100),
          ),
        );
      },
    );
  }
}


// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: Text('🤪'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: Text('😿'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: Text('🥳'),
        ),
      ],
    );
  }
}
class MoodCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        Text(moodModel.hapCounter.toString()),
        Text(moodModel.sadCounter.toString()),
        Text(moodModel.exCounter.toString())
      ],
        );
      },
    );
  }
}

class MoodHist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < moodModel.histList.length; i++) 
              Text(moodModel.histList[i]),
          ],
        );
      },
    );
  }
}
