import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../router/routes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';
import '../Singin.dart';


class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {

  @override

  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
           if(snapshot.hasData) {
            return GraphMainPage();
          } else {
            return Login();
          }
        },
      );

  }
}

class GraphMainPage extends StatelessWidget {

  const GraphMainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<List<Usuario>>(
        //future: Usuario.selectUsuarioFromFirebase(user.email!),
        stream: readUsuario(),
        builder: (context, snapshot) {

          if(snapshot.hasData) {
            final usuario = snapshot.data;
            return Tabs(usuario: usuario![usuario.indexWhere((element) => element.email == user.email)]);
          } else {
            // return BaseQRScreen( errorMessage: true,);
            return Login();
          }
        }
    );

  }
}

Stream<List<Usuario>> readUsuario() => FirebaseFirestore.instance
    .collection('User')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());

class Tabs extends StatelessWidget {
  final Usuario usuario;
  const Tabs({
    Key? key, required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gráficos'),
          actions: [
            logoutButton(),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.show_chart),),
              Tab(icon: Icon(Icons.calculate)),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Graph(usuario: usuario),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleCard(menuOption: Routes.menuOptions[7], width: 155,),
                  SingleCard(menuOption: Routes.menuOptions[8], width: 155,),
                ],
              ),
            )
          ],
        )

      ),
    );
  }
}

class logoutButton extends StatelessWidget {
  const logoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null) {
      return Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              print(FirebaseAuth.instance.currentUser!.email);
            },
            child: Icon(
              Icons.logout,
              size: 23.0,
            ),
          )
      );
    } else {
      return Container();
    }

  }
}


