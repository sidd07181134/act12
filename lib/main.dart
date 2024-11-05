import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(InventoryApp());
}

class DefaultFirebaseOptions {
  static var currentPlatform;
}

class InventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InventoryHomePage(title: 'Inventory Home Page'),
    );
  }
}

class InventoryHomePage extends StatefulWidget {
  final String title;
  InventoryHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _InventoryHomePageState createState() => _InventoryHomePageState();
}

class _InventoryHomePageState extends State<InventoryHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _addItem() async {
    await FirebaseFirestore.instance.collection('inventory').add({
      'name': _nameController.text,
      'quantity': int.tryParse(_quantityController.text) ?? 0,
    });

    _nameController.clear();
    _quantityController.clear();
  }

  void _updateItem(String docId) async {
    await FirebaseFirestore.instance.collection('inventory').doc(docId).update({
      'name': _nameController.text,
      'quantity': int.tryParse(_quantityController.text) ?? 0,
    });

    _nameController.clear();
    _quantityController.clear();
  }

  void _deleteItem(String docId) async {
    await FirebaseFirestore.instance.collection('inventory').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('inventory').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return ListTile(
                      title: Text(document['name']),
                      subtitle: Text('Quantity: ${document['quantity']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _nameController.text = document['name'];
                              _quantityController.text = document['quantity'].toString();
                              _updateItem(document.id);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteItem(document.id),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          ElevatedButton(
            onPressed: _addItem,
            child: const Text('Add Item'),
          )
        ],
      ),
    );
  }
}
