import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:proyecto_chistes/dev.dart';
import 'package:http/http.dart' as http;

class ChistesProvider with ChangeNotifier {
  dev? devChiste;

  void setDevChiste(dev nuevoChiste) {
    devChiste = nuevoChiste;
    notifyListeners();
  }
}

class ChuckCategorias extends StatelessWidget {
  final List<String> categories = [
    "dev",
    "animal",
    "celebrity",
    "religion",
    "random"
  ];

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
            Consumer<ChistesProvider>(
              builder: (context, chistesProvider, child) {
                final devChiste = chistesProvider.devChiste;
                if (devChiste != null) {
                  return Text(devChiste.value);
                } else {
                  return Text("No se ha cargado un chiste aún.");
                }
              },
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
