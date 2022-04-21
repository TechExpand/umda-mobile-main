import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/controller/authprovider.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/screens/widgets/CustomCircular.dart';
import 'package:shop_app/screens/widgets/shimmerloading.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // List<Services> result = [];
  late Future<dynamic> userInfo;
  // XFile selectedImage;


  getProfile(BuildContext context) async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      userInfo = authProvider.getUserInfo();
    });
  }

  // void pickImage({@required ImageSource source, context}) async {
  //   // var network = Provider.of<WebServices>(context, listen: false);
  //   // var data = Provider.of<Utils>(context, listen: false);
  //   // final picker = ImagePicker();
  //   // var image = await picker.pickImage(source: source);
  //   // setState(() => selectedImage = image);
  //   //
  //   // String imageName = await network.uploadProfilePhoto(
  //   //   path: selectedImage.path,
  //   // );
  //   //
  //   // data.storeData('profile_pic_file_name', imageName);
  //   // network.initializeValues();
  //   // update(context);
  // }

  @override
  void initState() {
    super.initState();
    getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    // var data = Provider.of<Utils>(context, listen: false);
    // var location = Provider.of<LocationService>(context);
    // var network = Provider.of<WebServices>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(() {
              setState(() {});
            });
          },
          icon: Icon(FeatherIcons.arrowLeft, color: Colors.black),
        ),
        title: Text('Edit profile',
            // style: GoogleFonts.poppins(
            //     color: Colors.white,
            //     fontSize: 18,
            //     height: 1.4,
            //     fontWeight: FontWeight.w600)
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: userInfo,
          builder: (context,AsyncSnapshot snapshot) {
            return !snapshot.hasData||userInfo==null?LoadingShimmer():ListView(children: [
              Padding(
                padding:
                const EdgeInsets.only(left: 25, right: 25, top: 10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'fullname',
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width / 1.5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    '${snapshot.data!['fullname'].toString()}',
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                _editName(snapshot.data['fullname'],
                                    snapshot.data['phone'], snapshot.data['street_address']);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.orange,
                                    ),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  FeatherIcons.edit3,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Divider(),
                        Row(
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width / 1.5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    '${snapshot.data!['phone'].toString()}',
                                    style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                _editPhone(snapshot.data['fullname'],
                                    snapshot.data['phone'], snapshot.data['street_address']);
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.orange,
                                    ),
                                    shape: BoxShape.circle),
                                child: Icon(
                                  FeatherIcons.edit3,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'Edit Address',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    1.5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${snapshot.data!['street_address'].toString()}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  _editAddress(snapshot.data['fullname'],
                                      snapshot.data['phone'], snapshot.data['street_address']);
                                },
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.orange,
                                      ),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    FeatherIcons.edit3,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    1.5,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${snapshot.data!['state'].toString()}, ${snapshot.data!['city'].toString()} ${snapshot.data!['country'].toString()}',
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),


                  ],
                ),
              ),
            ]);
          }),
    );
  }

  void _editName(fullname, phone, address) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateProfileFullname.text = fullname;
    authProvider.updateProfilePhone.text = phone;
    authProvider.updateProfileAddress.text =  address;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
                height: 220.0,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: Colors.transparent,
                child: ListView(
                  children: [
                    Text(
                      "Edit fullname",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(color: Color(0xFFF1F1FD)),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: TextField(
                        controller: authProvider.updateProfileFullname,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle:
                          TextStyle(fontSize: 16, color: Colors.black38),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          disabledColor: Colors.orange,
                          onPressed: () => Navigator.pop(context),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100, minHeight: 34.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          disabledColor: Colors.orange,
                          onPressed: () async {

                            Navigator.pop(context);
                            circularCustom(context);
                            AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                            authProvider.updateProfileFunction(
                                context
                            ).then((value){
                              setState(() {
                                Navigator.pop(context);
                                getProfile(context);
                              });
                            });
                          },
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100, minHeight: 34.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                )),
          );
        });
  }







  void _editPhone(fullname, phone, address) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateProfileFullname.text = fullname;
    authProvider.updateProfilePhone.text = phone;
    authProvider.updateProfileAddress.text =  address;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
                height: 220.0,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: Colors.transparent,
                child: ListView(
                  children: [
                    Text(
                      "Edit Phone",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(color: Color(0xFFF1F1FD)),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: TextField(
                        controller: authProvider.updateProfilePhone,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle:
                          TextStyle(fontSize: 16, color: Colors.black38),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          disabledColor: Colors.orange,
                          onPressed: () => Navigator.pop(context),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100, minHeight: 34.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          disabledColor: Colors.orange,
                          onPressed: () async {
                            Navigator.pop(context);
                            circularCustom(context);
                            AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);
                            authProvider.updateProfileFunction(
                                context
                            ).then((value){
                              setState(() {
                                Navigator.pop(context);
                                getProfile(context);
                              });
                            });
                          },
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100, minHeight: 34.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                )),
          );
        });
  }




  void _editAddress(fullname, phone, address) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateProfileFullname.text = fullname;
    authProvider.updateProfilePhone.text = phone;
    authProvider.updateProfileAddress.text =  address;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
                height: 220.0,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                color: Colors.transparent,
                child: ListView(
                  children: [
                    Text(
                      "Edit Address",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border.all(color: Color(0xFFF1F1FD)),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: TextField(
                        controller: authProvider.updateProfileAddress,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle:
                          TextStyle(fontSize: 16, color: Colors.black38),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          disabledColor: Colors.orange,
                          onPressed: () => Navigator.pop(context),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100, minHeight: 34.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xFFE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                          disabledColor: Colors.orange,
                          onPressed: () async {
                            Navigator.pop(context);
                            circularCustom(context);
                            AuthProvider authProvider = Provider.of<AuthProvider>(context,listen: false);
                            authProvider.updateProfileFunction(
                                context
                            ).then((value){
                              setState(() {
                                Navigator.pop(context);
                                getProfile(context);
                              });
                            });
                          },
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 100, minHeight: 34.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                )),
          );
        });
  }
}
