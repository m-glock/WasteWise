import 'package:json_annotation/json_annotation.dart';

part 'generated/contact.g.dart';

@JsonSerializable()
class Contact{

  final String phone;
  final String fax;
  final String email;

  Contact(this.phone, this.fax, this.email);

  static Contact fromGraphQlData(dynamic contactData){
    return Contact(
        contactData["phone"],
        contactData["fax"],
        contactData["email"]);
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}