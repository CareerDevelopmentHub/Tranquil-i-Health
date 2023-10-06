import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthhero/src/constants/global.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

// Collection ref
//-----------------------userRef------------------------------//
CollectionReference usersRef = firestore.collection('user');
//-----------------------userRef------------------------------//

//-----------------------social------------------------------//

CollectionReference postRef = firestore.collection('posts');
CollectionReference myPostRef = firestore
    .collection('user')
    .doc(sharedPreferences.getString('email'))
    .collection("media");
CollectionReference groupRef = firestore.collection('groups');
CollectionReference groupsRef = firestore.collection('group');
//-----------------------social------------------------------//


