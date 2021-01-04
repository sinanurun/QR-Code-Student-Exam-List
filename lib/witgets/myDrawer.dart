import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add_to_home_screen,
                    color: Colors.white,
                    size: 100.0,
                  ),
                  Text(
                    "Qr Yoklama Uygulaması",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          ExpansionTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Öğrenci İşlemleri'),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              ListTile(
                title: Text('Öğrenci Listem'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/ogrencilistesi");
                },
              ),
              ListTile(
                title: Text('Öğrenci Ekle'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/ogrenciekle");
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Sınav İşlemleri'),
            trailing: Icon(Icons.arrow_drop_down),
            children: <Widget>[
              ListTile(
                title: Text('Sınav Listem'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/sinavlistesi");
                },
              ),
              ListTile(
                title: Text('Sınav Ekle'),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  Navigator.pushNamed(context, "/sinavekle");
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.local_laundry_service),
            title: Text('Sınav Raporlarım'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, "/raporlar");
            },
          ),
        ],
      ),
    );
  }
}
