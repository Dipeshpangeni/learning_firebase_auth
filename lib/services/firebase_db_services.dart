
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:database_demo/models/company.dart';

class FirebaseDbServices {
  FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference companyCollection =
      FirebaseFirestore.instance.collection("companyes");

  getAllData() async {
    try {
      var querySnapshot = await companyCollection.get();

      var allDocuments = querySnapshot.docs;
      print("The all documnet is $allDocuments");
      List<Company> allCompanies = [];

      for (var document in allDocuments) {
        String id =document.id;
        Map data = document.data() as Map;
        Company newCompany = Company(
          id:id,
            name: data['name'] ?? "No name provided",
            address: data['address'] ?? "No address Given",
            services: data['services']??[],
            establishedAt: data['establistAt'],
            );


        allCompanies.add(newCompany);
      }

      print(allDocuments);

      return allCompanies;
    } catch (e) {
      print("The error id $e");
    }
// var allDocuments = await companyCollection.get();
// print(allDocuments);

// for (var doc in companyCollection.)
  }

  deletCompany(String docId)async{

await companyCollection.doc(docId).delete().then((value)=> print("successfuly deleted"))
.onError((error, stackTrace) => print("error is $error and stack trace is $stackTrace"));
  }

  editCompany({Company? company}){

  }
  addCompany(){}
}
