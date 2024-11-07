import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tb_pokedex/core/di/configure_providers.dart';
import 'package:tb_pokedex/ui/tela_inicial.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

   final data = await ConfigureProviders.createDependencyTree();

  runApp(Approot(data: data));
}


class Approot extends StatelessWidget{
    final ConfigureProviders data;

const Approot({super.key, required this.data});




 @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tela inicial',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Telainicial(),
      ),
    );
  }
}

 




