import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_chistes/providers/registro/loggin.dart';
import 'package:proyecto_chistes/providers/registro/registro.dart';
import 'package:proyecto_chistes/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'categorias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // Proveedor
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider<ChistesProvider>(
            create: (context) => ChistesProvider()),
      ],
      child: MaterialApp(
        title: 'Ya paseme, porfi:c',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: LoginPage(), // Cambia a la página de inicio de sesión
        routes: {
          '/registro': (context) => RegistroPage(),
          '/categorias': (context) => ChuckCategorias(),
        },
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
      routes: {
        '/registro': (context) => RegistroPage(),
      },
    );
  }
}
