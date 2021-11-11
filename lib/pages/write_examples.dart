import 'dart:math';
import 'package:dti/pages/read_examples.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class WriteExamples extends StatefulWidget {
  const WriteExamples({Key? key}) : super(key: key);

  @override
  _WriteExamplesState createState() => _WriteExamplesState();
}

class _WriteExamplesState extends State<WriteExamples> {
  final database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    final dailySpecialRef = database.child('/products/martelo');
    final dailySpecialRefFuradeira = database.child('/products/furadeira');
    final dailySpecialRefCaixa= database.child('/products/caixa_de_ferramentas');
    final dailySpecialRefSerra= database.child('/products/serra');
    final dailySpecialRefPicareta= database.child('/products/picareta');
    final dailySpecialRefMakita= database.child('/products/makita');
    final dailySpecialRefKitParafusos= database.child('/products/kit_parafusos');

    //final dailySpecialRefTeste = database.child('/testes/');

    //databaseRef>.set({message: "Hello!", timestamp ...})
    return Scaffold(
      appBar: AppBar(title: const Text('Write Examples',
      ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReadExamples(),
                  ));
            },
            child: const Text("Equipamentos"),
          ),
        ],
      ),body: Center(child: Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          ElevatedButton(onPressed: () async{
            await dailySpecialRef.set({'equipment': getRandomEquipment(),'price': getRandomPrice(),
              "userName":getRandomName(),"day_price": 20,'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));
          },
            child: const Text("Simple Set"),
          ),
          ElevatedButton(
            onPressed: () {
              final nextSO = <String, dynamic>{
                'equipment':getRandomEquipment(),
                'price': getRandomPrice(),
                //ou 'price': Random().nextInt(800) / 100.0,
                'userName': getRandomName(),
                'time': DateTime.now().hour,
              };
              database.child('orders').push().set(nextSO)
                  .then((_) => print("Order has been written!"))
                  .catchError((error) => print("You got an error $error"));
            }, child: const Text("Append a SO(Ordem de Pedido de Equipamentos)"),
          ),
          ElevatedButton(
            onPressed: () {
              final nextSO = <String, dynamic>{
                'equipment':'Martelo',
                'price': '30',
                'price_day':'5',
                "quantity": "1",
                //ou 'price': Random().nextInt(800) / 100.0,
                //'userName': getRandomName(),
                //'time': DateTime.now().hour,
              };
              database.child('products/martelo').push().set(nextSO)
                  .then((_) => print("Order has been written!"))
                  .catchError((error) => print("You got an error $error"));
            },
            child: const Text("Products"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRef.set({
              'equipment': "Martelo",
              'id': "Martelo",
              "price_day": 5,
              "quantity": "1",
              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));
          },
            child: const Text("Definindo o Martelo no Banco"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRefFuradeira.set({
              'id': 'Furadeira',
              'equipment':'Furadeira',
              'quantity': '1',
              'price_day':'20',
              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));
          },
            child: const Text("Definindo a Furadeira no Banco"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRefCaixa.set({
              'id': 'Caixa de Ferramentas',
              'equipment':'Caixa de Ferramentas',
              'quantity': '1',
              'price_day':'20',
              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));
          },
            child: const Text("Definindo a Caixa Ferramentas no Banco"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRefMakita.set({
              'id': 'Makita',
              'equipment':'Makita',
              'quantity': '1',
              'price_day':'30',
              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));
          },
            child: const Text("Definindo a Makita no Banco"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRefSerra.set({
              'id': 'Serra',
              'equipment':'Serra',
              'quantity': '1',
              'price_day':'30',

              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));

          },
            child: const Text("Definindo a Serra no Banco"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRefPicareta.set({
              'id': 'Picareta',
              'equipment':'Picareta',
              'quantity': '1',
              'price_day':'10',
              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));

          },
            child: const Text("Definindo a Picareta no Banco"),
          ),
          ElevatedButton(onPressed: () async{
            await dailySpecialRefKitParafusos.set({
              'id': 'Kit Parafusos',
              'equipment':'Kit Parafusos',
              'quantity': '1',
              'price_day':'25',
              //'time': DateTime.now().millisecondsSinceEpoch,
            }).catchError((error) => print("You got an error! $error"));
          },
            child: const Text("Definindo a Kit Parafusos no Banco"),
          ),
        ],
      ),
    ),
    ),
    );
  }

  String getRandomEquipment() {
    final equipmentList = [
      'KIT PARAFUSOS',
      'PICARETA',
      'SERRA',
      'MAKITA',
      'CAIXA DE FERRAMENTAS',
      'MARTELO'
    ];
    return equipmentList[Random().nextInt(equipmentList.length)];
  }

  String getRandomName() {
    final userName = [
      'Paulo',
      'Alisson',
      'Jéssica',
      'Adriel',
    ];
    return userName[Random().nextInt(userName.length)];
  }
  String getRandomPrice() {
    final equipmentPrice = [
      '150',
      '85',
      '310',
      '309',
      '200',
      '160'
    ];
    return equipmentPrice[Random().nextInt(equipmentPrice.length)];
  }
}


