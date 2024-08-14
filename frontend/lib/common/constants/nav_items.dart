import 'package:flutter/material.dart';

const List<Map<String, dynamic>> navigationItems = [
  {
    'icon': Icons.home,
    'title': 'Home',
    'route': '/home',
    'visibleTo': [
      'admin',
      'petOwner',
      'clinicOwner',
      'receptionist',
      'veterinarian'
    ],
  },
  {
    'icon': Icons.local_hospital,
    'title': 'Registration Request',
    'route': '/verify_clinic_owner',
    'visibleTo': ['admin']
  },
  {
    'icon': Icons.manage_accounts,
    'title': 'Staffs',
    'route': '/view_staffs',
    'visibleTo': ['clinicOwner']
  },
  {
    'icon': Icons.book,
    'title': 'Book Appointment',
    'route': '/book_appointment',
    'visibleTo': ['petOwner']
  },
  {
    'icon': Icons.add,
    'title': 'Veterinarians',
    'route': '/view_veterinatians',
    'visibleTo': ['receiptionist', 'clinicOwner']
  },
  {
    'icon': Icons.pets,
    'title': 'Pets',
    'route': '/view_pets',
    'visibleTo': ['petOwner']
  }
];
