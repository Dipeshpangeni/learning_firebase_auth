import 'package:database_demo/models/company.dart';
import 'package:database_demo/screens/more.dart';
import 'package:database_demo/services/firebase_db_services.dart';
import 'package:flutter/material.dart';

class CompanyHomescreen extends StatelessWidget {
  const CompanyHomescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Home"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => More()));
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: FutureBuilder(
          future: FirebaseDbServices().getAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error Getting Data"));
            }
            if (snapshot.hasData) {
              List<Company> allCompanies = snapshot.data as List<Company>;
              return ListView.builder(
                  itemCount: allCompanies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: 
                        BoxDecoration(border: Border.all( width: 1, color: Colors.white)),
                        child: ListTile(
                          leading: Text(allCompanies[index].name!,style: TextStyle(fontSize: 17,color: Colors.red),),
                          title: Column(
                            children: [
                              Text(allCompanies[index].services.toString(),style: TextStyle(fontSize: 15,color: const Color.fromARGB(255, 241, 244, 54)),),
                              Divider(color: Colors.teal,),
                              Text(allCompanies[index].establishedAt.toString(),style: TextStyle(fontSize: 15,color: const Color.fromARGB(255, 9, 255, 0)),)
                            ,Divider(height: 7,color: Colors.teal,),

                            ],
                            
                          ),
                          
                          subtitle: Text(allCompanies[index].address!,style: TextStyle(fontSize: 15,color: const Color.fromARGB(255, 0, 255, 242)),),
                          trailing: PopupMenuButton(onSelected: (value) async {
                            if (value == "edit") {
                            } else {
                              await FirebaseDbServices()
                                  .deletCompany(allCompanies[index].id!);
                            }
                          }, itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: Text("Edit"),
                                value: 'Edit',
                              ),
                              PopupMenuItem(
                                child: Text("Delete"),
                                value: "Delete",
                              )
                            ];
                          }),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: const Color.fromARGB(255, 238, 233, 218),
                  strokeWidth: 5,
                  color: const Color.fromARGB(255, 0, 119, 255),
                ),
              );
            }
          }),
      drawer: Drawer(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
