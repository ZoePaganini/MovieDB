import 'package:flutter/material.dart';
import 'package:practica_final_2/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cartellera'),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(),

              // Slider de pel·licules
              MovieSlider(),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              // MovieSlider(),
              // MovieSlider(),
            ],
          ),
        )));
  }
}
