import 'package:flutter/material.dart';
import 'package:my_contact/add_contact_widget.dart';
import 'package:my_contact/contact.dart';
import 'package:my_contact/contact_provider.dart';
import 'package:my_contact/edit_contact_widget.dart';
import 'package:provider/provider.dart';

class ContactWidget extends StatefulWidget {
  const ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
      return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Contact"),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.abc),
              ),
              Tab(
                icon: Icon(Icons.abc_outlined),
              )
            ]),
          ),
          body: TabBarView(
            children: [
              ContactListView1(),
              ContactListView2(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddContactWidget();
              }));
            },
          ),
        ),
      );
    });
  }
}

class ContactListView1 extends StatelessWidget {
  const ContactListView1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading:
                CircleAvatar(child: Text(contactProvider.items[index].name[0])),
            title: Text(contactProvider.items[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contactProvider.items[index].phone),
                Text(contactProvider.items[index].email)
              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Contact'),
                        content: Text(
                            'Are you sure you want to delete this contact?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                Provider.of<ContactProvider>(context,
                                        listen: false)
                                    .deleteContact(index);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'))
                        ],
                      );
                    },
                  );
                }),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                final provider =
                    Provider.of<ContactProvider>(context, listen: false);
                provider.setCurrentContact(provider.items[index]);
                return EditContactWidget();
              }));
            },
          );
        },
        itemCount: contactProvider.items.length,
      );
    });
  }
}

class ContactListView2 extends StatelessWidget {
  const ContactListView2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // จำนวนคอลัมน์ในกริด
            crossAxisSpacing: 8.0, // ระยะห่างระหว่างคอลัมน์
            mainAxisSpacing: 8.0, // ระยะห่างระหว่างแถว
          ),
          itemCount: contactProvider.items.length,
          itemBuilder: (context, index) {
            final contact =
                contactProvider.items[index]; // ดึงข้อมูล Contact ที่ index
            return Card(
              color: const Color.fromARGB(255, 42, 22, 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 8,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child:
                          Text(contact.name.isNotEmpty ? contact.name[0] : '?'),
                      backgroundColor: Color(4286731539),
                      foregroundColor: Color(4294958520),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      contact.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(4292134069),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      contact.phone,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      contact.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
