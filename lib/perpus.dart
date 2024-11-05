import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perpustakaan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HalamanPerpustakaan(),
    );
  }
}

class HalamanPerpustakaan extends StatefulWidget {
  @override
  _HalamanPerpustakaanState createState() => _HalamanPerpustakaanState();
}

class _HalamanPerpustakaanState extends State<HalamanPerpustakaan> {
  List<Buku> daftarBuku = [
    Buku(
      id: 1,
      judul: 'Untamed',
      deskripsi: 'Buku tentang perjalanan hidup yang penuh inspirasi.',
      stok: 3,
      fotoBuku: 'assets/untamed.png',
      penerbit: 'Penerbit A',
      pengarang: 'Glennon Doyle',
    ),
    Buku(
      id: 2,
      judul: 'Atomic Habits',
      deskripsi: 'Panduan untuk mengubah kebiasaan buruk.',
      stok: 10,
      fotoBuku: 'assets/atomic_habits.png',
      penerbit: 'Gramedia',
      pengarang: 'James Clear',
    ),
    Buku(
      id: 3,
      judul: 'Becoming',
      deskripsi: 'Biografi Michelle Obama.',
      stok: 4,
      fotoBuku: 'assets/becoming.png',
      penerbit: 'Gramedia',
      pengarang: 'Michelle Obama',
    ),
    Buku(
      id: 4,
      judul: 'National Parks',
      deskripsi: 'Buku panduan tentang taman nasional di Amerika.',
      stok: 10,
      fotoBuku: 'assets/national_parks.png',
      penerbit: 'National Geographic',
      pengarang: 'John Doe',
    ),
    Buku(
      id: 5,
      judul: 'The Power of Now',
      deskripsi: 'Panduan untuk hidup di saat ini.',
      stok: 5,
      fotoBuku: 'assets/power_of_now.png',
      penerbit: 'Penerbit B',
      pengarang: 'Eckhart Tolle',
    ),
    Buku(
      id: 6,
      judul: 'Sapiens',
      deskripsi: 'Sejarah singkat umat manusia.',
      stok: 7,
      fotoBuku: 'assets/sapiens.png',
      penerbit: 'Penerbit C',
      pengarang: 'Yuval Noah Harari',
    ),
  ];

  // Fungsi untuk menambah buku
  void tambahBuku(Buku buku) {
    setState(() {
      daftarBuku.add(buku);
    });
  }

  // Fungsi untuk mengedit buku
  void editBuku(int index, Buku bukuBaru) {
    setState(() {
      daftarBuku[index] = bukuBaru;
    });
  }

  // Fungsi untuk menghapus buku
  void hapusBuku(int index) {
    setState(() {
      daftarBuku.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perpustakaan'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormBuku(
                    onSave: (buku) => tambahBuku(buku),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, // Atur rasio aspek untuk mengontrol tinggi item
          ),
          itemCount: daftarBuku.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormBuku(
                      buku: daftarBuku[index],
                      onSave: (bukuBaru) => editBuku(index, bukuBaru),
                    ),
                  ),
                );
              },
              onLongPress: () {
                hapusBuku(index);
              },
              child: KartuBuku(buku: daftarBuku[index]),
            );
          },
        ),
      ),
    );
  }
}

class Buku {
  final int id;
  final String judul;
  final String deskripsi;
  final int stok;
  final String fotoBuku;
  final String penerbit;
  final String pengarang;

  Buku({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.stok,
    required this.fotoBuku,
    required this.penerbit,
    required this.pengarang,
  });
}

class KartuBuku extends StatelessWidget {
  final Buku buku;

  const KartuBuku({required this.buku});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              buku.fotoBuku,
              height: 196, // Sesuaikan tinggi gambar
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  buku.judul,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  'Pengarang: ${buku.pengarang}',
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Penerbit: ${buku.penerbit}',
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  buku.deskripsi,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Text(
                  'Stok: ${buku.stok} buku',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormBuku extends StatefulWidget {
  final Buku? buku;
  final Function(Buku) onSave;

  const FormBuku({this.buku, required this.onSave});

  @override
  _FormBukuState createState() => _FormBukuState();
}

class _FormBukuState extends State<FormBuku> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;
  late TextEditingController _stokController;
  late TextEditingController _fotoBukuController;
  late TextEditingController _penerbitController;
  late TextEditingController _pengarangController;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.buku?.judul ?? '');
    _deskripsiController =
        TextEditingController(text: widget.buku?.deskripsi ?? '');
    _stokController =
        TextEditingController(text: widget.buku?.stok.toString() ?? '0');
    _fotoBukuController =
        TextEditingController(text: widget.buku?.fotoBuku ?? '');
    _penerbitController =
        TextEditingController(text: widget.buku?.penerbit ?? '');
    _pengarangController =
        TextEditingController(text: widget.buku?.pengarang ?? '');
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    _stokController.dispose();
    _fotoBukuController.dispose();
    _penerbitController.dispose();
    _pengarangController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      Buku bukuBaru = Buku(
        id: widget.buku?.id ?? DateTime.now().millisecondsSinceEpoch,
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        stok: int.parse(_stokController.text),
        fotoBuku: _fotoBukuController.text,
        penerbit: _penerbitController.text,
        pengarang: _pengarangController.text,
      );
      widget.onSave(bukuBaru);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.buku == null ? 'Tambah Buku' : 'Edit Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextFormField(
                controller: _stokController,
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fotoBukuController,
                decoration: InputDecoration(labelText: 'Foto Buku'),
              ),
              TextFormField(
                controller: _penerbitController,
                decoration: InputDecoration(labelText: 'Penerbit'),
              ),
              TextFormField(
                controller: _pengarangController,
                decoration: InputDecoration(labelText: 'Pengarang'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _simpan,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
