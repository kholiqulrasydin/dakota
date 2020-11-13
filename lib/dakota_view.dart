import 'package:dakota/dakota_edit.dart';
import 'package:dakota/model/BantuanUsahaModel.dart';
import 'package:dakota/model/DakotaModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DakotaView extends StatefulWidget {
  final int id;
  final List<DakotaModel> _dakota;
  final List<BantuanUsahaModel> _bantuanUsaha;

  DakotaView(this.id, this._dakota, this._bantuanUsaha);

  @override
  _DakotaViewState createState() => _DakotaViewState();
}

class _DakotaViewState extends State<DakotaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blueAccent,
          ),
        ),
        title: Text('Profil Kelompok', style: TextStyle(color: Colors.blueGrey),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Text(
              "${widget._dakota.first.namaKelompok}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Informasi Kelompok",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(icon: Icon(Icons.edit, color: Colors.blueAccent,), onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DakotaEditingForm(widget._dakota)));
                },)
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Nama Kelompok", widget._dakota.first.namaKelompok),
            buildAccountOptionRow(context, "Nomor Register", widget._dakota.first.nomorRegister),
            buildAccountOptionRow(context, "Alamat", widget._dakota.first.alamat),
            buildAccountOptionRow(context, "Kecamatan", widget._dakota.first.kecamatan),
            buildAccountOptionRow(context, "Kelurahan/Desa", widget._dakota.first.kelurahan),
            buildAccountOptionRow(context, "Nama Ketua", widget._dakota.first.namaKetua),
            buildAccountOptionRow(context, "Jumlah Anggota", widget._dakota.first.jumlahAnggota.toString()),
            buildAccountOptionRow(context, "Detail Lahan", widget._dakota.first.jenisLahan),
            buildAccountOptionRow(context, "Bidang Usaha", widget._dakota.first.bidangUsaha),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Icon(
                      Icons.accessibility,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Bantuan",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(icon: Icon(Icons.add, color: Colors.blueAccent,), onPressed: (){})
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget._bantuanUsaha.length,
                  itemBuilder: (context, index){
                    final _data = widget._bantuanUsaha[index];
                    return buildDonation(context, "Bantuan Alsintan", _data.id);
                  })
            ),
            SizedBox(
              height: 50,
            ),

          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildDonation(BuildContext context, String title, int id) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: (){},
                    child: Row(
                      children: <Widget>[
                        Text('Hapus', style: TextStyle(color: Colors.redAccent.shade400),),
                        Icon(Icons.delete, color: Colors.redAccent.shade400,),
                      ],
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Tutup")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountOptionRow(BuildContext context, String title, String detail) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.start,
              ),
              Text('')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                detail,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
              Text('')
            ],
          ),
        ],
      ),
    );
  }
}
