import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/data/tenant_data.dart';

class TenantsPage extends StatefulWidget {
  const TenantsPage({super.key});

  @override
  State<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends State<TenantsPage> {
  final TextEditingController searchController =
      TextEditingController();

  List<Map<String, dynamic>> filteredTenants = [];

  
  // THEME COLORS


  static const Color primaryColor = Color(0xFF006978);
  static const Color secondaryColor = Color(0xFF008FA3);
  static const Color lightTeal = Color(0xFFE0F7FA);
  static const Color backgroundColor = Color(0xFFF5F9FA);

  
  // INITIALIZE
 
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 550,
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: lightTeal,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.person_add_alt_1_rounded,
                          color: secondaryColor,
                          size: 28,
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add New Tenant',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight:
                                    FontWeight.bold,
                                color: Color(0xFF263238),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Enter tenant details below',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  _inputField(
                    controller: nameController,
                    label: 'Tenant Name',
                    icon: Icons.person_outline_rounded,
                  ),

                  SizedBox(height: 15),

                  _inputField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 15),

                  _inputField(
                    controller: houseController,
                    label: 'House Number',
                    icon: Icons.home_outlined,
                  ),

                  SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _inputField(
                          controller: rentController,
                          label: 'Monthly Rent',
                          icon:
                              Icons.payments_outlined,
                          keyboardType:
                              TextInputType.number,
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: _inputField(
                          controller: depositController,
                          label: 'Deposit Paid',
                          icon: Icons
                              .account_balance_wallet_outlined,
                          keyboardType:
                              TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  _inputField(
                    controller: dateController,
                    label: 'Move-in Date',
                    hint: 'DD/MM/YYYY',
                    icon:
                        Icons.calendar_today_outlined,
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
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

                      SizedBox(width: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          if (nameController
                                  .text
                                  .isNotEmpty &&
                              phoneController
                                  .text
                                  .isNotEmpty &&
                              houseController
                                  .text
                                  .isNotEmpty) {
                            final tenantData =
                                Provider.of<TenantData>(
                              context,
                              listen: false,
                            );

                            tenantData.addTenant({
                              'name':
                                  nameController.text,
                              'phone':
                                  phoneController.text,
                              'house':
                                  houseController.text,
                              'rent':
                                  int.tryParse(
                                        rentController
                                            .text,
                                      ) ??
                                      0,
                              'deposit':
                                  int.tryParse(
                                        depositController
                                            .text,
                                      ) ??
                                      0,
                              'moveInDate':
                                  dateController.text,
                              'status': 'Active',
                              'paymentStatus':
                                  'Pending',
                              'paymentDate': '',
                              'paymentMethod': '',
                              'transactionReference':
                                  '',
                            });

                            setState(() {
                              filteredTenants =
                                  List.from(
                                tenantData.tenants,
                              );
                            });

                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.add_rounded,
                        ),
                        label:
                            Text('Add Tenant'),
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              primaryColor,
                          foregroundColor:
                              Colors.white,
                          padding:
                              EdgeInsets
                                  .symmetric(
                            horizontal: 22,
                            vertical: 15,
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: 550,
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.edit_rounded,
                          color:
                              Colors.orange.shade700,
                          size: 28,
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Tenant',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    Color(0xFF263238),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Update tenant information',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  _inputField(
                    controller: nameController,
                    label: 'Tenant Name',
                    icon:
                        Icons.person_outline_rounded,
                  ),

                  SizedBox(height: 15),

                  _inputField(
                    controller: phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                  ),

                  SizedBox(height: 15),

                  _inputField(
                    controller: houseController,
                    label: 'House Number',
                    icon: Icons.home_outlined,
                  ),

                  SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                        child: _inputField(
                          controller: rentController,
                          label: 'Monthly Rent',
                          icon:
                              Icons.payments_outlined,
                          keyboardType:
                              TextInputType.number,
                        ),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: _inputField(
                          controller:
                              depositController,
                          label: 'Deposit Paid',
                          icon: Icons
                              .account_balance_wallet_outlined,
                          keyboardType:
                              TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  _inputField(
                    controller: dateController,
                    label: 'Move-in Date',
                    icon:
                        Icons.calendar_today_outlined,
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

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
                              'name':
                                  nameController.text,
                              'phone':
                                  phoneController.text,
                              'house':
                                  houseController.text,
                              'rent':
                                  int.tryParse(
                                        rentController
                                            .text,
                                      ) ??
                                      0,
                              'deposit':
                                  int.tryParse(
                                        depositController
                                            .text,
                                      ) ??
                                      0,
                              'moveInDate':
                                  dateController.text,
                            },
                          );

                          setState(() {
                            filteredTenants =
                                List.from(
                              tenantData.tenants,
                            );
                          });

                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.save_rounded,
                        ),
                        label: Text(
                          'Save Changes',
                        ),
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              primaryColor,
                          foregroundColor:
                              Colors.white,
                          padding:
                              EdgeInsets
                                  .symmetric(
                            horizontal: 22,
                            vertical: 15,
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding:
                    EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red.shade600,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Remove Tenant?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove ${tenant['name']} from House ${tenant['house']}?',
          ),
          actions: [
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
                      List.from(
                    tenantData.tenants,
                  );
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    content: Text(
                      'Tenant removed. House ${tenant['house']} is now available.',
                    ),
                    behavior:
                        SnackBarBehavior.floating,
                    backgroundColor:
                        primaryColor,
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
              child:
                  const Text('Remove'),
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
        prefixIcon: Icon(
          icon,
          color: secondaryColor,
        ),
        filled: true,
        fillColor:Color(0xFFF7FAFB),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: secondaryColor,
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
    bool isActive =
        tenant['status'] == 'Active';

    return Container(
      margin:
          EdgeInsets.only(bottom: 12),
      padding:
          EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.035),
            blurRadius: 10,
            offset:
                Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: lightTeal,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                tenant['name'][0]
                    .toUpperCase(),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(width: 15),

          // Tenant
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  tenant['name'],
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                    color:
                        Color(0xFF263238),
                  ),
                ),

                SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 14,
                      color:
                          Colors.grey.shade500,
                    ),
                    SizedBox(
                        width: 5),
                    Text(
                      tenant['phone'],
                      style: TextStyle(
                        color:
                            Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: _infoColumn(
              'House',
              tenant['house'],
              Icons.home_outlined,
            ),
          ),

          Expanded(
            child: _infoColumn(
              'Monthly Rent',
              'KSh ${tenant['rent']}',
              Icons.payments_outlined,
            ),
          ),

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
              alignment:
                  Alignment.centerLeft,
              child: Container(
                padding:
                    EdgeInsets
                        .symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration:
                    BoxDecoration(
                  color: isActive
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Icon(
                      isActive
                          ? Icons
                              .check_circle_outline
                          : Icons
                              .cancel_outlined,
                      size: 15,
                      color: isActive
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                    SizedBox(width: 5),
                    Text(
                      tenant['status'],
                      style: TextStyle(
                        color: isActive
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Actions
          Row(
            children: [
              IconButton(
                tooltip:
                    'Edit Tenant',
                onPressed: () {
                  editTenant(index);
                },
                style:
                    IconButton.styleFrom(
                  backgroundColor:
                      lightTeal,
                ),
                icon: Icon(
                  Icons.edit_outlined,
                  color:
                      secondaryColor,
                  size: 20,
                ),
              ),

              SizedBox(width: 5),

              IconButton(
                tooltip:
                    'Remove Tenant',
                onPressed: () {
                  removeTenant(index);
                },
                style:
                    IconButton.styleFrom(
                  backgroundColor:
                      Colors.red.shade50,
                ),
                icon: Icon(
                  Icons.delete_outline,
                  color:
                      Colors.red.shade600,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
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
              color:
                  Colors.grey.shade500,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color:
                    Colors.grey.shade500,
              ),
            ),
          ],
        ),

        SizedBox(height: 6),

        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight:
                FontWeight.w600,
            color:
                Color(0xFF37474F),
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
        padding:
            EdgeInsets.all(20),
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color:
                Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.035),
              blurRadius: 10,
              offset:
                  Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration:
                  BoxDecoration(
                color: color
                    .withOpacity(0.1),
                borderRadius:
                    BorderRadius.circular(
                  15,
                ),
              ),
              child: Icon(
                icon,
                color: color,
                size: 26,
              ),
            ),

            SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors
                          .grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    value,
                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Color(0xFF263238),
                    ),
                  ),
                ],
              ),
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

    final tenants =
        tenantData.tenants;

    if (searchController.text.isEmpty &&
        filteredTenants.length !=
            tenants.length) {
      filteredTenants =
          List.from(tenants);
    }

    int activeTenants = tenants
        .where(
          (tenant) =>
              tenant['status'] ==
              'Active',
        )
        .length;

    int inactiveTenants = tenants
        .where(
          (tenant) =>
              tenant['status'] ==
              'Inactive',
        )
        .length;

    int monthlyRevenue = tenants
        .where(
          (tenant) =>
              tenant['status'] ==
              'Active',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum +
              (tenant['rent'] as int),
        );

    return Scaffold(
      backgroundColor:
          backgroundColor,

      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.all(30),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              
              // HEADER
              
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration:
                                BoxDecoration(
                              color:
                                  lightTeal,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                14,
                              ),
                            ),
                            child:
                                 Icon(
                              Icons.people_alt_rounded,
                              color:
                                  secondaryColor,
                              size: 25,
                            ),
                          ),

                          SizedBox(
                              width: 15),

                          Text(
                            'Tenant Management',
                            style:
                                TextStyle(
                              fontSize: 28,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  Color(
                                      0xFF263238),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                          height: 10),

                      Text(
                        'Manage tenants, leases and rental information',
                        style: TextStyle(
                          color: Colors
                              .grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  ElevatedButton.icon(
                    onPressed:
                        addTenant,
                    icon: Icon(
                      Icons
                          .person_add_alt_1_rounded,
                    ),
                    label: Text(
                      'Add Tenant',
                    ),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          primaryColor,
                      foregroundColor:
                          Colors.white,
                      padding:
                          EdgeInsets
                              .symmetric(
                        horizontal: 22,
                        vertical: 16,
                      ),
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 28),

              // ------------------------------------------------
              // SUMMARY CARDS
              // ------------------------------------------------

              Row(
                children: [
                  _summaryCard(
                    'Total Tenants',
                    tenants.length
                        .toString(),
                    Icons.people_outline,
                    secondaryColor,
                  ),

                  SizedBox(
                      width: 15),

                  _summaryCard(
                    'Active Leases',
                    activeTenants
                        .toString(),
                    Icons
                        .check_circle_outline,
                    Colors.green,
                  ),

                  SizedBox(
                      width: 15),

                  _summaryCard(
                    'Inactive Leases',
                    inactiveTenants
                        .toString(),
                    Icons
                        .cancel_outlined,
                    Colors.orange,
                  ),

                  SizedBox(
                      width: 15),

                  _summaryCard(
                    'Monthly Revenue',
                    'KSh $monthlyRevenue',
                    Icons
                        .payments_outlined,
                    Colors.purple,
                  ),
                ],
              ),

              SizedBox(height: 25),

              // ------------------------------------------------
              // SEARCH
              // ------------------------------------------------

              Container(
                height: 58,
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                  border: Border.all(
                    color: Colors
                        .grey.shade200,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                              0.025),
                      blurRadius: 8,
                      offset:
                          Offset(
                              0, 3),
                    ),
                  ],
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
                    hintStyle:
                        TextStyle(
                      color: Colors
                          .grey.shade500,
                      fontSize: 14,
                    ),
                    prefixIcon:
                        Icon(
                      Icons.search_rounded,
                      color:
                          secondaryColor,
                    ),
                    suffixIcon:
                        searchController
                                .text
                                .isNotEmpty
                            ? IconButton(
                                icon:
                                    Icon(
                                  Icons
                                      .clear_rounded,
                                ),
                                onPressed:
                                    () {
                                  searchController
                                      .clear();

                                  searchTenant(
                                      '');

                                  setState(
                                      () {});
                                },
                              )
                            : null,
                    border:
                        InputBorder.none,
                    contentPadding:
                        EdgeInsets
                            .symmetric(
                      vertical: 18,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              // ------------------------------------------------
              // TABLE HEADER
              // ------------------------------------------------

              Container(
                padding:
                    EdgeInsets
                        .symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration:
                    BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
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
                          fontSize: 11,
                          letterSpacing:
                              0.5,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'HOUSE',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 11,
                          letterSpacing:
                              0.5,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'RENT',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 11,
                          letterSpacing:
                              0.5,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'MOVE-IN DATE',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 11,
                          letterSpacing:
                              0.5,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        'STATUS',
                        style:
                            TextStyle(
                          color:
                              Colors.white,
                          fontWeight:
                              FontWeight
                                  .bold,
                          fontSize: 11,
                          letterSpacing:
                              0.5,
                        ),
                      ),
                    ),

                    SizedBox(
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
                          fontSize: 11,
                          letterSpacing:
                              0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              
              // TENANT LIST
             
              Expanded(
                child:
                    filteredTenants
                            .isEmpty
                        ? Center(
                            child:
                                Column(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: [
                                Container(
                                  width: 90,
                                  height: 90,
                                  decoration:
                                      BoxDecoration(
                                    color:
                                        lightTeal,
                                    shape:
                                        BoxShape
                                            .circle,
                                  ),
                                  child:
                                      Icon(
                                    Icons
                                        .people_outline_rounded,
                                    size: 45,
                                    color:
                                        secondaryColor,
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        18),

                                Text(
                                  'No tenants found',
                                  style:
                                      TextStyle(
                                    fontSize:
                                        18,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color:
                                        Color(
                                            0xFF37474F),
                                  ),
                                ),

                                SizedBox(
                                    height:
                                        6),

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
                        : ListView
                            .builder(
                            itemCount:
                                filteredTenants
                                    .length,
                            itemBuilder:
                                (context,
                                    index) {
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