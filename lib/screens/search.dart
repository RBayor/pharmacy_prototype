import 'package:flutter/material.dart';
import 'package:pharmacy_prototype/screens/reuseable.dart';


class MedicationSearch extends StatefulWidget{

  _State createState() => new _State();
}

class _State extends State<MedicationSearch> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new MyAppBar(),
      drawer: new MyDrawer(),
    );
  }}