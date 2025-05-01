import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

void main() {
  runApp(const ContactsApp());
}

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Контакти',
      home: ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late Database db;
  List<Map<String, dynamic>> contacts = [];
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setupDB();
  }

  Future<void> setupDB() async {
    db = await DatabaseHelper.initDB();
    refreshContacts();
  }

  void refreshContacts() async {
    final data = await DatabaseHelper.getContacts(db);
    setState(() => contacts = data);
  }

  void saveContact() async {
    final name = nameController.text;
    final phone = phoneController.text;
    if (name.isNotEmpty && phone.isNotEmpty) {
      await DatabaseHelper.addContact(db, name, phone);
      nameController.clear();
      phoneController.clear();
      refreshContacts();
    }
  }

  void deleteContact(int id) async {
    await DatabaseHelper.deleteContact(db, id);
    refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Контакти')),
      body: Column(
        children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Імʼя')),
          TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Телефон')),
          ElevatedButton(onPressed: saveContact, child: const Text('Зберегти')),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  title: Text('${contact['name']}'),
                  subtitle: Text('${contact['phone']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteContact(contact['id']),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
