import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_2/data/tenant_data.dart';

class RentPaymentsPage extends StatefulWidget {
  const RentPaymentsPage({super.key});

  @override
  State<RentPaymentsPage> createState() =>
      _RentPaymentsPageState();
}

class _RentPaymentsPageState
    extends State<RentPaymentsPage> {
  String selectedFilter = 'All';

  // ------------------------------------------------------------
  // FILTER TENANTS
  // ------------------------------------------------------------

  List<Map<String, dynamic>> getFilteredTenants(
    List<Map<String, dynamic>> tenants,
  ) {
    if (selectedFilter == 'Paid') {
      return tenants
          .where(
            (tenant) =>
                tenant['paymentStatus'] == 'Paid',
          )
          .toList();
    }

    if (selectedFilter == 'Pending') {
      return tenants
          .where(
            (tenant) =>
                tenant['paymentStatus'] == 'Pending',
          )
          .toList();
    }

    return tenants;
  }

  // ------------------------------------------------------------
  // RECORD PAYMENT
  // ------------------------------------------------------------

  void recordPayment(
    Map<String, dynamic> tenant,
  ) {
    final paymentDateController =
        TextEditingController();

    final referenceController =
        TextEditingController();

    String selectedMethod = 'M-Pesa';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          Colors.green.shade50,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Icon(
                      Icons.payments_outlined,
                      color:
                          Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Record Payment',
                  ),
                ],
              ),
              content: SizedBox(
                width: 450,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // Tenant
                      Container(
                        padding:
                            const EdgeInsets.all(
                          15,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.grey.shade50,
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Colors.blue
                                      .shade50,
                              child: Text(
                                tenant['name'][0]
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Colors
                                      .blue
                                      .shade700,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  tenant['name'],
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'House ${tenant['house']} • KSh ${tenant['rent']}',
                                  style: TextStyle(
                                    color: Colors
                                        .grey
                                        .shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Payment Date
                      TextField(
                        controller:
                            paymentDateController,
                        decoration:
                            InputDecoration(
                          labelText:
                              'Payment Date',
                          hintText:
                              'DD/MM/YYYY',
                          prefixIcon:
                              const Icon(
                            Icons
                                .calendar_today_outlined,
                          ),
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

                      // Payment Method
                      DropdownButtonFormField<
                          String>(
                        value:
                            selectedMethod,
                        decoration:
                            InputDecoration(
                          labelText:
                              'Payment Method',
                          prefixIcon:
                              const Icon(
                            Icons
                                .account_balance_wallet_outlined,
                          ),
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              10,
                            ),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'M-Pesa',
                            child:
                                Text('M-Pesa'),
                          ),
                          DropdownMenuItem(
                            value: 'Cash',
                            child:
                                Text('Cash'),
                          ),
                          DropdownMenuItem(
                            value: 'Bank',
                            child:
                                Text('Bank'),
                          ),
                        ],
                        onChanged: (value) {
                          setDialogState(() {
                            selectedMethod =
                                value!;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // Transaction Reference
                      TextField(
                        controller:
                            referenceController,
                        decoration:
                            InputDecoration(
                          labelText:
                              'Transaction Reference',
                          hintText:
                              'Optional',
                          prefixIcon:
                              const Icon(
                            Icons
                                .receipt_long_outlined,
                          ),
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
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (paymentDateController
                        .text
                        .isEmpty) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter the payment date.',
                          ),
                        ),
                      );
                      return;
                    }

                    final tenantData =
                        Provider.of<TenantData>(
                      context,
                      listen: false,
                    );

                    tenantData.recordPayment(
                      tenant: tenant,
                      paymentDate:
                          paymentDateController
                              .text,
                      paymentMethod:
                          selectedMethod,
                      transactionReference:
                          referenceController
                              .text,
                    );

                    Navigator.pop(
                      dialogContext,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Payment recorded for ${tenant['name']}.',
                        ),
                        behavior:
                            SnackBarBehavior
                                .floating,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.check,
                  ),
                  label: const Text(
                    'Record Payment',
                  ),
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green.shade700,
                    foregroundColor:
                        Colors.white,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // PAYMENT HISTORY
  // ------------------------------------------------------------

  void viewPaymentHistory(
    Map<String, dynamic> tenant,
  ) {
    final paymentStatus =
        tenant['paymentStatus'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),
          title: Text(
            '${tenant['name']} - Payment History',
          ),
          content: SizedBox(
            width: 450,
            child: paymentStatus == 'Paid'
                ? Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      _historyRow(
                        'Amount',
                        'KSh ${tenant['rent']}',
                        Icons.payments_outlined,
                      ),
                      _historyRow(
                        'Payment Date',
                        tenant[
                            'paymentDate'],
                        Icons
                            .calendar_today_outlined,
                      ),
                      _historyRow(
                        'Payment Method',
                        tenant[
                            'paymentMethod'],
                        Icons
                            .account_balance_wallet_outlined,
                      ),
                      _historyRow(
                        'Transaction Reference',
                        tenant[
                            'transactionReference']
                            .toString()
                            .isEmpty
                            ? 'Not provided'
                            : tenant[
                                'transactionReference'],
                        Icons
                            .receipt_long_outlined,
                      ),
                      _historyRow(
                        'Status',
                        'Paid',
                        Icons
                            .check_circle_outline,
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      Icon(
                        Icons
                            .history_toggle_off,
                        size: 60,
                        color:
                            Colors.orange.shade400,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'No payment recorded yet.',
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'This tenant currently has a pending rent payment.',
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          color: Colors
                              .grey
                              .shade600,
                        ),
                      ),
                    ],
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // HISTORY ROW
  // ------------------------------------------------------------

  Widget _historyRow(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // SEND REMINDER
  // ------------------------------------------------------------

  void sendReminder(
    Map<String, dynamic> tenant,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          'Rent reminder prepared for ${tenant['name']} (${tenant['phone']}).',
        ),
        behavior:
            SnackBarBehavior.floating,
      ),
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
            const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color:
                Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(12),
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
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors
                        .grey
                        .shade600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  value,
                  style:
                      const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
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
  // PAYMENT STATUS
  // ------------------------------------------------------------

  Widget _paymentStatus(
    String status,
  ) {
    final isPaid = status == 'Paid';

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: isPaid
            ? Colors.green.shade50
            : Colors.orange.shade50,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            isPaid
                ? Icons
                    .check_circle_outline
                : Icons
                    .pending_outlined,
            size: 16,
            color: isPaid
                ? Colors.green.shade700
                : Colors.orange.shade700,
          ),
          const SizedBox(width: 5),
          Text(
            isPaid
                ? 'Paid'
                : 'Pending',
            style: TextStyle(
              color: isPaid
                  ? Colors.green.shade700
                  : Colors.orange.shade700,
              fontWeight:
                  FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final tenantData =
        Provider.of<TenantData>(context);

    final tenants =
        tenantData.tenants;

    final filteredTenants =
        getFilteredTenants(
      tenants,
    );

    final totalRent = tenants.fold(
      0,
      (sum, tenant) =>
          sum + (tenant['rent'] as int),
    );

    final paidTenants = tenants
        .where(
          (tenant) =>
              tenant['paymentStatus'] ==
              'Paid',
        )
        .toList();

    final pendingTenants = tenants
        .where(
          (tenant) =>
              tenant['paymentStatus'] ==
              'Pending',
        )
        .toList();

    final paidAmount =
        paidTenants.fold(
      0,
      (sum, tenant) =>
          sum + (tenant['rent'] as int),
    );

    final pendingAmount =
        pendingTenants.fold(
      0,
      (sum, tenant) =>
          sum + (tenant['rent'] as int),
    );

    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FC),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(30),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              // ------------------------------------------------
              // HEADER
              // ------------------------------------------------

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
                      const Text(
                        'Rent & Payments',
                        style:
                            TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Track rent payments and payment history for every tenant',
                        style:
                            TextStyle(
                          color: Colors
                              .grey
                              .shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              // ------------------------------------------------
              // SUMMARY CARDS
              // ------------------------------------------------

              Row(
                children: [
                  _summaryCard(
                    'Total Rent',
                    'KSh $totalRent',
                    Icons
                        .account_balance_wallet_outlined,
                    Colors.blue,
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  _summaryCard(
                    'Paid',
                    'KSh $paidAmount',
                    Icons
                        .check_circle_outline,
                    Colors.green,
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  _summaryCard(
                    'Pending',
                    'KSh $pendingAmount',
                    Icons
                        .pending_outlined,
                    Colors.orange,
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  _summaryCard(
                    'Tenants',
                    tenants.length
                        .toString(),
                    Icons
                        .people_outline,
                    Colors.purple,
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              // ------------------------------------------------
              // FILTER
              // ------------------------------------------------

              Row(
                children: [
                  const Text(
                    'Filter:',
                    style:
                        TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  ChoiceChip(
                    label:
                        const Text(
                      'All',
                    ),
                    selected:
                        selectedFilter ==
                            'All',
                    onSelected: (_) {
                      setState(() {
                        selectedFilter =
                            'All';
                      });
                    },
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  ChoiceChip(
                    label:
                        const Text(
                      'Paid',
                    ),
                    selected:
                        selectedFilter ==
                            'Paid',
                    onSelected: (_) {
                      setState(() {
                        selectedFilter =
                            'Paid';
                      });
                    },
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  ChoiceChip(
                    label:
                        const Text(
                      'Pending',
                    ),
                    selected:
                        selectedFilter ==
                            'Pending',
                    onSelected: (_) {
                      setState(() {
                        selectedFilter =
                            'Pending';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // ------------------------------------------------
              // TABLE HEADER
              // ------------------------------------------------

              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
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
                        'PAYMENT STATUS',
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
                        'PAYMENT DATE',
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
                      width: 300,
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

              const SizedBox(
                height: 10,
              ),

              // ------------------------------------------------
              // TENANT PAYMENT LIST
              // ------------------------------------------------

              Expanded(
                child: filteredTenants
                        .isEmpty
                    ? Center(
                        child: Text(
                          selectedFilter ==
                                  'All'
                              ? 'No tenants found.'
                              : 'No $selectedFilter payments found.',
                          style:
                              TextStyle(
                            color: Colors
                                .grey
                                .shade600,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            filteredTenants
                                .length,
                        itemBuilder:
                            (
                          context,
                          index,
                        ) {
                          final tenant =
                              filteredTenants[
                                  index];

                          return Card(
                            elevation: 0,
                            margin:
                                const EdgeInsets
                                    .only(
                              bottom: 12,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                16,
                              ),
                              side:
                                  BorderSide(
                                color: Colors
                                    .grey
                                    .shade200,
                              ),
                            ),
                            child:
                                Padding(
                              padding:
                                  const EdgeInsets
                                      .all(
                                18,
                              ),
                              child: Row(
                                children: [
                                  // Tenant
                                  Expanded(
                                    flex: 2,
                                    child:
                                        Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.blue.shade50,
                                          child:
                                              Text(
                                            tenant[
                                                    'name'][0]
                                                .toUpperCase(),
                                            style:
                                                TextStyle(
                                              color:
                                                  Colors.blue.shade700,
                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width:
                                              12,
                                        ),
                                        Text(
                                          tenant[
                                              'name'],
                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // House
                                  Expanded(
                                    child:
                                        Text(
                                      tenant[
                                          'house'],
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  // Rent
                                  Expanded(
                                    child:
                                        Text(
                                      'KSh ${tenant['rent']}',
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  // Status
                                  Expanded(
                                    child:
                                        _paymentStatus(
                                      tenant[
                                          'paymentStatus'],
                                    ),
                                  ),

                                  // Payment Date
                                  Expanded(
                                    child:
                                        Text(
                                      tenant[
                                              'paymentDate']
                                          .toString()
                                          .isEmpty
                                          ? '—'
                                          : tenant[
                                              'paymentDate'],
                                      style:
                                          TextStyle(
                                        color: Colors
                                            .grey
                                            .shade700,
                                      ),
                                    ),
                                  ),

                                  // Actions
                                  SizedBox(
                                    width:
                                        300,
                                    child:
                                        Row(
                                      children: [
                                        if (tenant[
                                                'paymentStatus'] ==
                                            'Pending')
                                          ElevatedButton
                                              .icon(
                                            onPressed:
                                                () {
                                              recordPayment(
                                                tenant,
                                              );
                                            },
                                            icon:
                                                const Icon(
                                              Icons
                                                  .payments_outlined,
                                              size:
                                                  17,
                                            ),
                                            label:
                                                const Text(
                                              'Record Payment',
                                            ),
                                            style:
                                                ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green.shade700,
                                              foregroundColor:
                                                  Colors.white,
                                            ),
                                          ),

                                        if (tenant[
                                                'paymentStatus'] ==
                                            'Paid')
                                          IconButton(
                                            tooltip:
                                                'View Payment History',
                                            onPressed:
                                                () {
                                              viewPaymentHistory(
                                                tenant,
                                              );
                                            },
                                            icon:
                                                Icon(
                                              Icons
                                                  .history,
                                              color:
                                                  Colors.blue.shade700,
                                            ),
                                          ),

                                        IconButton(
                                          tooltip:
                                              'Send Reminder',
                                          onPressed:
                                              () {
                                            sendReminder(
                                              tenant,
                                            );
                                          },
                                          icon:
                                              Icon(
                                            Icons
                                                .notifications_none,
                                            color:
                                                Colors.orange.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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