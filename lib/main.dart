import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class RandomEnglishWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomEnglishWordsState();
  }
}

class RandomEnglishWordsState extends State<RandomEnglishWords> {
  final _words = <WordPair>[];
  final _checkedWords = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("List English words"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.list), onPressed: _pushToSavedWordsScreen)
          ],
        ),
        body: new ListView.builder(itemBuilder: (context, index) {
          if (index >= _words.length) {
            _words.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_words[index], index);
        }));
  }

  _pushToSavedWordsScreen() {
    final pageRoute = new MaterialPageRoute(builder: (context) {
      final listTiles = _checkedWords.map((wordPair) {
        return new ListTile(
            title: new Text(
          wordPair.asUpperCase,
          style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ));
      });
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Checked Words"),
        ),
        body: new ListView(
          children: listTiles.toList(), //Lazy List (Iterable) => List
        ),
      );
    });
    Navigator.of(context).push(pageRoute);
  }

  Widget _buildRow(WordPair wordPair, int index) {
    final textcolor = index % 2 == 0 ? Colors.red : Colors.green;
    final isChecked = _checkedWords.contains(wordPair);
    return new ListTile(
      leading: new Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: textcolor,
      ),
      title: new Text(
        wordPair.asUpperCase,
        style: new TextStyle(fontSize: 18.0, color: textcolor),
      ),
      onTap: () {
        setState(() {
          if (isChecked) {
            _checkedWords.remove(wordPair);
          } else {
            _checkedWords.add(wordPair);
          }
        });
      },
    );
  }
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new MaterialApp(
        title: "This my App", home: new RandomEnglishWords());
  }
}
