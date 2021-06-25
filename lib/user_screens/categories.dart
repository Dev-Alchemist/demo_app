import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/tools/appData.dart';
import 'package:demo_app/tools/app_methods.dart';
import 'package:demo_app/tools/app_tools.dart';
import 'package:demo_app/tools/firebase_methods.dart';
import 'package:demo_app/user_screens/myhomepage.dart';

class Categories extends StatefulWidget {

  final String prodtCategory;
  Categories({this.prodtCategory});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories> {
  AppMethods appMethods = FirebaseMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String prodtCategory = " ";
  var _data;
  @override
  void initState() {
    super.initState();
    _data = appMethods.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Find X',
              style: TextStyle(
                  fontFamily: "Montserrat", fontStyle: FontStyle.italic)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: screenSize.width,
                height: screenSize.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/catbackground.jpg'))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.storage),
                        SizedBox(width: 3.0),
                        Text(
                          "Product Category",
                          style: TextStyle(
                              fontSize: 19.0, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Divider(
                      height: 10.0,
                      indent: 10.0,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  FutureBuilder(
                    future: firestore.collection(categories).get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            return Container();
                          });
                      }
                      final int dataCount = snapshot.data.docs.length;
                      // final int dataCount = snapshot.data.length;
                      if (dataCount == 0 || dataCount == null) {
                        displayProgressDialog(context);
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          var document = snapshot.data.docs[index];
                          List categoryIcon = document[categoryImage] as List;
                          return GestureDetector(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return MyHomePage(
                                          prodctCategory: document[categoryName]);
                                    }));
                              });
                            },
                            child: Card(
                              child: Stack(
                                alignment: FractionalOffset.bottomCenter,
                                children: <Widget>[
                                  Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(categoryIcon[0]),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Container(
                                    child: Container(
                                      color: Colors.white,
                                      height: 55,
                                      width: screenSize.width / 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          document[categoryName],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
