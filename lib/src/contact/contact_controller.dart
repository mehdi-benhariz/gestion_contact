import 'package:contact_gesion/src/contact/contact_services.dart';
import 'package:contact_gesion/src/contact/models.dart';
import 'package:flutter/material.dart';

class ContactController {
  final ContactService _service = ContactService();
  final ValueNotifier<List<Contact>> contactsNotifier =
      ValueNotifier<List<Contact>>([]);

  List<Contact> get contacts => contactsNotifier.value;

  void addContact(String nom, String pseudo, String numero) {
    final newContact = Contact(nom: nom, pseudo: pseudo, numero: numero);
    _service.addContact(newContact);
    contactsNotifier.value = List.from(contacts)..add(newContact);
  }

  void removeContact(Contact contact) {
    _service.removeContact(contact);
    contactsNotifier.value = List.from(contacts)..remove(contact);
  }

  void updateContact(
      Contact contact, String nom, String pseudo, String numero) {
    final updatedContact =
        contact.copyWith(nom: nom, pseudo: pseudo, numero: numero);
    _service.updateContact(updatedContact);
    contactsNotifier.value = List.from(contacts)
      ..[contacts.indexOf(contact)] = updatedContact;
  }

  void callContact(Contact contact) {
    _service.callContact(contact);
  }
}
