import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:project_if22a/config/asset.dart';
import 'package:project_if22a/event/even_db.dart';
import 'package:project_if22a/model/dosen.dart';
import 'package:project_if22a/screen/admin/add.update.dosen.dart';

class ListDosen extends StatefulWidget {
  const ListDosen({super.key});

  @override
  State<ListDosen> createState() => _ListDosenState();
}

class _ListDosenState extends State<ListDosen> {
  List <Dosen> _listdosen= [];

  void getDosen() async {
    _listdosen = await EventDb.getDosen();

    setState(() {});
  }

  @override
  
  void initState() {
    getDosen();
    super.initState();
  }
  void showOption(Dosen? dosen) async {
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
      Get.to(AddupdateDosen(dosen : dosen))
            ?.then((value) => getDosen());
        break;
      case 'delete':
      EventDb.deleteDosen(dosen!.nidn!)
            .then((value) => getDosen());
        break;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Dosen"),
        backgroundColor: asset.colorPrimary,
      ),
      body: Stack(
        children: [
          _listdosen.length > 0
              ? ListView.builder(
                  itemCount: _listdosen.length,
                  itemBuilder: (context, index) {
                    Dosen dosen = _listdosen[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(dosen.nama ?? ''),
                      subtitle: Text(dosen.nidn ?? ''),
                      trailing: IconButton(
                          onPressed: () {
                            showOption(dosen);
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
              onPressed: () => Get.to(AddupdateDosen())?.then((value) => getDosen()),
              child: Icon(Icons.add),
              backgroundColor: asset.colorAccent,
            ),
          )
        ],
      ),
    );
  }
}