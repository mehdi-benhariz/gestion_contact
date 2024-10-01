import 'package:contact_gesion/src/contact/contact_services.dart';
import 'package:contact_gesion/src/contact/models.dart';
import 'package:flutter/material.dart';

class ContactController {
  final ContactService _service = ContactService();
  final ValueNotifier<List<Contact>> contactsNotifier =
      ValueNotifier<List<Contact>>([]);

  List<Contact> get contacts => contactsNotifier.value;

  // Fetch all contacts and update the notifier
  Future<void> loadContacts() async {
    final fetchedContacts = await _service.getContacts();
    contactsNotifier.value = fetchedContacts;
  }

  // Add a new contact
  Future<void> addContact(String nom, String pseudo, String numero) async {
    final newContact = Contact(nom: nom, pseudo: pseudo, numero: numero);
    await _service.addContact(newContact);
    contactsNotifier.value = List.from(contacts)..add(newContact);
  }

  // Remove a contact
  Future<void> removeContact(Contact contact) async {
    await _service.removeContact(contact.id);
    contactsNotifier.value = List.from(contacts)..remove(contact);
  }

  // Update an existing contact
  Future<void> updateContact(
      Contact contact, String nom, String pseudo, String numero) async {
    final updatedContact =
        contact.copyWith(nom: nom, pseudo: pseudo, numero: numero);
    await _service.updateContact(contact.id, updatedContact);
    contactsNotifier.value = List.from(contacts)
      ..[contacts.indexOf(contact)] = updatedContact;
  }

  // Simulate calling a contact
  void callContact(Contact contact) {
    _service.callContact(contact);
  }

  // Search for contacts
  void searchContacts(String query) async {
    if (query.isEmpty) {
      await loadContacts(); // Reload all contacts if search query is empty
    } else {
      final filteredContacts = contacts.where((contact) {
        return contact.nom.toLowerCase().contains(query.toLowerCase()) ||
            contact.pseudo.toLowerCase().contains(query.toLowerCase()) ||
            contact.numero.toLowerCase().contains(query.toLowerCase());
      }).toList();
      contactsNotifier.value = filteredContacts;
    }
  }
}
