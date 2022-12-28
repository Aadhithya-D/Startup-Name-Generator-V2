import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class StartUpName extends StatefulWidget {
  const StartUpName({super.key});

  @override
  StartUpNameState createState() => StartUpNameState();
}

class StartUpNameState extends State<StartUpName> {
  final _randomWordPair = <WordPair>[];
  final _savedWordPair = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (context, item) {
        int index = (item + 1) * 3 - 1;
        if (index >= _randomWordPair.length) {
          _randomWordPair.addAll(generateWordPairs().take(10));
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: InkWell(
                    child: Square(_randomWordPair[index - 2]),
                    onTap: () {
                      pushNext(_randomWordPair[index - 2]);
                    })),
            Expanded(
                child: InkWell(
                  child: Square(_randomWordPair[index - 1]),
                  onTap: () {
                    pushNext(_randomWordPair[index - 1]);
                  },
                )),
            Expanded(
                child: InkWell(
                  child: Square(_randomWordPair[index]),
                  onTap: () {
                    pushNext(_randomWordPair[index]);
                  },
                ))
          ],
        );
      },
    );
  }

  void pushNext(WordPair pair) {
    final alreadySaved = _savedWordPair.contains(pair);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.deepOrange[400],
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 60.0,
            title: const Text("Startup Name"),
          ),
          body: Column(children: <Widget>[
            Expanded(
              flex: 3,
            child: Center(child: Text(
              pair.asPascalCase,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          )),
            Expanded(
              flex: 2,
                child: IconButton(
            icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.white : Colors.white, size: 30,),
              onPressed: () {
              setState(() {
                if (alreadySaved) {
                  _savedWordPair.remove(pair);
                  Navigator.pop(context);
                  pushNext(pair);
                } else {
                  _savedWordPair.add(pair);
                  Navigator.pop(context);
                  pushNext(pair);
                }
              });
            },))
          ]));
    }));
  }

  void pushNext1(WordPair pair) {
    final alreadySaved = _savedWordPair.contains(pair);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return WillPopScope(onWillPop: ()async{
        print("Pressed back");
        Navigator.pop(context);
        pushSaved();
        return true;
      }, child: Scaffold(
          backgroundColor: Colors.deepOrange[400],
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 60.0,
            title: const Text("Startup Name"),
          ),
          body: Column(children: <Widget>[
            Expanded(
                flex: 3,
                child: Center(child: Text(
                  pair.asPascalCase,
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
                )),
            Expanded(
                flex: 2,
                child: IconButton(
                  icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: alreadySaved ? Colors.white : Colors.white, size: 30,),
                  onPressed: () {
                    setState(() {
                      if (alreadySaved) {
                        _savedWordPair.remove(pair);
                        Navigator.pop(context);
                        pushNext1(pair);
                      } else {
                        _savedWordPair.add(pair);
                        Navigator.pop(context);
                        pushNext1(pair);
                      }
                    });
                  },))
          ])));
    }));
  }
  void pushSaved(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Saved Startup Names"),
          centerTitle: true,
          toolbarHeight: 60.0,
        ),
        body: ListView.builder(itemCount: _savedWordPair.length,
            itemBuilder: (context, item){
          int index = item;
          return Expanded(
              child: InkWell(child: Square(_savedWordPair.elementAt(index)),onTap: () {
                Navigator.pop(context);
                pushNext1(_savedWordPair.elementAt(index));
                // pushSaved();
              }));
        }),
      );
    }));
  }
  Widget Square(WordPair pair) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: BorderRadius.circular(8),
          ),
          height: 150,
          child: Center(
            child: Text(
              pair.asPascalCase,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.0,
          title: const Text("Startup Name Generator V2"),
          actions: <Widget>[
            IconButton(onPressed: pushSaved, icon: Icon(Icons.list))
          ],
        ),
        // backgroundColor: Colors.deepOrangeAccent[100],
        body: _buildList());
  }
}
