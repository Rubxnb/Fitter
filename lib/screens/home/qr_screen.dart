import 'package:fitter/helpers/helpers.dart';
import 'package:fitter/theme/app_theme.dart';
import 'package:fitter/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {

  String qrCode = '';

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner QR'),
      ),
      //body: QRScrenBody(qr: qrCode ),
      body: QRScrenBody(qr: qrCode,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () async {
          qrCode = await qrScanner();
          print(qrCode);
          setState(() {

          });
        },
      ),
    );
  }
}

Future<String> qrScanner() async{

  return await  FlutterBarcodeScanner.scanBarcode(
      '#1EBBFD',
      'Cancel',
      true,
      ScanMode.QR);

}

class QRScrenBody extends StatefulWidget {
  final String qr;
  const QRScrenBody({Key? key, required this.qr}) : super(key: key);

  @override
  State<QRScrenBody> createState() => _QRScrenBodyState();
}

class _QRScrenBodyState extends State<QRScrenBody> {
  @override
  Widget build(BuildContext context) {

    if(widget.qr == '') {
      return BaseQRScreen(errorMessage: false,);
    }else if(widget.qr == '-1'){
      return BaseQRScreen(errorMessage: false,);
    } else {
     return StreamBuilder<List<MaterialQR>>(
       //future: MaterialQR.selectFromFirebase(widget.qr),
       stream: readMaterialQR(),
         builder: (context, snapshot) {

          if(snapshot.hasData) {
            final material = snapshot.data;
            return material == null ? BaseQRScreen(errorMessage: true,) : MaterialInfoScreen(material: material[material.indexWhere((element) => element.id == widget.qr)]);
          } else {
           // return BaseQRScreen( errorMessage: true,);
            return LoadingScreen();
          }
       }
     );
    }
  }
}

Widget buildMaterialQR(MaterialQR material) => ListTile(
  leading: Text(material.id),
  title: Text(material.name),
  subtitle: Image.network(material.image),
);


Stream<List<MaterialQR>> readMaterialQR() => FirebaseFirestore.instance
    .collection('MaterialQR')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => MaterialQR.fromJson(doc.data())).toList());

class MaterialInfoScreen extends StatelessWidget {
  final MaterialQR material;
  const MaterialInfoScreen({
    Key? key, required this.material,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text(material.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkBlue),),
          SizedBox(height: 10,),
          FadeInImage(
            image: NetworkImage(material.image),
            placeholder: AssetImage('assets/jar-loading.gif'),
            height: 230,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20,),
          Expanded(
              child: SizedBox(
                height: 200,
                child:  ListView.builder(
                    itemCount: material.exercises.length,
                    itemBuilder: (_, index) =>
                        ListTile(

                          title: ExercisesList(ejercicio: material.exercises[index]),

                        ),
                  ),
              )
          )
        ],
      ),
    );

  }
}

class ExercisesList extends StatelessWidget {
  final Ejercicio ejercicio;
  const ExercisesList({
    Key? key, required this.ejercicio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10,),
          ClipRRect(child: Image.asset(ejercicio.imagen, width: 50, height: 50,)),
          SizedBox(width: 20,),
          Text(ejercicio.nombre, style: AppTheme.textoNombreEj,),
          SizedBox(width: 20,),
          Image.asset(getTipoIcon(ejercicio.tipo), width: 40, height: 50,)

        ],
      ),
    );
  }
}

class BaseQRScreen extends StatelessWidget {
  final bool errorMessage;
  const BaseQRScreen({
    Key? key, required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      alignment: Alignment.center,
      child:
          Column(
            children: [
              Image(image: AssetImage('assets/qrexample.png'),),
              errorMessage ? Text('El código escaneado no se encuentra en nuestra base de datos, por favor, escanee uno válido', style: TextStyle(fontWeight:FontWeight.bold, fontSize: 16, color: Colors.red),) : Container(),
              SizedBox(height: 10,),
              Text('Escanee el código QR de un material válido para visualizar qué tipos de ejercicios recomendados puede realizar con dicho material',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.darkBlue),
              textAlign: TextAlign.center,),
            ],
          ),
    );
  }
}

/*
        MaterialQR material = MaterialQR(exercises: [], image: '', name: '', id: '');
      MaterialQR.select(material, qr);
     if(material.id != '' ) {
       return MaterialInfoScreen(document: qr,);
      } else {
        return BaseQRScreen(errorMessage: true,);
     }
       */

// ======================= SELECT BUENO CON STREAM LIST===================================
/*
      return StreamBuilder<List<MaterialQR>>(
       stream: readMaterialQR(),
         builder: (context, snapshot) {
         if(!snapshot.hasData) {
           return BaseQRScreen(errorMessage: true,);
         }else if(snapshot.hasData) {
              final material = snapshot.data!;

              return ListView(
                children: material.map(buildMaterialQR).toList());

            } else {
           return BaseQRScreen(errorMessage: true,);
         }
         }
     );
       */