import 'package:contact_gesion/src/contact/models.dart';

class ContactService {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
  }

  void removeContact(Contact contact) {
    _contacts.remove(contact);
  }

  void updateContact(Contact contact) {
    final index = _contacts.indexWhere((c) => c == contact);
    _contacts[index] = contact;
  }

  void callContact(Contact contact) {
    print('Calling ${contact.numero}');
  }
}
