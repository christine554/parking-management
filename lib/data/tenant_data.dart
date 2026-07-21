import 'package:flutter/foundation.dart';

class TenantData extends ChangeNotifier {
  // Shared tenant list.
  // New tenants will be added from the TenantsPage.
  final List<Map<String, dynamic>> tenants = [
    {
      'name': 'John Kamau',
      'phone': '0712345678',
      'house': 'A1',
      'rent': 15000,
      'deposit': 15000,
      'moveInDate': '01/01/2026',
      'status': 'Active',

      // Payment information
      'paymentStatus': 'Pending',
      'paymentDate': '',
      'paymentMethod': '',
      'transactionReference': '',
    },
    {
      'name': 'Mary Wanjiku',
      'phone': '0723456789',
      'house': 'A2',
      'rent': 18000,
      'deposit': 18000,
      'moveInDate': '15/02/2026',
      'status': 'Active',

      'paymentStatus': 'Paid',
      'paymentDate': '20/07/2026',
      'paymentMethod': 'M-Pesa',
      'transactionReference': 'QWE12345',
    },
    {
      'name': 'David Otieno',
      'phone': '0734567890',
      'house': 'B1',
      'rent': 12000,
      'deposit': 12000,
      'moveInDate': '10/03/2026',
      'status': 'Inactive',

      'paymentStatus': 'Pending',
      'paymentDate': '',
      'paymentMethod': '',
      'transactionReference': '',
    },
    {
      'name': 'Grace Njeri',
      'phone': '0745678901',
      'house': 'B2',
      'rent': 20000,
      'deposit': 20000,
      'moveInDate': '20/03/2026',
      'status': 'Active',

      'paymentStatus': 'Paid',
      'paymentDate': '18/07/2026',
      'paymentMethod': 'Bank',
      'transactionReference': 'BNK78901',
    },
  ];

  // ------------------------------------------------------------
  // ADD TENANT
  // ------------------------------------------------------------

  void addTenant(Map<String, dynamic> tenant) {
    tenants.add(tenant);
    notifyListeners();
  }

  // ------------------------------------------------------------
  // UPDATE TENANT
  // ------------------------------------------------------------

  void updateTenant(
    Map<String, dynamic> tenant,
    Map<String, dynamic> updatedData,
  ) {
    tenant.addAll(updatedData);
    notifyListeners();
  }

  // ------------------------------------------------------------
  // REMOVE TENANT
  // ------------------------------------------------------------

  void removeTenant(Map<String, dynamic> tenant) {
    tenants.remove(tenant);
    notifyListeners();
  }

  // ------------------------------------------------------------
  // RECORD PAYMENT
  // ------------------------------------------------------------

  void recordPayment({
    required Map<String, dynamic> tenant,
    required String paymentDate,
    required String paymentMethod,
    required String transactionReference,
  }) {
    tenant['paymentStatus'] = 'Paid';
    tenant['paymentDate'] = paymentDate;
    tenant['paymentMethod'] = paymentMethod;
    tenant['transactionReference'] = transactionReference;

    notifyListeners();
  }
}