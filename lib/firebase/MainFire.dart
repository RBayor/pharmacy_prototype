import 'package:cloud_firestore/cloud_firestore.dart';

class MainFire {

   /// These are all dummy data 
  createpharmdet() {
    CollectionReference cr = Firestore.instance.collection("PharmacyDetails");
    cr.add({
      "Name": "Null",
      "E-mail": "something@gh.com",
      "PhoneNumber": null,
      "Location": "Unavailable",
      "Stock": ["Unavailable"]
    }).whenComplete(() {
      print("Saved Pharmacy Details");
    });
  }

  createownerdet() {
    CollectionReference cr = Firestore.instance.collection("OwnerDeatils");
    cr.add({
      "Name": "Null",
      "E-mail": "something@gh.com",
      "PhoneNumber": null,
      "Owns": "Unavailable"
    }).whenComplete(() {
      print("Saved Owner Details");
    });
  }
}
