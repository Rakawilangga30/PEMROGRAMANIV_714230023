import 'package:dio_contact/model/contact_model.dart';
import 'package:dio_contact/services/api_services.dart';
import 'package:dio_contact/view/widget/contact_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtl = TextEditingController();
  final _numberCtl = TextEditingController();
  String _result = '-';
  final ApiServices _dataService = ApiServices();
  List<ContactsModel> _contactMdl = [];
  ContactResponse? ctRes;
  bool isEdit = false; // [cite: 587]
  String idContact = ''; // [cite: 588]

  // Validasi Nama [cite: 372]
  String? _validateName(String? value) {
    if (value != null && value.length < 4) {
      return 'Masukkan minimal 4 karakter';
    }
    return null;
  }

  // Validasi Nomor HP [cite: 378]
  String? _validatePhoneNumber(String? value) {
    if (!RegExp(r'^[0-9]+$').hasMatch(value!)) {
      return 'Nomor HP harus berisi angka';
    }
    return null;
  }

  // Refresh List Data [cite: 123]
  Future<void> refreshContactList() async {
    final users = await _dataService.getAllContact();
    setState(() {
      if (_contactMdl.isNotEmpty) _contactMdl.clear();
      if (users != null) {
        _contactMdl.addAll(users.toList().reversed); // Reverse agar data baru di atas
      }
    });
  }

  // Dialog Konfirmasi Hapus [cite: 832]
  void _showDeleteConfirmationDialog(String id, String nama) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data $nama?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                ContactResponse? res = await _dataService.deleteContact(id);
                setState(() {
                  ctRes = res;
                });
                Navigator.of(context).pop();
                await refreshContactList();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts API')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtl,
                    validator: _validateName,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Nama',
                      suffixIcon: IconButton(
                        onPressed: _nameCtl.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _numberCtl,
                    validator: _validatePhoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Nomor HP',
                      suffixIcon: IconButton(
                        onPressed: _numberCtl.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 10, // Jarak antar tombol
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        if (!isValidForm) return; // [cite: 409]

                        final postModel = ContactInput(
                          namaKontak: _nameCtl.text,
                          nomorHp: _numberCtl.text,
                        );
                        
                        ContactResponse? res;
                        if (isEdit) {
                          // Logika Update [cite: 687]
                          res = await _dataService.putContact(idContact, postModel);
                        } else {
                          // Logika Insert [cite: 355]
                          res = await _dataService.postContact(postModel);
                        }

                        setState(() {
                          ctRes = res;
                          isEdit = false; // [cite: 706]
                        });
                        
                        _nameCtl.clear();
                        _numberCtl.clear();
                        await refreshContactList();
                      },
                      child: Text(isEdit ? 'UPDATE' : 'POST'), // [cite: 637]
                    ),
                    if (isEdit)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          _nameCtl.clear();
                          _numberCtl.clear();
                          setState(() {
                            isEdit = false;
                          });
                        },
                        child: const Text('Cancel Update', style: TextStyle(color: Colors.white)), // [cite: 641]
                      ),
                  ],
                ),
              ],
            ),
            // Menampilkan Hasil Response Card
            if (ctRes != null) 
              ContactCard(
                ctRes: ctRes!,
                onDismissed: () {
                  setState(() {
                    ctRes = null;
                  });
                },
              ), // [cite: 310, 529]
            
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await refreshContactList();
                    },
                    child: const Text('Refresh Data'),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _result = '-';
                      _contactMdl.clear();
                      ctRes = null;
                    });
                  },
                  child: const Text('Reset'), // [cite: 453]
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'List Contact',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: _contactMdl.isEmpty
                  ? Center(child: Text(_result)) // [cite: 190]
                  : _buildListContact(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListContact() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final ctList = _contactMdl[index];
        return Card(
          child: ListTile(
            title: Text(ctList.namaKontak),
            subtitle: Text(ctList.nomorHp),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async {
                    // Logika Klik Edit [cite: 601]
                    final contacts = await _dataService.getSingleContact(ctList.id);
                    setState(() {
                      if (contacts != null) {
                        _nameCtl.text = contacts.namaKontak;
                        _numberCtl.text = contacts.nomorHp;
                        isEdit = true;
                        idContact = contacts.id;
                      }
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(ctList.id, ctList.namaKontak);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemCount: _contactMdl.length,
    );
  }
}