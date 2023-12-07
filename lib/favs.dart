import 'package:flutter/material.dart';
import 'package:proyecto_chistes/categorias.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chistes Favoritos"),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: Provider.of<ChistesProvider>(context).obtenerFavoritos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error al obtener chistes favoritos"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text("No hay chistes favoritos."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(
                        snapshot.data![index]), // clave única para el elemento
                    onDismissed: (direction) async {
                      // Lógica para eliminar la frase
                      String chiste = snapshot.data![index];
                      await Provider.of<ChistesProvider>(context, listen: false)
                          .eliminarFavorito(chiste);
                      // Actualiza la interfaz de usuario
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Chiste eliminado de favoritos."),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      title: Text(snapshot.data![index]),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
