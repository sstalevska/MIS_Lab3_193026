
//import 'dart:html';

import 'package:app_termini_za_kolokviumi/Model/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/nanoid.dart';

class NovElement extends StatefulWidget{

  final Function addItem;

  NovElement(this.addItem);

  @override
  State<StatefulWidget> createState() => _NovElementState();


}

class _NovElementState extends State<NovElement>{

  final _courseNameController = TextEditingController();
  final _timeController = TextEditingController();

  String courseName ="";
  DateTime time = DateTime.now();

  void _submitData(){
    if(_timeController.text.isEmpty){
      return;
    }
    final thisCourseName = _courseNameController.text;
    final thisTime = time;

    if(courseName.isEmpty ){
      return;
    }
   final newItem = ListItem(id: nanoid(5), courseName: thisCourseName, time: thisTime);
    widget.addItem(newItem);
    Navigator.of(context).pop();
  }

  ///////////////////////

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      time = value!;
    });
  }

  void _showTimePicker() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    ).then((value) => {
      time = new DateTime(time.year, time.month, time.day, value!.hour, value.minute)
    });
  }

  ////////////////////


  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(8),
      child: Column(children: [
        TextField(
          controller: _courseNameController,
          decoration: InputDecoration(labelText: "Ime na predmetot"),

          onSubmitted: (_) => _submitData(),
        ),
        TextField(
          controller: _timeController,
          decoration: InputDecoration(labelText: "Vnesi datum na ispitot",),
          onSubmitted: (_) => _submitData(),
          onTap: _showDatePicker,
        ),
        TextField(
          controller: _timeController,
          decoration: InputDecoration(labelText: "Vnesi  vreme na ispitot"),
          onSubmitted: (_) => _submitData(),
          onTap: _showTimePicker,
        ),
        TextButton(
          child: Text("Add"),
          onPressed: _submitData,
        ),
      ],
      ),
    );
  }
  
}