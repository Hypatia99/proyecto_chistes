import 'package:flutter/material.dart';
import 'categorias.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ChistesProvider>(
            create: (context) => ChistesProvider()),
      ],
      child: MaterialApp(
        home: ChuckCategorias(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
