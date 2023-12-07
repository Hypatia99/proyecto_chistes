import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // método para guardar el chiste favorito
  Future<void> guardarChisteFavorito(String chiste, String userId) async {
    try {
      await _firestore
          .collection('favoritos')
          .doc(userId)
          .collection('chistes')
          .add({
        'chiste': chiste,
        //marca de tiempo en fire
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error al guardar el chiste favorito: $e');
      throw e;
    }
  }

  // método para obtener los chistes favoritos del usuario
  Future<List<String>> obtenerChistesFavoritos(String userId) async {
    try {
      //consulta pa obtener coleccion identificada por user
      QuerySnapshot querySnapshot = await _firestore
          .collection('favoritos')
          .doc(userId)
          .collection('chistes')
          .get();
      //mapeo de los doc obtenidos
      return querySnapshot.docs.map((doc) => doc['chiste'].toString()).toList();
    } catch (e) {
      print('Error al obtener chistes favoritos: $e');
      throw e;
    }
  }
}
