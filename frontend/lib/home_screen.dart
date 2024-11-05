import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> items = []; // List untuk menyimpan item
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _npmController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();

  // Fungsi untuk menambahkan item
  void _createItem(String name, String npm, String prodi, String asal) {
    setState(() {
      items.add({
        'name': name,
        'npm': npm,
        'prodi': prodi,
        'asal': asal,
      });
    });
    _clearControllers();
  }

  // Fungsi untuk mengupdate item
  void _updateItem(
      int index, String name, String npm, String prodi, String asal) {
    setState(() {
      items[index] = {
        'name': name,
        'npm': npm,
        'prodi': prodi,
        'asal': asal,
      };
    });
    _clearControllers();
  }

  // Fungsi untuk menghapus item
  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  // Fungsi untuk mengosongkan controller
  void _clearControllers() {
    _nameController.clear();
    _npmController.clear();
    _prodiController.clear();
    _asalController.clear();
  }

  // Fungsi untuk menampilkan dialog tambah/edit item
  void _showItemDialog({int? index}) {
    if (index != null) {
      _nameController.text = items[index]['name']!;
      _npmController.text = items[index]['npm']!;
      _prodiController.text = items[index]['prodi']!;
      _asalController.text = items[index]['asal']!;
    } else {
      _clearControllers(); // Kosongkan teks untuk tambah
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add Item' : 'Edit Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter Name'),
            ),
            TextField(
              controller: _npmController,
              decoration: const InputDecoration(hintText: 'Enter NPM'),
            ),
            TextField(
              controller: _prodiController,
              decoration: const InputDecoration(hintText: 'Enter Prodi'),
            ),
            TextField(
              controller: _asalController,
              decoration: const InputDecoration(hintText: 'Enter Asal'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _npmController.text.isNotEmpty) {
                if (index == null) {
                  _createItem(_nameController.text, _npmController.text,
                      _prodiController.text, _asalController.text);
                } else {
                  _updateItem(index, _nameController.text, _npmController.text,
                      _prodiController.text, _asalController.text);
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(index == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]['name']!),
            subtitle: Text(
                'NPM: ${items[index]['npm']}, Prodi: ${items[index]['prodi']}, Asal: ${items[index]['asal']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showItemDialog(index: index), // Edit item
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteItem(index), // Delete item
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(), // Add item
        child: const Icon(Icons.add),
      ),
    );
  }
}
