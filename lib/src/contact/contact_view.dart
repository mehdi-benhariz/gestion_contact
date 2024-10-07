import 'package:contact_gesion/src/auth/auth_ccontroller.dart';
import 'package:contact_gesion/src/contact/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'contact_controller.dart';

class ContactHomePage extends StatelessWidget {
  final ContactController controller;
  final AuthController authController;

  final TextEditingController _searchController = TextEditingController();
  ContactView() {}

  void _onSearchChanged() {
    controller.searchContacts(_searchController.text);
  }

  ContactHomePage(
      {Key? key, required this.controller, required this.authController})
      : super(key: key) {
    _searchController.addListener(_onSearchChanged);
  }
  void _deleteContact(Contact contact, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this contact?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                controller.removeContact(contact);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _updateContact(Contact contact, BuildContext context) {
    final nomController = TextEditingController(text: contact.nom);
    final pseudoController = TextEditingController(text: contact.pseudo);
    final numeroController = TextEditingController(text: contact.numero);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Contact'),
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
                controller.updateContact(contact, nomController.text,
                    pseudoController.text, numeroController.text);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _callContact(Contact contact) {
    controller.callContact(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Contact'),
              onTap: () {
                context.go('/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await authController.logout();
                context.go('/');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Contact>>(
              valueListenable: controller.contactsNotifier,
              builder: (context, contacts, child) {
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ListTile(
                      title: Text(contact.nom),
                      subtitle: Text(contact.pseudo),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _deleteContact(contact, context),
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                          IconButton(
                            onPressed: () => _callContact(contact),
                            icon: Icon(Icons.call),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () => _updateContact(contact, context),
                            icon: Icon(Icons.update),
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
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
