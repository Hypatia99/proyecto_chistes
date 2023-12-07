import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_chistes/categorias.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //devuelve
  bool get isAuthenticated => _auth.currentUser != null;

//función
//arg
  Future<void> register(
      BuildContext context, String nick, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Verificar si el usuario se registró correctamente
      if (userCredential.user != null) {
        // Actualizar
        User? updatedUser = _auth.currentUser;
        if (updatedUser != null) {
          //Se crea subcoleccion pa favs uwu
          await FirebaseFirestore.instance
              .collection('favoritos')
              .doc(updatedUser.uid)
              .set({});
          notifyListeners();
        }
        //SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registro exitoso.'),
          ),
        );
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

//argumentos
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        //autentificacion
        email: email,
        password: password,
      );
      Provider.of<ChistesProvider>(context, listen: false)
          .setUserId(_auth.currentUser?.uid ?? "");
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }
}
