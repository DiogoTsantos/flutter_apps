import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/models/uber_user.dart';

class FirebaseUser {
  static Future<User?> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser;
  }

  static Future<UberUser> getLoggedUserData() async {
    User user = await getCurrentUser() as User;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection('users').doc(user.uid).get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UberUser(
      idUser: user.uid,
      name: data['name'],
      email: data['email'],
      type: data['type']
    );
  }

  static updateDataLocation(String travelID, double lat, double long) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    UberUser user = await getLoggedUserData();
    user.lat = lat;
    user.long = long;

    Map<String, dynamic> data;
    if ( user.type == 'passenger' ) {
      data = {
        'passenger': user.toMap()
      };
    } else {
      data = {
        'driver': user.toMap()
      };
    }

    db.collection('travels')
      .doc(travelID)
      .update(data);
  }
}