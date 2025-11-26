import 'package:branc_epl/core/error/exceptions.dart';
import 'package:branc_epl/feature/auth/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firestore;
  AuthRemoteDataSourceImpl(this.firestore);

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print("name : $name");

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw const ServerException('User is null!');
      }
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update display name
      await userCredential.user!.updateDisplayName(name);

      return UserModel(id: userCredential.user!.uid, email: email, name: name);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Authentication error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) {
        throw const ServerException('User not found!');
      }

      // Get user data from Firestore
      final userData = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      return UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: userData['name'],
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Authentication error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userData = await firestore
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (userData.exists && userData.data() != null) {
          return UserModel(
            id: currentUser.uid,
            email: currentUser.email ?? '',
            name: currentUser.displayName ?? '',
          );
        }
      }
      return null;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> signOut() {
    try {
      return FirebaseAuth.instance.signOut();
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
