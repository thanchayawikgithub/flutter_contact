import 'package:flutter/material.dart';

class AddContactWidget extends StatefulWidget {
  const AddContactWidget({Key? key}) : super(key: key);

  @override
  _AddContactWidgetState createState() => _AddContactWidgetState();
}

class _AddContactWidgetState extends State<AddContactWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Contact')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: 'Phone', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Process Data')));
                  }
                },
                child: Text('Add Contact'))
          ],
        ),
      ),
    );
  }
}
