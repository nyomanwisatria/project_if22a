import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_if22a/config/asset.dart';
import 'package:project_if22a/event/even_db.dart';
import 'package:project_if22a/model/mahasiswa.dart';
import 'package:project_if22a/screen/admin/add.update.mahasiswa.dart';

class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({super.key});

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  List <Mahasiswa> _listmahasiswa = [];

  void getMahasiswa() async {
    _listmahasiswa = await EventDb.getMahasiswa();

    setState(() {});
  }

  @override
  
  void initState() {
    getMahasiswa();
    super.initState();
  }
  void showOption(Mahasiswa? mahasiswa) async {
    var result = await Get.dialog(
        SimpleDialog(
          children: [
            ListTile(
              onTap: () => Get.back(result: 'update'),
              title: Text('Update'),
            ),
            ListTile(
              onTap: () => Get.back(result: 'delete'),
              title: Text('Delete'),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: Text('Close'),
            )
          ],
        ),
        barrierDismissible: false);
    switch (result) {
      case 'update':
      Get.to(AddupdateMahasiswa(mahasiswa: mahasiswa))
            ?.then((value) => getMahasiswa());
        break;
      case 'delete':
      EventDb.deleteMahasiswa(mahasiswa!.npm!)
            .then((value) => getMahasiswa());
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Mahasiswa"),
        backgroundColor: asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listmahasiswa.length > 0
              ? ListView.builder(
                  itemCount: _listmahasiswa.length,
                  itemBuilder: (context, index) {
                    Mahasiswa mahasiswa = _listmahasiswa[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(mahasiswa.nama ?? ''),
                      subtitle: Text(mahasiswa.npm ?? ''),
                      trailing: IconButton(
                          onPressed: () {
                            showOption(mahasiswa);
                          }, icon: Icon(Icons.more_vert)),
                    );
                  },
                )
              : Center(
                  child: Text("Data Kosong"),
                ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => Get.to(AddupdateMahasiswa())?.then((value) => getMahasiswa()),
              child: Icon(Icons.add),
              backgroundColor: asset.colorAccent,
            ),
          )
        ],
      ),
    );
  }
}