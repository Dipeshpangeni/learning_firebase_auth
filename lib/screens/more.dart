import 'package:database_demo/screens/company_homescreen.dart';
import 'package:flutter/material.dart';
class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>CompanyHomescreen()));},
          child: Container(
            height: 300,
            width: 300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}