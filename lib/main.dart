import 'package:flutter/material.dart';
import 'dart:math';

void main () => runApp(const RandomSelector());

class RandomSelector extends StatelessWidget {
  const RandomSelector({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return const MaterialApp(
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState () {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  List<String> names = [
    "Wesley",
    "Derek",
    "Julian",
    "Tristan"
  ];

  TextEditingController nameController = TextEditingController();

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Random Name Selector",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
            fontWeight: FontWeight.w900
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      names.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(names[index]),
                  ),
                );
              }
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    "Add new name",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Row(
                    children: <Widget>[
                       Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10,bottom: 10),
                            isDense: true
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: const Text("Add"),
                        onPressed: () {
                          addToList();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) => ElevatedButton(
                      child: const Text("Get Random Name"),
                      onPressed: () {
                        var random = Random();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Random name is: " + names[random.nextInt(names.length)]))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToList () {
    if (nameController.text.isNotEmpty) {
      setState(() {
        names.add(nameController.text);
      });
    }
  }
}