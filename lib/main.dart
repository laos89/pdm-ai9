import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ai8 Json superheroes"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString("assets/datos.json"),
          builder: (context, snapshot) {
            var jsonData = json.decode(snapshot.data.toString());
            return new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomList(
                          foto: CircleAvatar(
                            backgroundImage: NetworkImage(
                                jsonData[index]["foto"].toString()),
                          ),
                          nombre: "Nombre: "+jsonData[index]["nombre"].toString(),
                          edad: "Edad: "+jsonData[index]["edad"].toString(),
                          altura: "Altura: "+jsonData[index]["altura"].toString(),
                          genero: "Genero: "+jsonData[index]["genero"].toString(),
                        )
                      ],
                    ),
                  );
                },
                itemCount: jsonData == null ? 0 : jsonData.length);
          },
        ),
      ),
    );
  }
}

class _heroes extends StatelessWidget {
  const _heroes({Key? key, this.nombre, this.edad, this.altura, this.genero})
      : super(key: key);
  final String? nombre;
  final String? edad;
  final String? altura;
  final String? genero;

  @override
  Widget build(BuildContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Text(
                  nombre!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  genero!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.lightBlue),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              ],
            )),
        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  edad!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.lightBlue),
                ),
                Text(
                  altura!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.lightBlue),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              ],
            ))
      ],
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList(
      {Key? key, this.nombre, this.edad, this.altura, this.genero, this.foto})
      : super(key: key);
  final String? nombre;
  final String? edad;
  final String? altura;
  final String? genero;
  final Widget? foto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 75,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: foto,
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
              child: _heroes(
                nombre: nombre,
                edad: edad,
                altura: altura,
                genero: genero,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

Widget circleading(String url) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(url),
    ),
  );
}