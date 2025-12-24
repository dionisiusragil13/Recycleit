import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:recyleit/services/database.dart';
import 'package:recyleit/services/share_pref.dart';
import 'package:recyleit/services/widget_support.dart';

class UploadItem extends StatefulWidget {
  String category, id;
  UploadItem({required this.category, required this.id});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController quantitycontroller = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? id, name;

  getthesharedpref() async {
    id = await SharedPreferenceHelpers().getUserId();
    name = await SharedPreferenceHelpers().getUserName();
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(60.0),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Text("Upload Item", style: AppWidget.headlinetextstyle(22.0)),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: const Color.fromARGB(255, 213, 213, 249),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    selectedImage != null
                        ? Center(
                          child: Container(
                            height: 180,
                            width: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ),
                        ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "Enter your address you want the item to be picked",
                        style: AppWidget.normaltextstyle(18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: addresscontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.location_on),
                              hintText: "Enter Address",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "Enter the quantity of item you want to be picked",
                        style: AppWidget.normaltextstyle(18.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: quantitycontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.inventory),
                              hintText: "Enter Quantity",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.0),
                    GestureDetector(
                      onTap: () async {
                        if (selectedImage != null &&
                            addresscontroller.text != "" &&
                            quantitycontroller.text != "") {
                          String itemid = randomAlphaNumeric(10);
                          Reference firebaseStorageRef = FirebaseStorage
                              .instance
                              .ref()
                              .child("blogImage")
                              .child(itemid);
                          final UploadTask task = firebaseStorageRef.putFile(
                            selectedImage!,
                          );
                          var downloadUrl =
                              await (await task).ref.getDownloadURL();
                          Map<String, dynamic> addItem = {
                            "Image": downloadUrl,
                            "address": addresscontroller,
                            "quantity": quantitycontroller,
                            "id": id,
                            "name": name,
                            "status": "Pending",
                          };
                          await DatabaseMethods().addUserUploadItem(
                            addItem,
                            id!,
                            itemid,
                          );
                          await DatabaseMethods().addAdminItem(addItem, itemid);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "image Uploaded",
                                style: AppWidget.whitetextstyle(22.0),
                              ),
                            ),
                          );
                          setState(() {
                            addresscontroller.text = "";
                            quantitycontroller.text = "";
                            selectedImage = null;
                          });
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              "Upload",
                              style: AppWidget.headlinetextstyle(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
