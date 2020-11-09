import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DakotaView extends StatefulWidget {
  final String namaKelompok;
  DakotaView(this.namaKelompok);
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
          children: [
            Text(
              "${widget.namaKelompok}",
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
                IconButton(icon: Icon(Icons.edit, color: Colors.blueAccent,), onPressed: (){},)
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Nama Kelompok", widget.namaKelompok),
            buildAccountOptionRow(context, "Nomor Register", "202011080001"),
            buildAccountOptionRow(context, "Alamat", "Jl. Mawar 12, Dukuh Wetan"),
            buildAccountOptionRow(context, "Kecamatan", "Babadan"),
            buildAccountOptionRow(context, "Kelurahan/Desa", "Japan"),
            buildAccountOptionRow(context, "Nama Ketua", "Sutejo"),
            buildAccountOptionRow(context, "Jumlah Anggota", "9 Orang"),
            buildAccountOptionRow(context, "Detail Lahan", "214 meter persegi non-sawah"),
            buildAccountOptionRow(context, "Bidang Usaha", "Hortikultura, Semangka"),
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
            buildDonation(context, "Bantuan Alsintan"),
            buildDonation(context, "Bantuan Sarana Prasarana"),
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

  GestureDetector buildDonation(BuildContext context, String title) {
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
