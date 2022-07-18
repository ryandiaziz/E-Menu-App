import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_menu_app/domain/auth/user_model.dart';
import 'package:e_menu_app/infrastruktur/auth/user_repository.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //mengambil data dari firestore bukan dari auth
      UserModel user =
          await UserRepository().getUserById(userCredential.user!.uid);

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> signUp({
    required String id,
    required String displayName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        displayName: displayName,
        username: username,
        email: email,
        password: password,
      );
//menambahkan ke firestore
      await UserRepository().setUser(user);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
