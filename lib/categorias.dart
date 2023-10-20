import 'package:flutter/material.dart';

class ChuckCategorias extends StatelessWidget {
  final List<String> categories = [
    "Animal",
    "Celebridad",
    "Dev??",
    "Religion",
    "Chance Aleatorio"
  ];

  ChuckCategorias({super.key});

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
              "Seleccione una categoría por favor:",
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
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  const CategoryCard({super.key, required this.category});

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
        onTap: () {
          // print("Seleccionaste la categoría: $category");
        },
      ),
    );
  }
}
