import 'package:flutter/material.dart';

import '../models/company.dart';
import '../services/firebase_db_services.dart';
// import '../services/person_services.dart';
// import '../models/person.dart';

class PersonAddScreen extends StatefulWidget {
  final Company? person;
  const PersonAddScreen({super.key, this.person});

  @override
  State<PersonAddScreen> createState() => _PersonAddScreenState();
}

class _PersonAddScreenState extends State<PersonAddScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.person != null) {
      _idController.text = widget.person!.id.toString();
      _nameController.text = widget.person!.name?? 'No name given';
      _addressController.text = widget.person!.address ?? 'No address given';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add a person'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'enter the id of person',
                    label: Text('id')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'enter the name of person',
                    label: Text('name')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'enter the address of person',
                    label: Text('address')),
              ),
            ),
            widget.person != null
                ? ElevatedButton(
                    onPressed: () async {
                     Company company = Company(
                          id: (_idController.text),
                          name: _nameController.text,
                          address: _addressController.text);

                      await FirebaseDbServices ().editCompany();
                      Navigator.pop(context);                                                                                                                                                                                    
                    },
                    child: Text('Edit person'))
                : ElevatedButton(
                    onPressed: () async {
                    Company company =Company(
                          id: (_idController.text),                                                                               
                          name: _nameController.text,
                          address: _addressController.text);

                      await FirebaseDbServices ().addCompany();
                      Navigator.pop(context);                                                                                                                                                                                                                         
                    },
                    child: Text('Add a person'))
          ],
        ),
      ),
    );
  }
}