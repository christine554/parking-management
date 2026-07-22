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

    final totalDeposits = tenants.fold(
      0,
      (sum, tenant) =>
          sum + (tenant['deposit'] as int),
    );

    final repairExpenses = repairs.fold(
      0,
      (sum, repair) =>
          sum + (repair['cost'] as int),
    );

    final netIncome =
        totalRentCollected - repairExpenses;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ==================================================
              // PAGE HEADER
              // ==================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Maintenance & Reports",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        "Manage property maintenance and view financial reports",
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
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

                      elevation: 0,

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

              const SizedBox(height: 30),

              // ==================================================
              // MAINTENANCE SECTION
              // ==================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Maintenance",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Track property repairs and maintenance activities",
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

              const SizedBox(height: 18),

              // ==================================================
              // REPAIR LIST
              // ==================================================

              if (repairs.isEmpty)
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(40),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),

                    border: Border.all(
                      color:
                          Colors.grey.shade200,
                    ),
                  ),

                  child: Column(
                    children: [
                      Icon(
                        Icons.build_outlined,
                        size: 60,
                        color:
                            Colors.grey.shade300,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      Text(
                        "No repairs recorded.",
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...repairs.map(
                  (repair) {
                    final bool completed =
                        repair["status"] ==
                            "Completed";

                    return _repairCard(
                      repair,
                      completed,
                    );
                  },
                ),

              const SizedBox(height: 35),

              // ==================================================
              // REPORTS SECTION
              // ==================================================

              const Text(
                "Reports",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Financial overview of your rental property",
                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // REPORT CARDS
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: _reportCard(
                      title:
                          "Total Rent Collected",
                      amount:
                          "KSh $totalRentCollected",
                      icon:
                          Icons.payments_outlined,
                      color:
                          Colors.green,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _reportCard(
                      title:
                          "Outstanding Rent",
                      amount:
                          "KSh $outstandingRent",
                      icon:
                          Icons.pending_outlined,
                      color:
                          Colors.red,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _reportCard(
                      title:
                          "Total Deposits",
                      amount:
                          "KSh $totalDeposits",
                      icon:
                          Icons.account_balance_wallet_outlined,
                      color:
                          Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _reportCard(
                      title:
                          "Repair Expenses",
                      amount:
                          "KSh $repairExpenses",
                      icon:
                          Icons.build_outlined,
                      color:
                          Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: _reportCard(
                      title:
                          "Net Income",
                      amount:
                          "KSh $netIncome",
                      icon:
                          Icons.trending_up,
                      color:
                          Colors.purple,
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child:
                        SizedBox(),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // ==================================================
              // MONTHLY REVENUE
              // ==================================================

              const Text(
                "Monthly Revenue",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Overview of rent collection across the year",
                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // REVENUE CHART CARD
              // ==================================================

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),

                  border: Border.all(
                    color:
                        Colors.grey.shade200,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.03),
                      blurRadius: 10,
                      offset:
                          const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets
                                  .all(12),

                          decoration:
                              BoxDecoration(
                            color: Colors
                                .blue
                                .shade50,

                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),

                          child: Icon(
                            Icons
                                .bar_chart_outlined,
                            color: Colors
                                .blue
                                .shade700,
                            size: 25,
                          ),
                        ),

                        const SizedBox(
                          width: 15,
                        ),

                        const Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Text(
                              "Rent Collection Overview",
                              style:
                                  TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            SizedBox(
                              height: 4,
                            ),

                            Text(
                              "Monthly revenue performance",
                              style:
                                  TextStyle(
                                color:
                                    Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
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
            ],
          ),
        ),
      ),
    );
  }

  
  // REPAIR CARD
 

  Widget _repairCard(
    Map<String, dynamic> repair,
    bool completed,
  ) {
    return Container(
      margin:
          EdgeInsets.only(bottom: 12),

      padding:
          EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.025),
            blurRadius: 8,
            offset:
                Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          // Repair Icon
          Container(
            padding:
                EdgeInsets.all(14),

            decoration:
                BoxDecoration(
              color:
                  Colors.blue.shade50,

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Icon(
              Icons.build_outlined,
              color:
                  Colors.blue.shade700,
              size: 28,
            ),
          ),

          SizedBox(width: 18),

          // Repair Information
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  "House ${repair["house"]}",

                  style:
                      TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: 6,
                ),

                Text(
                  "Problem: ${repair["problem"]}",

                  style: TextStyle(
                    color:
                        Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),

                SizedBox(
                  height: 5,
                ),

                Text(
                  "Cost: KSh ${repair["cost"]}",

                  style:
                      const TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Status
          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),

            decoration:
                BoxDecoration(
              color: completed
                  ? Colors.green.shade50
                  : Colors.orange.shade50,

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
                  completed
                      ? Icons
                          .check_circle_outline
                      : Icons
                          .pending_outlined,

                  size: 16,

                  color: completed
                      ? Colors.green.shade700
                      : Colors.orange.shade700,
                ),

                SizedBox(
                  width: 6,
                ),

                Text(
                  repair["status"],

                  style: TextStyle(
                    color: completed
                        ? Colors
                            .green
                            .shade700
                        : Colors
                            .orange
                            .shade700,

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // REPORT CARD
  
  Widget _reportCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding:
          EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.025),
            blurRadius: 8,
            offset:Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding:
                EdgeInsets.all(12),

            decoration:
                BoxDecoration(
              color:
                  color.withOpacity(0.1),

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                SizedBox(
                  height: 6,
                ),

                Text(
                  amount,

                  style:
                      TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
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
          width: 42,

          height:
              170 * height,

          decoration:
              BoxDecoration(
            color:
                Colors.blue.shade600,

            borderRadius:
                const BorderRadius.only(
              topLeft:
                  Radius.circular(8),
              topRight:
                  Radius.circular(8),
            ),
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        Text(
          month,

          style:
              TextStyle(
            fontWeight:
                FontWeight.w600,

            fontSize: 12,

            color:
                Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  
  // ADD REPAIR DIALOG
  

  void _showAddRepairDialog() {
    final houseController =
        TextEditingController();

    final problemController =
        TextEditingController();

    final costController =
        TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return Dialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              20,
            ),
          ),

          child: Container(
            width: 500,

            padding:
                EdgeInsets.all(30),

            child:
                SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  // Dialog Header
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets
                                .all(12),

                        decoration:
                            BoxDecoration(
                          color: Colors
                              .blue
                              .shade50,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                        ),

                        child: Icon(
                          Icons
                              .build_outlined,

                          color: Colors
                              .blue
                              .shade700,

                          size: 28,
                        ),
                      ),

                      SizedBox(
                        width: 15,
                      ),

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Text(
                            "Add Repair",

                            style:
                                TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          SizedBox(
                            height: 4,
                          ),

                          Text(
                            "Enter repair details below",

                            style:
                                TextStyle(
                              color:
                                  Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  // House Number
                  TextField(
                    controller:
                        houseController,

                    decoration:
                        InputDecoration(
                      labelText:
                          "House Number",

                      hintText:
                          "e.g. A3",

                      prefixIcon:
                          Icon(
                        Icons
                            .home_outlined,
                      ),

                      filled: true,

                      fillColor:
                          Colors.grey
                              .shade50,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  // Problem
                  TextField(
                    controller:
                        problemController,

                    decoration:
                        InputDecoration(
                      labelText:
                          "Problem",

                      hintText:
                          "e.g. Plumbing",

                      prefixIcon:
                          Icon(
                        Icons
                            .build_outlined,
                      ),

                      filled: true,

                      fillColor:
                          Colors.grey
                              .shade50,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Cost
                  TextField(
                    controller:costController,

                    keyboardType:
                        TextInputType.number,

                    decoration:
                        InputDecoration(
                      labelText:"Cost",

                      hintText:"e.g. 3500",

                      prefixIcon:
                          Icon(
                        Icons.payments_outlined,),

                      filled: true,

                      fillColor:
                          Colors.grey
                              .shade50,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          10,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  // Buttons
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,

                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            dialogContext,
                          );
                        },

                        child:
                            Text("Cancel",),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      ElevatedButton.icon(
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
                              dialogContext,
                            );
                          }
                        },

                        icon: Icon(
                          Icons.add,
                        ),

                        label:
                            Text(
                          "Add Repair",
                        ),

                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              Colors
                                  .blue
                                  .shade700,

                          foregroundColor:
                              Colors.white,

                          padding:
                              EdgeInsets
                                  .symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              10,
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
}