import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  void initState() {
    //fetchData();
    //fetchDataRealTime();
    // batchwrite();
    super.initState();
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('PackageServices').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 80, 80, 80),
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${snapshot.data!.docs[i]['name']}",
                    ),
                  );
                });
          },
        ));
  }
}

  // fetchData() async {
  //   CollectionReference userref =
  //       FirebaseFirestore.instance.collection("PackageServices");
  //   QuerySnapshot snapshot = await userref.get();
  //   List<QueryDocumentSnapshot> listdocs = snapshot.docs;
  //   return listdocs;
  // }

    /* getData() async {
    CollectionReference usersref =
        FirebaseFirestore.instance.collection('users');
    await usersref.get().then((value) => {print(value.docs)});
  }*/
  
   // show data future
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Container(
  //           child: ListView(
  //     children: [
  //       FutureBuilder(
  //           future: fetchData(),
  //           builder: (BuildContext context, AsyncSnapshot snapshot) {
  //             if (snapshot.hasData) {
  //               return GridView.builder(
  //                   shrinkWrap: true,
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                     crossAxisCount: 2,
  //                   ),
  //                   itemCount: snapshot.data.length,
  //                   itemBuilder: (BuildContext context, int i) {
  //                     return Container(
  //                       padding: EdgeInsets.all(10),
  //                       margin: EdgeInsets.all(10),
  //                       decoration: BoxDecoration(
  //                         border: Border.all(color: Colors.black, width: 4),
  //                         borderRadius: BorderRadius.circular(8),
  //                         boxShadow: [
  //                           new BoxShadow(
  //                             color: Color.fromARGB(255, 246, 250, 246),
  //                             offset: new Offset(6.0, 6.0),
  //                           ),
  //                         ],
  //                       ),
  //                       child: Text(
  //                         "${snapshot.data[i]['name']}",
  //                       ),
  //                     );
  //                   });
  //             }
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return CircularProgressIndicator();
  //             }
  //             if (snapshot.hasError) {
  //               return Center(
  //                 child: Text(
  //                   '${snapshot.error} occurred',
  //                   style: TextStyle(fontSize: 18),
  //                 ),
  //               );
  //             }

  //             return Text("  لا يوجد اي عقود ");
  //           })
  //     ],
  //   )));
  // }




//where("status",wherin:[x,y ,z] )
//where("status",wherenotin:[x,y ,z] )
//where("status",arraycontent:"") serch in filde thate is array
//where("type",isEqualTo:"vender").where("status",isEqualTo:true)  tow conditions
//userref.orderBy("phoneNumber",descending =true).get(); oderby phonenumber


   // fetch data
  //      CollectionReference userref =
  //       FirebaseFirestore.instance.collection("PackageServices");
  //   QuerySnapshot snapshot = await userref.get();
  //   List<QueryDocumentSnapshot> listdocs = snapshot.docs;
  //   return listdocs;
  // }


  // batch same transction  ....all success or all fails 
  // batchwrite() async {
  //   DocumentReference userref = FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc("NjGVoJk31jwFp3J60REy");
  //   DocumentReference userref2 = FirebaseFirestore.instance
  //       .collection("Users")
  //       .doc("SBdV46iFaMlVfmjxc4ag");
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   batch.delete(userref);
  //   batch.update(userref2, {
  //     "name": "Ahmad",
  //   });
  //   batch.commit();
  // }

  //        read data real time 
  //       fetchDataRealTime()async{
  //       FirebaseFirestore.instance.collection("Users").snapshots().listen((event) {
  //         event.docs.forEach((element) {
  //          print("usernaem ${ element.data()['name']} ");
  //         });
  //       });
  // }





