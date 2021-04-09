import 'package:equatable/equatable.dart';

class LoginRequestData extends Equatable {
  final String type;
  final String pass;
  final String userName;

  LoginRequestData(
      {required this.type, required this.pass, required this.userName});

  factory LoginRequestData.fromJson(Map<String, dynamic> json) =>
      LoginRequestData(
          type: json['type'], pass: json['pass'], userName: json['userName']);

  Map<String, dynamic> toJson() =>
      {"type": this.type, "pass": this.pass, "userName": this.userName};

  @override
  List<Object?> get props => [this.type, this.pass, this.userName];
}
