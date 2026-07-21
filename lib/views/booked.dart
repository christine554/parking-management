import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/data/tenant_data.dart';

class TenantsPage extends StatefulWidget {
  const TenantsPage({super.key});

  @override
  State<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends State<TenantsPage> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> filteredTenants = [];

  // ------------------------------------------------------------
  // INITIALIZE
  // ------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tenantData = Provider.of<TenantData>(
        context,
        listen: false,
      );

      setState(() {
        filteredTenants = List.from(tenantData.tenants);
      });
    });
  }

  // ------------------------------------------------------------
  // SEARCH TENANT
  // ------------------------------------------------------------

  void searchTenant(String query) {
    final tenantData = Provider.of<TenantData>(
      context,
      listen: false,
    );

    final tenants = tenantData.tenants;

    setState(() {
      if (query.isEmpty) {
        filteredTenants = List.from(tenants);
      } else {
        filteredTenants = tenants.where((tenant) {
          return tenant['name']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              tenant['phone']
                  .toString()
                  .contains(query) ||
              tenant['house']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  // ------------------------------------------------------------
  // ADD TENANT
  // ------------------------------------------------------------

  void addTenant() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final houseController = TextEditingController();
    final rentController = TextEditingController();
    final depositController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 550,
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------
                  // HEADER
                  // ------------------------------------------------

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.person_add_alt_1,
                          color: Colors.blue.shade700,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add New Tenant',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Enter tenant details below',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  _inputField(
                    controller: nameController,
                    label: 'Tenant Name',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 15),

                  _inputField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 15),

                  _inputField(
                    controller: houseController,
                    label: 'House Number',
                    icon: Icons.home_outlined,
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _inputField(
                          controller: rentController,
                          label: 'Monthly Rent',
                          icon: Icons.payments_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _inputField(
                          controller: depositController,
                          label: 'Deposit Paid',
                          icon: Icons.account_balance_wallet_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  _inputField(
                    controller: dateController,
                    label: 'Move-in Date',
                    hint: 'DD/MM/YYYY',
                    icon: Icons.calendar_today_outlined,
                  ),

                  const SizedBox(height: 30),

                  // ------------------------------------------------
                  // BUTTONS
                  // ------------------------------------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty &&
                              houseController.text.isNotEmpty) {
                            final tenantData =
                                Provider.of<TenantData>(
                              context,
                              listen: false,
                            );

                            tenantData.addTenant({
                              'name': nameController.text,
                              'phone': phoneController.text,
                              'house': houseController.text,
                              'rent':
                                  int.tryParse(
                                        rentController.text,
                                      ) ??
                                      0,
                              'deposit':
                                  int.tryParse(
                                        depositController.text,
                                      ) ??
                                      0,
                              'moveInDate': dateController.text,
                              'status': 'Active',

                              // New tenant starts with pending rent
                              'paymentStatus': 'Pending',
                              'paymentDate': '',
                              'paymentMethod': '',
                              'transactionReference': '',
                            });

                            setState(() {
                              filteredTenants =
                                  List.from(tenantData.tenants);
                            });

                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Tenant'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // EDIT TENANT
  // ------------------------------------------------------------

  void editTenant(int index) {
    final tenant = filteredTenants[index];

    final nameController =
        TextEditingController(text: tenant['name']);

    final phoneController =
        TextEditingController(text: tenant['phone']);

    final houseController =
        TextEditingController(text: tenant['house']);

    final rentController =
        TextEditingController(
      text: tenant['rent'].toString(),
    );

    final depositController =
        TextEditingController(
      text: tenant['deposit'].toString(),
    );

    final dateController =
        TextEditingController(
      text: tenant['moveInDate'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 550,
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: Colors.orange.shade700,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Edit Tenant',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Update tenant information',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  _inputField(
                    controller: nameController,
                    label: 'Tenant Name',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 15),

                  _inputField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                  ),

                  const SizedBox(height: 15),

                  _inputField(
                    controller: houseController,
                    label: 'House Number',
                    icon: Icons.home_outlined,
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _inputField(
                          controller: rentController,
                          label: 'Monthly Rent',
                          icon: Icons.payments_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _inputField(
                          controller: depositController,
                          label: 'Deposit Paid',
                          icon: Icons.account_balance_wallet_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  _inputField(
                    controller: dateController,
                    label: 'Move-in Date',
                    icon: Icons.calendar_today_outlined,
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          final tenantData =
                              Provider.of<TenantData>(
                            context,
                            listen: false,
                          );

                          tenantData.updateTenant(
                            tenant,
                            {
                              'name': nameController.text,
                              'phone': phoneController.text,
                              'house': houseController.text,
                              'rent':
                                  int.tryParse(
                                        rentController.text,
                                      ) ??
                                      0,
                              'deposit':
                                  int.tryParse(
                                        depositController.text,
                                      ) ??
                                      0,
                              'moveInDate': dateController.text,
                            },
                          );

                          setState(() {
                            filteredTenants =
                                List.from(tenantData.tenants);
                          });

                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('Save Changes'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // REMOVE TENANT
  // ------------------------------------------------------------

  void removeTenant(int index) {
    final tenant = filteredTenants[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Remove Tenant?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to remove ${tenant['name']} from House ${tenant['house']}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            ElevatedButton(
              onPressed: () {
                final tenantData =
                    Provider.of<TenantData>(
                  context,
                  listen: false,
                );

                tenantData.removeTenant(tenant);

                setState(() {
                  filteredTenants =
                      List.from(tenantData.tenants);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Tenant removed. House ${tenant['house']} is now available.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // INPUT FIELD
  // ------------------------------------------------------------

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.blue.shade700,
            width: 2,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // TENANT CARD
  // ------------------------------------------------------------

  Widget _tenantCard(
    Map<String, dynamic> tenant,
    int index,
  ) {
    bool isActive = tenant['status'] == 'Active';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue.shade50,
              child: Text(
                tenant['name'][0].toUpperCase(),
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 15),

            // Tenant name and phone
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    tenant['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        tenant['phone'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // House
            Expanded(
              child: _infoColumn(
                'House',
                tenant['house'],
                Icons.home_outlined,
              ),
            ),

            // Rent
            Expanded(
              child: _infoColumn(
                'Monthly Rent',
                'KSh ${tenant['rent']}',
                Icons.payments_outlined,
              ),
            ),

            // Move-in date
            Expanded(
              child: _infoColumn(
                'Move-in Date',
                tenant['moveInDate'],
                Icons.calendar_today_outlined,
              ),
            ),

            // Status
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    tenant['status'],
                    style: TextStyle(
                      color: isActive
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            // Actions
            Row(
              children: [
                IconButton(
                  tooltip: 'Edit Tenant',
                  onPressed: () {
                    editTenant(index);
                  },
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.blue.shade700,
                  ),
                ),

                IconButton(
                  tooltip: 'Remove Tenant',
                  onPressed: () {
                    removeTenant(index);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // INFO COLUMN
  // ------------------------------------------------------------

  Widget _infoColumn(
    String title,
    String value,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: Colors.grey.shade500,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // SUMMARY CARD
  // ------------------------------------------------------------

  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 25,
              ),
            ),

            const SizedBox(width: 15),

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD UI
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final tenantData =
        Provider.of<TenantData>(context);

    final tenants = tenantData.tenants;

    // Keep filtered list synchronized
    // when the shared tenant list changes.
    if (searchController.text.isEmpty &&
        filteredTenants.length != tenants.length) {
      filteredTenants = List.from(tenants);
    }

    int activeTenants = tenants
        .where(
          (tenant) => tenant['status'] == 'Active',
        )
        .length;

    int inactiveTenants = tenants
        .where(
          (tenant) => tenant['status'] == 'Inactive',
        )
        .length;

    int monthlyRevenue = tenants
        .where(
          (tenant) => tenant['status'] == 'Active',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum + (tenant['rent'] as int),
        );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FC),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ------------------------------------------------
              // HEADER
              // ------------------------------------------------

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tenant Management',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        'Manage tenants, leases and rental information',
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  ElevatedButton.icon(
                    onPressed: addTenant,
                    icon: const Icon(
                      Icons.person_add_alt_1,
                    ),
                    label:
                        const Text('Add Tenant'),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue.shade700,
                      foregroundColor:
                          Colors.white,
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // SUMMARY CARDS
              // ------------------------------------------------

              Row(
                children: [
                  _summaryCard(
                    'Total Tenants',
                    tenants.length.toString(),
                    Icons.people_outline,
                    Colors.blue,
                  ),

                  const SizedBox(width: 15),

                  _summaryCard(
                    'Active Leases',
                    activeTenants.toString(),
                    Icons.check_circle_outline,
                    Colors.green,
                  ),

                  const SizedBox(width: 15),

                  _summaryCard(
                    'Inactive Leases',
                    inactiveTenants.toString(),
                    Icons.cancel_outlined,
                    Colors.orange,
                  ),

                  const SizedBox(width: 15),

                  _summaryCard(
                    'Monthly Revenue',
                    'KSh $monthlyRevenue',
                    Icons.payments_outlined,
                    Colors.purple,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // SEARCH
              // ------------------------------------------------

              Container(
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        Colors.grey.shade200,
                  ),
                ),
                child: TextField(
                  controller:
                      searchController,
                  onChanged:
                      searchTenant,
                  decoration:
                      InputDecoration(
                    hintText:
                        'Search by tenant name, phone number or house...',
                    prefixIcon:
                        const Icon(
                      Icons.search,
                    ),
                    suffixIcon:
                        searchController
                                .text
                                .isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(
                                  Icons.clear,
                                ),
                                onPressed: () {
                                  searchController
                                      .clear();

                                  searchTenant(
                                    '',
                                  );

                                  setState(
                                    () {},
                                  );
                                },
                              )
                            : null,
                    border:
                        InputBorder.none,
                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // TABLE HEADER
              // ------------------------------------------------

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      Colors.blue.shade700,
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'TENANT',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'HOUSE',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'RENT',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'MOVE-IN DATE',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'STATUS',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 100,
                      child: Text(
                        'ACTIONS',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ------------------------------------------------
              // TENANT LIST
              // ------------------------------------------------

              Expanded(
                child: filteredTenants.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children: [
                            Icon(
                              Icons
                                  .people_outline,
                              size: 70,
                              color: Colors
                                  .grey
                                  .shade300,
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            Text(
                              'No tenants found',
                              style:
                                  TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color: Colors
                                    .grey
                                    .shade600,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              'Try searching for another tenant.',
                              style:
                                  TextStyle(
                                color: Colors
                                    .grey
                                    .shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            filteredTenants
                                .length,
                        itemBuilder:
                            (context, index) {
                          return _tenantCard(
                            filteredTenants[
                                index],
                            index,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}