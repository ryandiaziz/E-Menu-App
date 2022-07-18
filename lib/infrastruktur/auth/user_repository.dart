import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/auth/user_model.dart';

class UserRepository {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

//menampilkan data dinamis
  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'displayName': user.displayName,
        'username': user.username,
        'password': user.password,
        'id': user.id
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userReference.doc(id).get();
      return UserModel(
          id: id,
          displayName: snapshot['displayName'],
          username: snapshot['username'],
          email: snapshot['email'],
          password: snapshot['password']);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<void> updateUser(
  //     String displayName, String email, String username) async {
  //   try {
  //     return await _userReference.doc().update({
  //       'displayName': displayName,
  //       'email': email,
  //       'username': username,
  //     });
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
