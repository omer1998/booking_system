import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_widgets/doctor_card.dart';
import 'main_widgets/doctor_categories.dart';
import 'main_widgets/doctor_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الصفحه الرئيسيه"),
      ),
      body:  SingleChildScrollView(
        child: Column(children: [
          DoctorCategories(),
          DoctorList()
        ]),
      ),
    );
  }
}

