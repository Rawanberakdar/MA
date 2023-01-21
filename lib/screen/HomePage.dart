import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
  // fetchData
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(actions: [
      IconButton(onPressed: ()async{
        await  FirebaseAuth.instance.signOut();
       print(user);
        Get.off(()=>Signin());
      }, icon: Icon(Icons.exit_to_app))
      ],), 
      body: Container(
        child:ListView(children: [

        ]) ,
      ),);
  }
}

  //  fetchData()async{
  //   CollectionReference userref =FirebaseFirestore.instance.collection("Users");
  //        QuerySnapshot snapshot=await userref.get();
  //        List<QueryDocumentSnapshot>listdocs =snapshot.docs;
  //        listdocs.forEach((element) {
  //         print(element.data());
  //         print("====================>");
  //        });
  //  }