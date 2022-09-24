import 'package:json_annotation/json_annotation.dart';

part 'generated/contact.g.dart';

@JsonSerializable()
class Contact{

  final String phone;
  final String? fax;
  final String? email;
  final String? website;

  Contact(this.phone, {this.fax, this.email, this.website});

  static Contact fromGraphQlData(dynamic contactData){
    return Contact(
        contactData["phone"],
        fax: contactData["fax"],
        email: contactData["email"],
        website: contactData["website"],
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}