import 'package:flutter/material.dart';
import 'package:proyecto_chistes/providers/auth_provider.dart';
import 'package:proyecto_chistes/providers/registro/loggin.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({Key? key});

  @override
  //Gestionar los campos
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
//insancia
    AuthProvider authProvider = AuthProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Nombre de usuario",
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Contraseña",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              //escuchador de eventos
              onPressed: () async {
                try {
                  await authProvider.register(
                    context,
                    usernameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  //actualiza la pagina
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                  //manejo de exepciones
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Error al registrarse. Verifica tus datos e intenta nuevamente.'),
                    ),
                  );
                }
              },
              child: Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}
