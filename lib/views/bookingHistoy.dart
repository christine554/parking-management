import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/data/tenant_data.dart';

class MaintenanceReports extends StatefulWidget {
  const MaintenanceReports({super.key});

  @override
  State<MaintenanceReports> createState() =>
      _MaintenanceReportsState();
}

class _MaintenanceReportsState
    extends State<MaintenanceReports> {

  // ------------------------------------------------------------
  // MAINTENANCE DATA
  // ------------------------------------------------------------

  final List<Map<String, dynamic>> repairs = [
    {
      "house": "A3",
      "problem": "Plumbing",
      "cost": 3500,
      "status": "Completed",
    },
    {
      "house": "B1",
      "problem": "Painting",
      "cost": 5000,
      "status": "Ongoing",
    },
    {
      "house": "C2",
      "problem": "Electrical",
      "cost": 2500,
      "status": "Completed",
    },
  ];

  @override
  Widget build(BuildContext context) {

    // ----------------------------------------------------------
    // GET SHARED TENANT DATA
    // ----------------------------------------------------------

    final tenantData =
        Provider.of<TenantData>(context);

    final tenants = tenantData.tenants;

    // ----------------------------------------------------------
    // CALCULATE REPORTS FROM TENANT DATA
    // ----------------------------------------------------------

    // Total rent collected from Paid tenants
    final totalRentCollected = tenants
        .where(
          (tenant) =>
              tenant['paymentStatus'] == 'Paid',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum + (tenant['rent'] as int),
        );

    // Outstanding rent from Pending tenants
    final outstandingRent = tenants
        .where(
          (tenant) =>
              tenant['paymentStatus'] == 'Pending',
        )
        .fold(
          0,
          (sum, tenant) =>
              sum + (tenant['rent'] as int),
        );

    // Total deposits from all tenants
    final totalDeposits = tenants.fold(
      0,
      (sum, tenant) =>
          sum + (tenant['deposit'] as int),
    );

    // Total repair expenses
    final repairExpenses = repairs.fold(
      0,
      (sum, repair) =>
          sum + (repair['cost'] as int),
    );

    // Net income
    final netIncome =
        totalRentCollected - repairExpenses;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Maintenance & Reports",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ==================================================
            // MAINTENANCE SECTION
            // ==================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  "Maintenance",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                ElevatedButton.icon(
                  onPressed:
                      _showAddRepairDialog,

                  icon: const Icon(
                    Icons.add,
                  ),

                  label: const Text(
                    "Add Repair",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // --------------------------------------------------
            // REPAIR LIST
            // --------------------------------------------------

            if (repairs.isEmpty)
              const Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(30),
                  child: Text(
                    "No repairs recorded.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            else
              ...repairs.map(
                (repair) {

                  final bool completed =
                      repair["status"] ==
                          "Completed";

                  return Card(
                    margin:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),

                    elevation: 3,

                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                        16,
                      ),

                      child: Row(
                        children: [

                          // Repair Icon
                          Container(
                            padding:
                                const EdgeInsets.all(
                              12,
                            ),

                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .blue
                                  .shade50,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                10,
                              ),
                            ),

                            child:
                                const Icon(
                              Icons.build,
                              color:
                                  Colors.blue,
                              size: 30,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          // Repair Information
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(
                                  "House ${repair["house"]}",

                                  style:
                                      const TextStyle(
                                    fontSize: 17,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(
                                  "Problem: ${repair["problem"]}",
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Text(
                                  "Cost: KSh ${repair["cost"]}",
                                ),
                              ],
                            ),
                          ),

                          // Status
                          Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),

                            decoration:
                                BoxDecoration(
                              color: completed
                                  ? Colors
                                      .green
                                      .shade100
                                  : Colors
                                      .orange
                                      .shade100,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                20,
                              ),
                            ),

                            child: Text(
                              repair["status"],

                              style:
                                  TextStyle(
                                color: completed
                                    ? Colors
                                        .green
                                        .shade800
                                    : Colors
                                        .orange
                                        .shade800,

                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(
              height: 30,
            ),

            // ==================================================
            // REPORTS SECTION
            // ==================================================

            const Text(
              "Reports",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // --------------------------------------------------
            // REPORT CARDS
            // --------------------------------------------------

            GridView.count(
              crossAxisCount: 2,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 15,

              mainAxisSpacing: 15,

              childAspectRatio: 1.5,

              children: [

                _reportCard(
                  title:
                      "Total Rent Collected",

                  amount:
                      "KSh $totalRentCollected",

                  icon:
                      Icons.payments,

                  color:
                      Colors.green,
                ),

                _reportCard(
                  title:
                      "Outstanding Rent",

                  amount:
                      "KSh $outstandingRent",

                  icon:
                      Icons.pending,

                  color:
                      Colors.red,
                ),

                _reportCard(
                  title:
                      "Total Deposits",

                  amount:
                      "KSh $totalDeposits",

                  icon:
                      Icons.account_balance_wallet,

                  color:
                      Colors.blue,
                ),

                _reportCard(
                  title:
                      "Repair Expenses",

                  amount:
                      "KSh $repairExpenses",

                  icon:
                      Icons.build,

                  color:
                      Colors.orange,
                ),

                _reportCard(
                  title:
                      "Net Income",

                  amount:
                      "KSh $netIncome",

                  icon:
                      Icons.trending_up,

                  color:
                      Colors.purple,
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            // ==================================================
            // MONTHLY REVENUE
            // ==================================================

            const Text(
              "Monthly Revenue",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Card(
              elevation: 3,

              child: Padding(
                padding:
                    const EdgeInsets.all(
                  20,
                ),

                child: Column(
                  children: [

                    const Text(
                      "Rent Collection Overview",

                      style:
                          TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 250,

                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceAround,

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .end,

                        children: [

                          _revenueBar(
                            "Jan",
                            0.6,
                          ),

                          _revenueBar(
                            "Feb",
                            0.75,
                          ),

                          _revenueBar(
                            "Mar",
                            0.5,
                          ),

                          _revenueBar(
                            "Apr",
                            0.85,
                          ),

                          _revenueBar(
                            "May",
                            0.7,
                          ),

                          _revenueBar(
                            "Jun",
                            0.9,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // REPORT CARD
  // ============================================================

  Widget _reportCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,

      child: Padding(
        padding:
            const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              color: color,
              size: 30,
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              title,

              style:
                  const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            Text(
              amount,

              style:
                  const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // REVENUE BAR
  // ============================================================

  Widget _revenueBar(
    String month,
    double height,
  ) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.end,

      children: [

        Container(
          width: 30,

          height:
              150 * height,

          decoration:
              BoxDecoration(
            color: Colors.blue,

            borderRadius:
                BorderRadius.circular(
              5,
            ),
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        Text(
          month,

          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ADD REPAIR DIALOG
  // ============================================================

  void _showAddRepairDialog() {

    final houseController =
        TextEditingController();

    final problemController =
        TextEditingController();

    final costController =
        TextEditingController();

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title:
              const Text(
            "Add Repair",
          ),

          content:
              Column(
            mainAxisSize:
                MainAxisSize.min,

            children: [

              TextField(
                controller:
                    houseController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "House Number",

                  hintText:
                      "e.g. A3",
                ),
              ),

              TextField(
                controller:
                    problemController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Problem",

                  hintText:
                      "e.g. Plumbing",
                ),
              ),

              TextField(
                controller:
                    costController,

                keyboardType:
                    TextInputType.number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Cost",

                  hintText:
                      "e.g. 3500",
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              child:
                  const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(
              onPressed: () {

                if (houseController
                        .text
                        .isNotEmpty &&
                    problemController
                        .text
                        .isNotEmpty &&
                    costController
                        .text
                        .isNotEmpty) {

                  setState(() {

                    repairs.add({

                      "house":
                          houseController
                              .text,

                      "problem":
                          problemController
                              .text,

                      "cost":
                          int.tryParse(
                                costController
                                    .text,
                              ) ??
                              0,

                      "status":
                          "Ongoing",
                    });
                  });

                  Navigator.pop(
                    context,
                  );
                }
              },

              child:
                  const Text(
                "Add",
              ),
            ),
          ],
        );
      },
    );
  }
}
