import 'package:database_demo/models/company.dart';
import 'package:database_demo/services/firebase_db_services.dart';
import 'package:flutter/material.dart';


class PersonAddScreen extends StatefulWidget {
  final Company? company;
  const PersonAddScreen({super.key, this.company});

  @override
  State<PersonAddScreen> createState() => _PersonAddScreenState();
}

class _PersonAddScreenState extends State<PersonAddScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _serviceController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

GlobalKey<FormState> _forKey =GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.company != null) {
      _serviceController.text = widget.company!.id.toString();
      _nameController.text = widget.company!.name?? 'No name given';
      _addressController.text = widget.company!.address ?? 'No address given';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('add a person'),
      ),
      body: SingleChildScrollView(
        child: Form(
key: _forKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                  controller: _serviceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // hintText: 'enter the id of person',
                      label: Text('Service')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter the name of person',
                      label: Text('name')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter youe phone number',
                      label: Text('phone number')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter the address of person',
                      label: Text('address')),
                ),
              ),
              widget.company != null
                  ? ElevatedButton(
                      onPressed: () async {
                       Company company = Company(
                            services: [_serviceController.text],
                            name: _nameController.text,                                                                                                         
                            address: _addressController.text,
                            phonenumber: int.tryParse(_phoneController.text)
          
                            );
          
                        await FirebaseDbServices ().editCompany(company);
                        Navigator.pop(context);                                                                                                                                                                                    
                      },
                      child: Text('Edit person'))
                  : ElevatedButton(


                      onPressed: () async {
                      Company company =Company(
                            services: [_serviceController.text],                                                                               
                            name: _nameController.text,
                            address: _addressController.text,
                     phonenumber: int.tryParse(_phoneController.text)
          
                            );  

                            if(widget.company==null)  {
 await FirebaseDbServices ().addCompany(company);
                            }      else{

          company.id =widget.company!.id;
                        await FirebaseDbServices ().editCompany(company);
                            }                                                                                                                                                                                                                                
          
                        Navigator.pop(context);                                                                                                                                                                                                                         
                      },
                      child: Text(widget.company == null? 'Add Company':"ubdate company"))
            ],
          ),
        ),
      ),
    );
  }
}