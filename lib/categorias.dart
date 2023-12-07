import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:proyecto_chistes/dev.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_chistes/favs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChistesProvider with ChangeNotifier {
  dev? devChiste;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _userId = "";

  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  Future<void> guardarFavorito(String chiste) async {
    try {
      await _firestore.collection('favoritos').add({
        'userId': _userId,
        'chiste': chiste,
        'timestamp': FieldValue.serverTimestamp(),
      });
      notifyListeners();
    } catch (e) {
      print('Error al guardar el chiste favorito en Firestore: $e');
    }
  }

  void setDevChiste(dev nuevoChiste) {
    devChiste = nuevoChiste;
    //String _userId = "";
    notifyListeners();
  }

  Future<void> agregarFavorito(String chiste) async {
    try {
      await _firestore
          .collection('favoritos')
          .doc(_userId) // Usamos el ID del usuario
          .collection('chistes')
          .add({
        'chiste': chiste,
        'timestamp': FieldValue.serverTimestamp(),
      });
      notifyListeners(); // Notificamos a los oyentes que la lista ha cambiado
    } catch (e) {
      print('Error al agregar el chiste favorito en Firestore: $e');
      throw e;
    }
  }

  Future<List<String>> obtenerFavoritos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('favoritos')
          .where('userId', isEqualTo: _userId)
          .get();

      List<String> favoritos = querySnapshot.docs
          .map((doc) => doc.get('chiste').toString())
          .toList();
      return favoritos;
    } catch (e) {
      print('Error al obtener chistes favoritos: $e');
      return [];
    }
  }

  Future<void> eliminarFavorito(String chiste) async {
    try {
      // Busca el documento que coincida con el usuario y el chiste
      QuerySnapshot querySnapshot = await _firestore
          .collection('favoritos')
          .where('userId', isEqualTo: _userId)
          .where('chiste', isEqualTo: chiste)
          .get();

      // Elimina el documento encontrado
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.delete();
      }

      notifyListeners(); // Notifica a los oyentes que la lista ha cambiado
    } catch (e) {
      print('Error al eliminar el chiste favorito en Firestore: $e');
      throw e;
    }
  }
}
//

class ChuckCategorias extends StatelessWidget {
  final List<String> categories = ["dev", "animal", "celebrity", "religion"];

  ChuckCategorias({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Welcome to the chistes perrones of Chuck Norris",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/Imagen.jpg',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 5),
            const Text(
              "Select a category please:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: categories[index],
                );
              },
            ),
            // Mostrar la lista de chistes favoritos
            Consumer<ChistesProvider>(
              builder: (context, chistesProvider, child) {
                if (chistesProvider.devChiste != null) {
                  return Column(
                    children: [
                      Text(chistesProvider.devChiste!.value),
                      ElevatedButton(
                        onPressed: () async {
                          if (chistesProvider.devChiste != null) {
                            String chiste = chistesProvider.devChiste!.value;
                            await chistesProvider.guardarFavorito(chiste);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Chiste agregado a favoritos.'),
                              ),
                            );
                          }
                        },
                        child: Text("Agregar a favoritos"),
                      ),
                    ],
                  );
                } else {
                  return Text("No se ha cargado un chiste aún.");
                }
              },
            ),
            const SizedBox(height: 10),
            // Mostrar la lista de chistes favoritos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritosPage()),
                );
              },
              child: Text("Ver Favoritos"),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          category,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () async {
          final chiste = await getChuckNorrisJoke(category);
          final chistesProvider =
              Provider.of<ChistesProvider>(context, listen: false);
          chistesProvider.setDevChiste(chiste);
        },
      ),
    );
  }

  // Solicitar chiste
  Future<dev> getChuckNorrisJoke(String category) async {
    final response = await http.get(
      Uri.parse('https://api.chucknorris.io/jokes/random?category=$category'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      dev devChiste = dev.fromJson(responseData);
      return devChiste;
    } else {
      print('Error al obtener un chiste aleatorio: ${response.statusCode}');
      return dev(
        categories: [],
        createdAt: DateTime.now(),
        iconUrl: '',
        id: '',
        updatedAt: DateTime.now(),
        url: '',
        value: '',
      );
    }
  }
}
