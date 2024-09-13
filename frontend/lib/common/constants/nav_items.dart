import 'package:flutter/material.dart';

const List<Map<String, dynamic>> navigationItems = [
  {
    'icon': Icons.home,
    'title': 'Home',
    'route': '/home',
    'visibleTo': [
      'ADMIN',
      'PET OWNER',
      'VERIFIED CLINIC OWNER',
      'RECEPTIONIST STAFF',
      'VETERINARIAN STAFF'
    ],
  },
  {
    'icon': Icons.local_hospital,
    'title': 'Registration Request',
    'route': '/verify_clinic_owner',
    'visibleTo': ['ADMIN']
  },
  {
    'icon': Icons.manage_accounts,
    'title': 'Staffs',
    'route': '/view_staffs',
    'visibleTo': ['VERIFIED CLINIC OWNER']
  },
  {
    'icon': Icons.book,
    'title': 'Book Appointment',
    'route': '/book_appointment',
    'visibleTo': ['PET OWNER']
  },
  {
    'icon': Icons.add,
    'title': 'Veterinarians',
    'route': '/view_veterinatians',
    'visibleTo': ['RECEPTIONIST STAFF', 'CLINIC OWNER']
  },
  {
    'icon': Icons.pets,
    'title': 'Pets',
    'route': '/view_pets',
    'visibleTo': ['PET OWNER']
  }
];
