import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personajes desde JSON"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future:
          DefaultAssetBundle.of(context).loadString("assets/datos.json"),
          builder: (context, snapshot) {
            var jsonData = json.decode(snapshot.data.toString());
            return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomList(
                          imagen: CircleAvatar(
                            backgroundImage: NetworkImage(
                                jsonData[index]['imagen'].toString()),
                          ),
                          Nombre: jsonData[index]["Nombre"].toString(),
                          identidadSecreta:
                          jsonData[index]["identidadSecreta"].toString(),
                          descripcion:
                          jsonData[index]["descripcion"].toString(),
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

class _heroesDescripcion extends StatelessWidget {
  const _heroesDescripcion({
    Key? key,
    this.Nombre,
    this.identidadSecreta,
    this.descripcion,
  }) : super(key: key);
  final String? Nombre;
  final String? identidadSecreta;
  final String? descripcion;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Text(
                Nombre!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                identidadSecreta!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.pinkAccent,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                descripcion!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        )
      ],
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList(
      {Key? key,
        this.Nombre,
        this.identidadSecreta,
        this.descripcion,
        this.imagen})
      : super(key: key);
  final String? Nombre;
  final String? identidadSecreta;
  final String? descripcion;
  final Widget? imagen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: imagen,
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                  child: _heroesDescripcion(
                    Nombre: Nombre,
                    identidadSecreta: identidadSecreta,
                    descripcion: descripcion,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

Widget circular(String url) {
  return ListTile(
    leading: CircleAvatar(
      backgroundImage: NetworkImage(url),
    ),
  );
}
