class Contact{

  final String phone;
  final String fax;
  final String email;

  Contact(this.phone, this.fax, this.email);

  static Contact fromJson(dynamic contactData){
    return Contact(
        contactData["phone"],
        contactData["fax"],
        contactData["email"]);
  }
}