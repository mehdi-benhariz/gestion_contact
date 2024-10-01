import 'package:contact_gesion/src/contact/models.dart';
import 'package:contact_gesion/src/helpers/database_helper.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Contact>> getContacts() async {
    return await _dbHelper.getAllContacts();
  }

  Future<void> addContact(Contact contact) async {
    await _dbHelper.insertContact(contact);
  }

  Future<void> removeContact(String id) async {
    await _dbHelper.deleteContact(id);
  }

  Future<void> updateContact(String id, Contact updatedContact) async {
    Contact contactWithId = updatedContact.copyWith(id: id);
    await _dbHelper.updateContact(contactWithId);
  }

  // Simulate calling a contact
  Future<void> callContact(Contact contact) async {
    await FlutterPhoneDirectCaller.callNumber("+21622232654");

    print('Calling ${contact.numero}');
    // var url = Uri.parse("tel:+21622232654");
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
