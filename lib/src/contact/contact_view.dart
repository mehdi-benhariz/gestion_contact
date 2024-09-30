import 'package:contact_gesion/src/contact/models.dart';
import 'package:flutter/material.dart';
import 'contact_controller.dart';

class ContactHomePage extends StatelessWidget {
  final ContactController controller;

  ContactHomePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ValueListenableBuilder<List<Contact>>(
        valueListenable: controller.contactsNotifier,
        builder: (context, contacts, child) {
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                title: Text(contact.nom),
                subtitle: Text(contact.pseudo),
                trailing: Text(contact.numero),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final nomController = TextEditingController();
    final pseudoController = TextEditingController();
    final numeroController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contact'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: pseudoController,
                decoration: InputDecoration(labelText: 'Pseudo'),
              ),
              TextField(
                controller: numeroController,
                decoration: InputDecoration(labelText: 'Numéro'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.addContact(
                  nomController.text,
                  pseudoController.text,
                  numeroController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
