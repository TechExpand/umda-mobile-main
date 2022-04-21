class AuthModel {
  String? email;
  String? password;
  String? fullname;
  String? confirmPassword;
  String? phonenumber;
  String? id;
  String? activated;
  String? username;
  String? referralcode;
  String? address;
  String?phone;


  AuthModel({this.referralcode,this.phone, this.address, this.username, this.activated, this.id, this.email, this.password, this.fullname, this.confirmPassword,  this.phonenumber});

  @override
  String toString() {
    return 'AuthModel{username: $username, referralcode: $referralcode, email: $email, password: $password, fullname: $fullname, confirmPassword: $confirmPassword, phonenumber: $phonenumber, id: $id}';
  }


  factory AuthModel.fromJson(Map<String, dynamic> json){
    return AuthModel(
      address: json["street_address"],
      email: json['email'],
      password: json['password'],
      fullname: json['fullname'],
      confirmPassword: json['confirmPassword'],
      phonenumber: json['phonenumber'],
      phone: json["phone"],
      id: json['id'],
      activated: json['activated'],
      username: json['username'],
      referralcode: json['referralcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email ?? '',
      "password": this.password ?? '',
      "fullname": this.fullname ?? '',
      "confirmPassword": this.confirmPassword ?? '',
      "phonenumber": this.phonenumber ?? '',
      "street_address": this.address??"",
      "phone":this.phone??"",
      "id": this.id ?? '',
      "activated": this.activated ?? '',
      "username": this.username ?? '',
      "referralcode": this.referralcode ?? '',
    };
  }
}