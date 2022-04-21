import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/controller/homeProvider.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/authmodel.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/utils/utils.dart' as utils;

class AuthProvider with ChangeNotifier {
  AuthProvider();
  List ranking = [];
  bool _loading = false;
  final verifyEmailController = TextEditingController();
  final verifyPhoneController =
      TextEditingController(); //controller for phone number
  final forgotEmailController = TextEditingController();
  final emailController = TextEditingController(); // for login
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final resetemailController = TextEditingController();
  final resetpinemailController = TextEditingController();

  final resetcodeController = TextEditingController();
  final resetnewpinController =
      TextEditingController(); // controller for new pin
  final resetpincodeController =
      TextEditingController(); // controller for resetpin code
  final resetpasswordController = TextEditingController();
  bool resetloading = false;
  bool resetloading2 = false;
  bool resetcode = false;

  bool passwordresetsent =
      false; // to check if the request to reset password has been sent
  final resetnewpasswordController =
      TextEditingController(); // controller for new password
  final resetpasswordcodeController =
      TextEditingController(); // controller for reset password code

  final registerfullnameController = TextEditingController();
  final registerusernameController = TextEditingController();
  final registeremailController = TextEditingController();
  final registerreferralcodeController = TextEditingController(text: '');
  final registerpasswordController = TextEditingController();
  final registerconfirmpasswordController = TextEditingController();
  final phoneController = TextEditingController();

  final updateProfileFullname = TextEditingController();
  final updateProfilePhone = TextEditingController();
  final updateProfileAddress = TextEditingController();
  final updateUserName = TextEditingController();
  final updateEmail = TextEditingController();

  String loginerror = '';
  String registererror = '';
  String verifyEmailError = '';
  String forgetPassword = '';
  String resetPinError = '';
  String updateProfileError = '';

  bool loginpasswordsee = true;
  bool registerpasswordsee = true;
  bool registerconfirmpasswordsee = true;
  bool resetpinsent =
      false; // to check if the code to reset pin has been sent to email

  int count = 10;
  bool focusValue = false;
  String description = '';
  bool focusValue1 = false;
  bool focusValue2 = false;
  bool focusValue3 = false;
  bool focusValue4 = false;
  bool focusValue5 = false;
  String otp = '';

// combine all otp textfield as one
  setCombineOtpValue({cont1, cont2, cont3, cont4, cont5, cont6}) {
    otp =
        "${cont1.text}${cont2.text}${cont3.text}${cont4.text}${cont5.text}${cont6.text}";
    notifyListeners();
  }

//change textfield number on focus of otp textfield
  setOTPfocusValue({focus1, focus2, focus3, focus4, focus5, focus6}) {
    focusValue = focus1;
    focusValue1 = focus2;
    focusValue2 = focus3;
    focusValue3 = focus4;
    focusValue4 = focus5;
    focusValue5 = focus6;
    notifyListeners();
  }

  changeRanking(List ranking1) {
    ranking = ranking1;
    notifyListeners();
  }

  changeResetPinCode() {
    resetpinsent = false;
    notifyListeners();
  }

  changeLoginPasswordSee() {
    loginpasswordsee = !loginpasswordsee;
    notifyListeners();
  }

  changeRegisterPasswordSee() {
    registerpasswordsee = !registerpasswordsee;
    notifyListeners();
  }

  changeRegisterConfPasswordSee() {
    registerconfirmpasswordsee = !registerconfirmpasswordsee;
    notifyListeners();
  }

  void clearLogin() {
    emailController.text = '';
    passwordController.text = '';
    notifyListeners();
  }

  void clearRegistration() {
    registerfullnameController.text = '';
    registeremailController.text = '';
    registerreferralcodeController.text = '';
    registerpasswordController.text = '';
    registerconfirmpasswordController.text = '';
    registerconfirmpasswordController.text = '';
    phoneController.text = '';
    notifyListeners();
  }

  Future<void> updateProfileControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fullname = prefs.getString('fullname');
    String? phone = prefs.getString('phonenumber');
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    updateProfileFullname.text = fullname!;
    updateProfilePhone.text = phone!;
    updateUserName.text = username!;
    updateEmail.text = email!;
    notifyListeners();
  }

  bool get loading => _loading;
  bool login = false;
  isLoading(loading) {
    _loading = loading;
    notifyListeners();
  }

  // void showToast(themsg) {
  //   Fluttertoast.showToast(
  //       msg: themsg,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  Future storeData(String name, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, data);
  }

  Future getData(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(name);
    return data;
  }





  Future<dynamic> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http
        .get(Uri.parse('https://www.umda.mobi/accountapi/userdetails/'), headers: {
      "Content-type": "application/json",
      'Authorization': 'Token $token',
    });
    var body = json.decode(response.body);
    print(body);
    print(body);
    return body;
  }




  logoutFunction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    prefs.setString('first', 'first');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginSuccessScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  sendEmailResetPinCode(BuildContext context) async {
    // function to send the code to the email
    resetPinError = '';
    notifyListeners();
    try {
      isLoading(true);
      AuthModel authModel = AuthModel(email: resetpinemailController.text);
      var url = Uri.parse('${utils.baseUrl}/accountapi/resetpincode/');
      var response = await http.post(url, body: authModel.toJson());
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          resetPinError = errorlist.toString();
          notifyListeners();
        });
        isLoading(false);
      } else {
        resetpinsent = true;
        resetPinError = '';
        notifyListeners();

        isLoading(false);
        utils.showInSnackBar(context, 'Check your Email Address to verify');
        //utils.customDialog(context, 'Check your Email Address to verify');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Success(),
        //     ));
      }
    } catch (e) {
      print('errorrr');
      print(e);
      resetPinError = 'Unable to Verify Email';
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        resetPinError = 'Connection Timeout';
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        resetPinError = 'No Internet Connection';
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        resetPinError = 'Unable to Verify Email';
        utils.showInSnackBar(context, 'Unable to Verify Email');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  resetPinFunction(BuildContext context) async {
    // function to reset the pin after code has come
    resetPinError = '';
    notifyListeners();
    try {
      isLoading(true);
      // AuthModel authModel = AuthModel(
      //     email: resetemailController.text) ;
      Map body1 = {
        'resetcode': resetpincodeController.text,
        'password': resetnewpinController.text
      };
      var url = Uri.parse('${utils.baseUrl}/accountapi/resetpin/');
      var response = await http.post(url, body: body1);
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          resetPinError = errorlist.toString();
          notifyListeners();
        });
        isLoading(false);
      } else {
        resetPinError = '';
        // passwordresetsent = true;
        notifyListeners();

        isLoading(false);
        utils.showInSnackBar(context, 'Pin reset successful');
        utils.customDialog(context, 'Pin reset successful');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Success(),
        //     ));
      }
    } catch (e) {
      resetPinError = 'Unable to Reset Pin';
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        resetPinError = 'Connection Timeout';
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        resetPinError = 'No Internet Connection';
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        resetPinError = 'Unable to Reset Password';
        utils.showInSnackBar(context, 'Unable to Reset Password');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  verifyEmailFunction(BuildContext context) async {
    verifyEmailError = '';
    notifyListeners();
    try {
      isLoading(true);
      AuthModel authModel = AuthModel(email: verifyEmailController.text);
      var url = Uri.parse('${utils.baseUrl}/accountapi/reverifyemail/');
      var response = await http.post(url, body: authModel.toJson());
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          verifyEmailError = errorlist.toString();
          notifyListeners();
        });
        isLoading(false);
      } else {
        verifyEmailError = '';
        notifyListeners();

        isLoading(false);
        utils.showInSnackBar(context, 'Check your Email Address to verify');
        // utils.customDialog(context, 'Check your Email Address to verify');
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => VerifyEmailOtp(),
        //     ));
      }
    } catch (e) {
      verifyEmailError = 'Unable to Verify Email';
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        verifyEmailError = 'Connection Timeout';
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        verifyEmailError = 'No Internet Connection';
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        verifyEmailError = 'Unable to Verify Email';
        utils.showInSnackBar(context, 'Unable to Verify Email');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  disposePasswordReset() {
    passwordresetsent = false;
    notifyListeners();
  }

  forgetPasswordFunction(BuildContext context, String email) async {
    //function to get code to change password
    forgetPassword = '';
    notifyListeners();
    try {
      isLoading(true);

      AuthModel authModel = AuthModel(email: email);
      var url = Uri.parse('${utils.baseUrl}/accountapi/forgot-password/');
      var response = await http.post(url, body: authModel.toJson());
      int statusCode = response.statusCode;
      var body = response.body;

      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          forgetPassword = errorlist.toString();
          utils.showInSnackBar(
              context,"${forgetPassword}");
          notifyListeners();
        });
        Navigator.pop(context);
        isLoading(false);
      } else {
        forgetPassword = '';
        passwordresetsent = true;
        notifyListeners();

        isLoading(false);
        utils.showInSnackBar(
            context, 'Check your Email Address to Reset Password');
        //utils.customDialog(context, 'Check your Email Address to get code');
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Success(),
        //     ));
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      forgetPassword = 'Unable to Reset Password';
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        forgetPassword = 'Connection Timeout';
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        forgetPassword = 'No Internet Connection';
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        forgetPassword = 'Unable to Reset Password';
        utils.showInSnackBar(context, 'Unable to Reset Password');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  forgetPasswordCodeFunction(BuildContext context) async {
    // function to reset the password after code has come
    forgetPassword = '';
    notifyListeners();
    try {
      isLoading(true);
      // AuthModel authModel = AuthModel(
      //     email: resetemailController.text) ;
      Map body1 = {
        'resetcode': resetpasswordcodeController.text,
        'password': resetnewpasswordController.text
      };
      print(body1);
      var url = Uri.parse('${utils.baseUrl}/accountapi/resetpassword/');
      var response = await http.post(url, body: body1);
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          forgetPassword = errorlist.toString();
          notifyListeners();
        });
        isLoading(false);
      } else {
        forgetPassword = '';
        passwordresetsent = true;
        notifyListeners();

        isLoading(false);
        utils.showInSnackBar(context, 'Password reset successful');
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ResetPinSuccess(),
        //     ));
      }
    } catch (e) {
      forgetPassword = 'Unable to Reset Password';
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        forgetPassword = 'Connection Timeout';
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        forgetPassword = 'No Internet Connection';
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        forgetPassword = 'Unable to Reset Password';
        utils.showInSnackBar(context, 'Unable to Reset Password');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  registerFunction(BuildContext context) async {
    registererror = '';
    notifyListeners();
    try {
      isLoading(true);
      AuthModel authModel = AuthModel(
          email: registeremailController.text,
          password: registerpasswordController.text,
          fullname: registerfullnameController.text,
          confirmPassword: registerconfirmpasswordController.text,
      );
      var url = Uri.parse('${utils.baseUrl}/accountapi/createuser/');
      print(authModel.toJson());
      var response = await http.post(url, body: authModel.toJson());
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      if (statusCode >= 400) {
        Navigator.pop(context);
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          print('Key = $key : Value = $value');
          registererror = errorlist.toString();
          notifyListeners();
        });


        Fluttertoast.showToast(
          msg: "${registererror}",

        );
        isLoading(false);
      } else {
        registererror = '';
        notifyListeners();
        String message = theResponse['message'];
        print(message);
        isLoading(false);
        utils.showMyDialog(
            context, "assets/img/checklist.png", 'Success', '$message');
        utils.showInSnackBar(context, '$message');
        // utils.customDialog(context, 'Registration Successful, Check your email to verify');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ),
        );
        // Fluttertoast.showToast(
        //     msg: "${message}",
        //
        // );
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      registererror = 'Unable to Register';
      notifyListeners();
      if (e.runtimeType == HandshakeException) {
        registererror = 'Connection Timeout';
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        registererror = 'No Internet Connection';
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        registererror = 'Unable to Register';
        utils.showInSnackBar(context, 'Unable to Register');
      }
      isLoading(false);
      notifyListeners();
    }
  }

  loginFunction(BuildContext context) async {
    loginerror = '';
    notifyListeners();
    try {
      isLoading(true);
      AuthModel authModel = AuthModel(
          email: emailController.text, password: passwordController.text);
      var url = Uri.parse('${utils.baseUrl}/accountapi/login/');
      var response = await http.post(url, body: authModel.toJson());
      int statusCode = response.statusCode;
      var body = response.body;
      Map<String, dynamic> theResponse = jsonDecode(body);
      print(theResponse);
      print('respo');
      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = theResponse['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          loginerror = errorlist.toString();
          notifyListeners();
        });
        isLoading(false);
        utils.showToast(errorlist.toString());
        
      } else {
        loginerror = '';
        notifyListeners();
        String token = theResponse['token'];
        String email = theResponse['email'];
        String fullname = theResponse['fullname'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print(token);
        await prefs.setString('email', email);
        await prefs.setString('fullname', fullname);
        isLoading(false);
        utils.showInSnackBar(context, 'Login Successful');

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      }
    }
    //catch (SocketException){}
    catch (e) {
      loginerror = 'Unable to login';
      if (e.runtimeType == HandshakeException) {
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        utils.showInSnackBar(context, 'No Internet Connection');
      } else {
        utils.showInSnackBar(context, 'Unable to Proceed');
      }
      notifyListeners();
      isLoading(false);
      utils.showInSnackBar(context, e.toString());
    }
  }





  Future<dynamic> updateProfileFunction(BuildContext context) async {
    updateProfileError = '';
    notifyListeners();
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Map<String, String> requestHeaders = {'Authorization': 'Token $token'};
      AuthModel authModel = AuthModel(
        address: updateProfileAddress.text,
          phone: updateProfilePhone.text,
          fullname: updateProfileFullname.text);
      var url = Uri.parse('${utils.baseUrl}/accountapi/userdetails/');
      var response = await http.patch(url,
          body: authModel.toJson(), headers: requestHeaders);
      int statusCode = response.statusCode;
      var body1 = jsonDecode(response.body);
      // Map<String, dynamic> theResponse = jsonDecode(body);

      if (statusCode >= 400) {
        List errorlist = [];
        Map<String, dynamic> message = body1['message'];
        message.forEach((key, value) {
          String error = '${value.toString()}';
          errorlist.add(error);
          updateProfileError = errorlist.toString();
          notifyListeners();
        });
        Fluttertoast.showToast(
          msg: "${message}",
        );
        //
        // isLoading(false);
      } else {
        updateProfileError = '';
        notifyListeners();
        Map<String, dynamic> message = body1['message'];
        await prefs.setString('fullname', message['fullname']);
        await prefs.setString('phonenumber', message['phonenumber']);
        Fluttertoast.showToast(
            msg: "Updated Successfully",

        );
      }
    }
    //catch (SocketException){}
    catch (e) {
      updateProfileError = 'Unable to login';
      if (e.runtimeType == HandshakeException) {
        utils.showInSnackBar(context, 'Connection Timeout');
      } else if (e.runtimeType == SocketException) {
        utils.showInSnackBar(context, 'No Internet Connection');
      }
    }
  }
}
