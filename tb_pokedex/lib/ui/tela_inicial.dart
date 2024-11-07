import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tb_pokedex/ui/page/encontro_diario.dart';
import 'package:tb_pokedex/ui/page/my_pokemons.dart';
import 'package:tb_pokedex/ui/page/pokedex.dart';

class Telainicial extends StatefulWidget{
  const Telainicial({super.key});


  @override
  State<Telainicial> createState() => _Telainicial();
}


class _Telainicial extends State<Telainicial>{
  

@override
void initState(){
  super.initState();
}

@override
Widget build(BuildContext context){
  return MaterialApp(
    theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
      
    ),
    darkTheme: ThemeData.dark(useMaterial3: true),
    home: Scaffold(
    appBar: AppBar(
      
      backgroundColor: Color.fromARGB(255, 33, 9, 53),
      title: Text("tela inicial"),
      
    )
    ,

    body: Center(child: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 300,
          decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 8, 56).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(31, 255, 255, 255),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
          child:
        ElevatedButton(onPressed: () {
                // Navega para a tela Pokedex ao pressionar o botão
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pokedex()),
                );
              }, child: Text('Pokedex', textScaler: TextScaler.linear(2),))),
              SizedBox(height: 20),
      Container(
          height: 80,
          width: 300,
          decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 8, 56).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(31, 255, 255, 255),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
          child: ElevatedButton(onPressed: () {
                // navegar para encontro diário
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EncontroDiario()),
                );
              }, child: Text('Encrontro Diário',textScaler: TextScaler.linear(2)))),
              SizedBox(height: 20),
     Container(
          height: 80,
          width: 300,
          decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 8, 56).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(31, 255, 255, 255),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
          child:  ElevatedButton(onPressed: () {
                // navegar para meus pokemons
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPokemons()),
                );
              }, child: Text('Meus pokémons',textScaler: TextScaler.linear(2)))),
    ],),
  )));
}

}