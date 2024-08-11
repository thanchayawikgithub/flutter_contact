import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_contact/contact.dart';

class ContactModel extends ChangeNotifier {
  static int _lastId = 1;
  final List<Contact> _items = [];
  Contact _currentContact = Contact(id: -1, name: '', phone: '', email: '');
  UnmodifiableListView<Contact> get items => UnmodifiableListView(_items);
  Contact get currentContact => _currentContact;

  void setCurrentContact(Contact contact) {
    if (contact == null) {
      _currentContact = Contact(id: -1, name: '', phone: '', email: '');
    } else {
      _currentContact = Contact(
          id: contact.id,
          name: contact.name,
          phone: contact.phone,
          email: contact.email);
    }
    notifyListeners();
  }

  void saveContact() {
    if (_currentContact.id < 0) {
      // _items.add(Contact(
      //     id: _lastId++,
      //     name: _currentContact.name,
      //     phone: _currentContact.phone,
      //     email: _currentContact.email));
      _items.add(_currentContact.copyWith(id: _lastId++));
    } else {
      int index = _items.indexWhere((c) => c.id == _currentContact.id);
      if (index != -1) {
        // _items[index] = Contact(
        //     id: _currentContact.id,
        //     name: _currentContact.name,
        //     phone: _currentContact.phone,
        //     email: _currentContact.email);
        _items[index] = _currentContact.copyWith();
      }
    }
    notifyListeners();
  }

  void deleteContact(int index) {
    int index = _items.indexWhere((c) => c.id == _currentContact.id);
    if (index != -1) {
      _items.removeAt(index);
    }
    notifyListeners();
  }
}
