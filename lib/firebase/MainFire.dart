import 'package:cloud_firestore/cloud_firestore.dart';

class MainFire {

   /// These are all dummy data 
  createpharmdet() {
    CollectionReference cr = Firestore.instance.collection("PharmacyDetails");
    cr.add({
      "Name": "BB",
      "E-mail": "something@gh.com",
      "PhoneNumber": 2233345667,
      "Location": "Kumasi",
      "Stock": ["Panadol", "Tramadol"]
    }).whenComplete(() {
      print("Saved Pharmacy Details");
    });
  }

  createownerdet() {
    CollectionReference cr = Firestore.instance.collection("OwnerDeatils");
    cr.add({
      "Name": "BB",
      "E-mail": "something@gh.com",
      "PhoneNumber": 2233345667,
      "Owns": "Tech Hostpital"
    }).whenComplete(() {
      print("Saved Owner Details");
    });
  }
}
