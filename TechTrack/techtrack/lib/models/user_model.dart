class UserModel {
  final int? usrId;
  final String usrName;
  final String usrPassword;

  UserModel({
    this.usrId,
    required this.usrName,
    required this.usrPassword,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usrPassword: json["usrPassword"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usrPassword": usrPassword,
      };
}