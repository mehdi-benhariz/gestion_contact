import 'package:contact_gesion/src/contact/models.dart';
import 'package:contact_gesion/src/helpers/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';

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
    try {
      print('Calling ${contact.numero}');
      Uri uri = Uri(scheme: 'tel', path: "22232654");

      // Uri uri = Uri(scheme: 'tel', path: contact.numero);
      await launchUrl(uri);
      // await launchUrl(contact.numero as Uri);
    } catch (e) {
      print('Error calling ${contact.numero}: $e');
    }
    print('Calling ${contact.numero}');
    // var url = Uri.parse("tel:+21622232654");
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
