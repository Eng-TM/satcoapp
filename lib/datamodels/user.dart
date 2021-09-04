
import 'package:firebase_database/firebase_database.dart';

class User{
  String fulName;
  String email;
  String phone;
  String id;

  User({
    this.email,
    this.fulName,
    this.phone,
    this.id,
});

  User.fromSnapshot(DataSnapshot snapshot){
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fulName = snapshot.value['fullname'];
  }
}