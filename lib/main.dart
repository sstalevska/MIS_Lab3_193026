import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //ios

import 'Model/list_item.dart';
import 'Widgets/nov_element.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '193026 Lab 3',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ListItem> _userItems = [
    ListItem(id: "C1", courseName: "Mobile information systems", time: DateTime.now()),
  ];

  void _addItemFunction(BuildContext ct){

    showModalBottomSheet(
        context: ct,
        builder: (_){
            return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NovElement(_addNewItemToList)
            );
    });
  }

  void _addNewItemToList(ListItem item){
      setState(() {
        _userItems.add(item);
      });
  }

  void _deleteItem(String id){
    setState(() {
      _userItems.removeWhere((elem) => elem.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Termini za ispiti"),
        actions: [
          IconButton(
              onPressed: () => _addItemFunction(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: _userItems.isEmpty
            ? Text("Nadvor od sesija")
          :ListView.builder(itemBuilder: (ctx, index){
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            child: ListTile(
              title: Text(_userItems[index].courseName,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(

                  "Date: " + _userItems[index].time.day.toString()
                      + "." + _userItems[index].time.month.toString()
                      + "." + _userItems[index].time.year.toString()
                      + "     Time: " + _userItems[index].time.hour.toString()
                      + ":"
                      + _userItems[index].time.minute.toString(),
                  style: TextStyle(color: Colors.grey),

              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteItem(_userItems[index].id),
              ),
            ) ,
          );
        },
          itemCount: _userItems.length,
        ),
      ),
    );
  }
}
