import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_if22a/config/asset.dart';
import 'package:project_if22a/event/even_db.dart';
import 'package:project_if22a/model/dosen.dart';
import 'package:project_if22a/screen/admin/list.dosen.dart';
import 'package:project_if22a/widget/info.dart';

class AddupdateDosen extends StatefulWidget {
  final Dosen? dosen;
  AddupdateDosen({this.dosen});
  @override
  State<AddupdateDosen> createState() => _AddupdateDosenState();
}

class _AddupdateDosenState extends State<AddupdateDosen> {
  var _formKey = GlobalKey<FormState>();
  var _controllerNidn = TextEditingController();
  var _controllerNama = TextEditingController();
  var _controllerAlamat = TextEditingController();
  var _controllerProdi = TextEditingController();

  bool _isHidden = true;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.dosen != null) {
      _controllerNidn.text = widget.dosen!.nidn!;
      _controllerNama.text = widget.dosen!.nama!;
      _controllerAlamat.text = widget.dosen!.alamat!;
      _controllerProdi.text = widget.dosen!.prodi!;
    }
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // titleSpacing: 0,
        title: widget.dosen!= null
            ? Text('Update Dosen')
            : Text('Tambah Dosen'),
        backgroundColor: asset.colorPrimary,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  enabled: widget.dosen == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNidn,
                  decoration: InputDecoration(
                      labelText: "NIDN",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNama,
                  decoration: InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerAlamat,
                  decoration: InputDecoration(
                      labelText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerProdi,
                  decoration: InputDecoration(
                      labelText: "Prodi",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.dosen == null) {
                        String message = await EventDb.AddDosen(
                          _controllerNidn.text,
                          _controllerNama.text,
                          _controllerAlamat.text,
                          _controllerProdi.text,
                        );
                        info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllerNidn.clear();
                          _controllerNama.clear();
                          _controllerAlamat.clear();
                          _controllerProdi.clear();
                          Get.off(
                            ListDosen(),
                          );
                        }
                      } else {
                         EventDb.UpdateDosen(
                           _controllerNidn.text,
                           _controllerNama.text,
                           _controllerAlamat.text,
                           _controllerProdi.text,
                           
                         );
                         Get.off(
                          ListDosen(),
                          );
                      }
                    }
                  },
                  child: Text(
                    widget.dosen == null ? 'Simpan' : 'Ubah',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: asset.colorAccent,
                      fixedSize: Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}