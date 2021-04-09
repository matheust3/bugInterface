import 'package:equatable/equatable.dart';

class LoginResponseData extends Equatable {
  final String token;

  LoginResponseData({required this.token});

  @override
  List<Object?> get props => [this.token];

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      LoginResponseData(token: json['token']);

  Map<String, dynamic> toJson() => {'token': this.token};
}
