import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/band.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 12),
    Band(id: '3', name: 'Héroes del Silencio', votes: 8),
    Band(id: '4', name: 'Bond Jovi', votes: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "BandNames",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => _listTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget _listTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction){
        //Todo: Llamar el borrado en el servidor
      },
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete_forever),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child:  Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textEditingController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Nombre de la banda"),
              content: TextField(
                controller: textEditingController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () => addBandToList(textEditingController.text),
                  elevation: 5,
                  textColor: Colors.blue,
                  child: const Text("Agregar"),
                )
              ],
            );
          });
    }
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text("Nombre de la banda"),
            content: CupertinoTextField(
              controller: textEditingController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Agregar"),
                onPressed: () => addBandToList(textEditingController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text("Cerrar"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(
          Band(id: (bands.length + 1).toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
