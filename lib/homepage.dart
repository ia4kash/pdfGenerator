import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greenit/services.dart';
import 'package:greenit/sizeconfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = "GREEN IT PDF";
  final _header = TextEditingController(text: "");
  File _image;
  final picker = ImagePicker();
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.blockSizeHorizontal * 40),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Input Header",
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.blue,
                      ),
                    ),
//                validator: _validateName,
                    controller: _header,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeHorizontal * 10),
                Text("Choose Signature:"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlineButton(
                    borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 2.5),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                height: SizeConfig.blockSizeHorizontal * 30,
//                                width: SizeConfig.blockSizeHorizontal * 8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ListTile(
                                      onTap: getImageCamera,
                                      title: Text("Camera"),
                                      leading: Icon(Icons.camera,
                                          size: SizeConfig.blockSizeHorizontal *
                                              8),
                                    ),
                                    ListTile(
                                      onTap: getImageGallery,
                                      title: Text("Galley"),
                                      leading: Icon(Icons.photo,
                                          size: SizeConfig.blockSizeHorizontal *
                                              8),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: _displayChild(),
                  ),
                ),
//                SizedBox(height: SizeConfig.blockSizeHorizontal * 5),

                RaisedButton(
                    elevation: 1,
                    onPressed: () {
                      reportView(context, _header.text, _image.path);
                    },
//                  textColor: white,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                        color: Colors.blue,
                        height: SizeConfig.blockSizeHorizontal * 10,
                        width: SizeConfig.blockSizeHorizontal * 60,
                        alignment: Alignment.center,
                        child: Text(
                          "Create PDF",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayChild() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.pop(context);
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.pop(context);
  }
}
