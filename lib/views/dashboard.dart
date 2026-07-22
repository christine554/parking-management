import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/data/tenant_data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    
    final tenantData = Provider.of<TenantData>(context);

    // Get all tenants
    final tenants = tenantData.tenants;

    // ------------------------------------------------------------
    // CALCULATE DASHBOARD DATA FROM TENANT DATA
    // ------------------------------------------------------------

    // Total number of tenants
    final totalTenants = tenants.length;

    // Active tenants
    final activeTenants = tenants
        .where(
          (tenant) => tenant['status'] == 'Active',
        )
        .length;

    // Total monthly rent from active tenants
    final monthlyRevenue = tenants
        .where(
          (tenant) => tenant['status'] == 'Active',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum + (tenant['rent'] as int),
        );

    // Total rent that has been paid
    final paidAmount = tenants
        .where(
          (tenant) =>
              tenant['paymentStatus'] == 'Paid',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum + (tenant['rent'] as int),
        );

    // Total pending rent
    final pendingAmount = tenants
        .where(
          (tenant) =>
              tenant['paymentStatus'] == 'Pending',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum + (tenant['rent'] as int),
        );

    return Scaffold(
      backgroundColor: Color(0xFFF5F9FA),

      // ------------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------------

      appBar: AppBar(
        backgroundColor: Color(0xFF006978),
        foregroundColor: Colors.white,
        elevation: 0,

        title: Row(
          children: [
            Icon(
              Icons.home_work_rounded,
              size: 28,
            ),

            SizedBox(width: 10),

            Text(
              "Property Manager",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_rounded,
            ),
          ),

          SizedBox(width: 8),

          Padding(
            padding: EdgeInsets.only(
              right: 15,
            ),

            child: CircleAvatar(
              backgroundColor: Colors.white,

              child: Icon(
                Icons.person,
                color: Color(0xFF006978),
              ),
            ),
          ),
        ],
      ),

      // ------------------------------------------------------------
      // BODY
      // ------------------------------------------------------------

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),

        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1200,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // ------------------------------------------------
                // WELCOME SECTION
                // ------------------------------------------------

                Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                      colors: [
                        Color(0xFF006978),
                        Color(0xFF008FA3),
                      ],
                    ),

                    borderRadius:
                        BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,

                        blurRadius: 15,

                        offset:
                            Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      // Welcome Icon
                      Container(
                        width: 65,
                        height: 65,

                        decoration:
                            BoxDecoration(
                          color: Colors.white,

                          shape:
                              BoxShape.circle,
                        ),

                        child: Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),

                      SizedBox(width: 20),

                      // Welcome Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Text(
                              "Good Afternoon 👋",

                              style:
                                  TextStyle(
                                color:
                                    Colors.white,

                                fontSize: 27,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              "Making rental property easier to manage.",

                              style:
                                  TextStyle(
                                color:
                                    Colors.white70,

                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                
                Text(
                  "Property Overview",

                  style: TextStyle(
                    fontSize: 23,

                    fontWeight:
                        FontWeight.bold,

                    color:
                        Color(0xFF006978),
                  ),
                ),

                SizedBox(height: 15),

                
                // SUMMARY CARDS
               
                LayoutBuilder(
                  builder:
                      (context, constraints) {
                    if (constraints.maxWidth >
                        800) {
                      return Row(
                        children: [
                          Expanded(
                            child:
                                dashboardCard(
                              "Tenants",

                              totalTenants
                                  .toString(),

                              Icons
                                  .people_alt_rounded,

                              Color(
                                0xFF008FA3,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                dashboardCard(
                              "Active Tenants",

                              activeTenants
                                  .toString(),

                              Icons
                                  .person_outline_rounded,

                              Color(
                                0xFF00796B,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                dashboardCard(
                              "Rent Collected",

                              "KSh $paidAmount",

                              Icons
                                  .payments_rounded,

                              Color(
                                0xFF2E7D32,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                dashboardCard(
                              "Pending Rent",

                              "KSh $pendingAmount",

                              Icons
                                  .warning_amber_rounded,

                              Color(
                                0xFFD32F2F,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child:
                                  dashboardCard(
                                "Tenants",

                                totalTenants
                                    .toString(),

                                Icons
                                    .people_alt_rounded,

                                Color(
                                  0xFF008FA3,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            Expanded(
                              child:
                                  dashboardCard(
                                "Active Tenants",

                                activeTenants
                                    .toString(),

                                Icons
                                    .person_outline_rounded,

                                Color(
                                  0xFF00796B,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child:
                                  dashboardCard(
                                "Rent Collected",

                                "KSh $paidAmount",

                                Icons
                                    .payments_rounded,

                                Color(
                                  0xFF2E7D32,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            Expanded(
                              child:
                                  dashboardCard(
                                "Pending Rent",

                                "KSh $pendingAmount",

                                Icons
                                    .warning_amber_rounded,

                                Color(
                                  0xFFD32F2F,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 20),

                
                // TOTAL MONTHLY RENT
                
                SizedBox(
                  width: double.infinity,

                  child: dashboardCard(
                    "Expected Monthly Rent",

                    "KSh $monthlyRevenue",

                    Icons
                        .account_balance_wallet_rounded,

                    Color(0xFFE67E22),
                  ),
                ),

                SizedBox(height: 35),

                
                // RECENT PAYMENTS
             

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                  children: [
                    Text(
                      "Recent Payments",

                      style: TextStyle(
                        fontSize: 23,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Color(0xFF006978),
                      ),
                    ),

                    Text(
                      "${tenants.length} Tenants",

                      style:
                          TextStyle(
                        color:
                            Color(0xFF008FA3),

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

               
                // TENANT PAYMENT INFORMATION
               
                if (tenants.isEmpty)
                  Container(
                    width: double.infinity,

                    padding:
                        EdgeInsets.all(
                      35,
                    ),

                    decoration:
                        BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius
                              .circular(18),
                    ),

                    child: Column(
                      children: [
                        Icon(
                          Icons
                              .receipt_long_rounded,

                          size: 50,

                          color: Colors.grey,
                        ),

                        SizedBox(height: 10),

                        Text(
                          "No tenants available.",

                          style:
                              TextStyle(
                            color:
                                Colors.grey,

                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...tenants.map(
                    (tenant) {
                      final bool paid =
                          tenant[
                                  'paymentStatus'] ==
                              'Paid';

                      return paymentTile(
                        tenant['name']
                            .toString(),

                        "House ${tenant['house']}",

                        "KSh ${tenant['rent']}",

                        paid,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  // DASHBOARD CARD
  
  Widget dashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
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
            color: Colors.black,

            blurRadius: 12,

            offset:
                Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          // Icon Container
          Container(
            width: 55,
            height: 55,

            decoration:
                BoxDecoration(
              color:
                  color.withOpacity(0.12),

              borderRadius:
                  BorderRadius.circular(
                15,
              ),
            ),

            child: Icon(
              icon,

              color: color,

              size: 28,
            ),
          ),

          SizedBox(width: 15),

          // Card Information
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style:
                      TextStyle(
                    color:
                        Colors.grey,

                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  value,

                  style:
                      TextStyle(
                    fontSize: 21,

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
    );
  }

  // ------------------------------------------------------------
  // PAYMENT TILE
  // ------------------------------------------------------------

  Widget paymentTile(
    String tenant,
    String house,
    String amount,
    bool paid,
  ) {
    return Container(
      margin:
          EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          EdgeInsets.all(15),

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
                .withOpacity(0.04),

            blurRadius: 10,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // Tenant Avatar
          Container(
            width: 55,
            height: 55,

            decoration:
                BoxDecoration(
              color:
                  Color(0xFFE0F7FA),

              shape:
                  BoxShape.circle,
            ),

            child: const Icon(
              Icons.person_rounded,

              color:
                  Color(0xFF008FA3),

              size: 28,
            ),
          ),

          SizedBox(width: 15),

          // Tenant Details
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  tenant,

                  style:
                      const TextStyle(
                    fontSize: 16,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  house,

                  style:
                      TextStyle(
                    color:
                        Colors.grey,

                    fontSize: 13,
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  amount,

                  style:
                      TextStyle(
                    color:
                        Color(0xFF008FA3),

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Payment Status
          Container(
            padding:
                EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),

            decoration:
                BoxDecoration(
              color: paid
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
                  paid
                      ? Icons
                          .check_circle_outline
                      : Icons
                          .pending_outlined,

                  size: 16,

                  color: paid
                      ? Colors.green
                      : Colors.red,
                ),

                SizedBox(width: 5),

                Text(
                  paid
                      ? "Paid"
                      : "Pending",

                  style:
                      TextStyle(
                    color: paid
                        ? Colors.green
                        : Colors.red,

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}