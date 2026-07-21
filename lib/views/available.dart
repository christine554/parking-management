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
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(24),
              ),
              child: Container(
                width: 500,
                padding:
                    const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // ------------------------------------------------
                      // DIALOG HEADER
                      // ------------------------------------------------

                      Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration:
                                BoxDecoration(
                              color:
                                  const Color(
                                0xFFE0F7FA,
                              ),
                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),
                            ),
                            child: const Icon(
                              Icons
                                  .payments_rounded,
                              color:
                                  Color(
                                0xFF008FA3,
                              ),
                              size: 28,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  'Record Payment',
                                  style:
                                      TextStyle(
                                    fontSize: 23,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color:
                                        Color(
                                      0xFF263238,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Enter payment details for this tenant',
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      // ------------------------------------------------
                      // TENANT INFORMATION
                      // ------------------------------------------------

                      Container(
                        padding:
                            const EdgeInsets.all(
                          16,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFFF5F9FA,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                          border: Border.all(
                            color:
                                Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundColor:
                                  const Color(
                                0xFFE0F7FA,
                              ),
                              child: Text(
                                tenant['name'][0]
                                    .toUpperCase(),
                                style:
                                    const TextStyle(
                                  color:
                                      Color(
                                    0xFF008FA3,
                                  ),
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 14,
                            ),

                            Expanded(
                              child: Column(
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
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    'House ${tenant['house']} • KSh ${tenant['rent']}',
                                    style:
                                        TextStyle(
                                      color: Colors
                                          .grey
                                          .shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      // ------------------------------------------------
                      // PAYMENT DATE
                      // ------------------------------------------------

                      _dialogInputField(
                        controller:
                            paymentDateController,
                        label:
                            'Payment Date',
                        hint:
                            'DD/MM/YYYY',
                        icon: Icons
                            .calendar_today_outlined,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // ------------------------------------------------
                      // PAYMENT METHOD
                      // ------------------------------------------------

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
                            color:
                                Color(
                              0xFF008FA3,
                            ),
                          ),
                          filled: true,
                          fillColor:
                              const Color(
                            0xFFF7F9FA,
                          ),
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              14,
                            ),
                            borderSide:
                                BorderSide
                                    .none,
                          ),
                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              14,
                            ),
                            borderSide:
                                BorderSide
                                    .none,
                          ),
                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              14,
                            ),
                            borderSide:
                                const BorderSide(
                              color:
                                  Color(
                                0xFF008FA3,
                              ),
                              width: 2,
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

                      // ------------------------------------------------
                      // TRANSACTION REFERENCE
                      // ------------------------------------------------

                      _dialogInputField(
                        controller:
                            referenceController,
                        label:
                            'Transaction Reference',
                        hint:
                            'Optional',
                        icon: Icons
                            .receipt_long_outlined,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      // ------------------------------------------------
                      // BUTTONS
                      // ------------------------------------------------

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
                                const Text(
                              'Cancel',
                              style:
                                  TextStyle(
                                color:
                                    Colors.grey,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          ElevatedButton.icon(
                            onPressed: () {
                              if (paymentDateController
                                  .text
                                  .isEmpty) {
                                ScaffoldMessenger
                                    .of(
                                  context,
                                ).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text(
                                      'Please enter the payment date.',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final tenantData =
                                  Provider.of<
                                      TenantData>(
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

                              ScaffoldMessenger
                                  .of(
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
                              Icons.check_rounded,
                            ),
                            label:
                                const Text(
                              'Record Payment',
                            ),
                            style:
                                ElevatedButton
                                    .styleFrom(
                              backgroundColor:
                                  const Color(
                                0xFF00897B,
                              ),
                              foregroundColor:
                                  Colors.white,
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
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
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // DIALOG INPUT FIELD
  // ------------------------------------------------------------

  Widget _dialogInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: const Color(
            0xFF008FA3,
          ),
        ),
        filled: true,
        fillColor: const Color(
          0xFFF7F9FA,
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide:
              const BorderSide(
            color:
                Color(0xFF008FA3),
            width: 2,
          ),
        ),
      ),
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
        return Dialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),
          child: Container(
            width: 480,
            padding:
                const EdgeInsets.all(30),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration:
                          const BoxDecoration(
                        color:
                            Color(0xFFE0F7FA),
                        shape:
                            BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        color:
                            Color(0xFF008FA3),
                      ),
                    ),

                    const SizedBox(
                      width: 15,
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            '${tenant['name']}',
                            style:
                                const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Payment History',
                            style:
                                TextStyle(
                              color: Colors
                                  .grey
                                  .shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                paymentStatus == 'Paid'
                    ? Column(
                        children: [
                          _historyRow(
                            'Amount',
                            'KSh ${tenant['rent']}',
                            Icons
                                .payments_outlined,
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
                        children: [
                          Container(
                            width: 75,
                            height: 75,
                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .orange
                                  .shade50,
                              shape:
                                  BoxShape.circle,
                            ),
                            child: Icon(
                              Icons
                                  .history_toggle_off,
                              size: 40,
                              color: Colors
                                  .orange
                                  .shade400,
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          const Text(
                            'No payment recorded yet.',
                            textAlign:
                                TextAlign.center,
                            style:
                                TextStyle(
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
                            style:
                                TextStyle(
                              color: Colors
                                  .grey
                                  .shade600,
                            ),
                          ),
                        ],
                      ),

                const SizedBox(
                  height: 25,
                ),

                Align(
                  alignment:
                      Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child:
                        const Text(
                      'Close',
                    ),
                  ),
                ),
              ],
            ),
          ),
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
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      padding:
          const EdgeInsets.all(14),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFFF7F9FA),
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color:
                const Color(0xFF008FA3),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign:
                  TextAlign.right,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
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
              BorderRadius.circular(18),
          border: Border.all(
            color:
                Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.04),
              blurRadius: 12,
              offset:
                  const Offset(0, 5),
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
                color:
                    color.withOpacity(
                  0.1,
                ),
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

            const SizedBox(
              width: 15,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
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
                    overflow:
                        TextOverflow.ellipsis,
                    style:
                        const TextStyle(
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
      decoration:
          BoxDecoration(
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

          const SizedBox(
            width: 5,
          ),

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
          const Color(0xFFF5F9FA),

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
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFE0F7FA,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: const Icon(
                      Icons
                          .payments_rounded,
                      color:
                          Color(0xFF008FA3),
                      size: 30,
                    ),
                  ),

                  const SizedBox(
                    width: 16,
                  ),

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
                          color:
                              Color(0xFF263238),
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
                height: 30,
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
                    const Color(
                      0xFF008FA3,
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  _summaryCard(
                    'Paid',
                    'KSh $paidAmount',
                    Icons
                        .check_circle_outline,
                    const Color(
                      0xFF2E7D32,
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  _summaryCard(
                    'Pending',
                    'KSh $pendingAmount',
                    Icons
                        .pending_outlined,
                    const Color(
                      0xFFE67E22,
                    ),
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
                    const Color(
                      0xFF7B1FA2,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              // ------------------------------------------------
              // FILTER SECTION
              // ------------------------------------------------

              Container(
                padding:
                    const EdgeInsets.all(
                  6,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                  border: Border.all(
                    color:
                        Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Text(
                        'Filter:',
                        style:
                            TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF37474F),
                        ),
                      ),
                    ),

                    _filterChip(
                      'All',
                    ),

                    _filterChip(
                      'Paid',
                    ),

                    _filterChip(
                      'Pending',
                    ),
                  ],
                ),
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
                  vertical: 16,
                ),
                decoration:
                    BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFF006978),
                      Color(0xFF008FA3),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(
                        0.08,
                      ),
                      blurRadius: 10,
                      offset:
                          const Offset(
                        0,
                        4,
                      ),
                    ),
                  ],
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
                child:
                    filteredTenants.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration:
                                      BoxDecoration(
                                    color: Colors
                                        .grey
                                        .shade100,
                                    shape:
                                        BoxShape
                                            .circle,
                                  ),
                                  child:
                                      Icon(
                                    Icons
                                        .receipt_long_outlined,
                                    size: 40,
                                    color: Colors
                                        .grey
                                        .shade400,
                                  ),
                                ),

                                const SizedBox(
                                  height: 15,
                                ),

                                Text(
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
                                    fontWeight:
                                        FontWeight
                                            .w600,
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
                                (
                              context,
                              index,
                            ) {
                              final tenant =
                                  filteredTenants[
                                      index];

                              return _paymentCard(
                                tenant,
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

  // ------------------------------------------------------------
  // FILTER CHIP
  // ------------------------------------------------------------

  Widget _filterChip(
    String filter,
  ) {
    final isSelected =
        selectedFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter =
              filter;
        });
      },
      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 200,
        ),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration:
            BoxDecoration(
          color: isSelected
              ? const Color(
                  0xFF008FA3,
                )
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(
            10,
          ),
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.grey.shade700,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PAYMENT CARD
  // ------------------------------------------------------------

  Widget _paymentCard(
    Map<String, dynamic> tenant,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      padding:
          const EdgeInsets.all(18),
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
                const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Tenant
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration:
                      const BoxDecoration(
                    color:
                        Color(0xFFE0F7FA),
                    shape:
                        BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      tenant['name'][0]
                          .toUpperCase(),
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF008FA3),
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                Expanded(
                  child: Text(
                    tenant['name'],
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // House
          Expanded(
            child: Text(
              tenant['house'],
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),

          // Rent
          Expanded(
            child: Text(
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
            child: _paymentStatus(
              tenant[
                  'paymentStatus'],
            ),
          ),

          // Payment Date
          Expanded(
            child: Text(
              tenant[
                          'paymentDate']
                      .toString()
                      .isEmpty
                  ? '—'
                  : tenant[
                      'paymentDate'],
              style: TextStyle(
                color: Colors
                    .grey
                    .shade700,
              ),
            ),
          ),

          // Actions
          SizedBox(
            width: 300,
            child: Row(
              children: [
                if (tenant[
                        'paymentStatus'] ==
                    'Pending')
                  ElevatedButton.icon(
                    onPressed: () {
                      recordPayment(
                        tenant,
                      );
                    },
                    icon:
                        const Icon(
                      Icons
                          .payments_outlined,
                      size: 17,
                    ),
                    label:
                        const Text(
                      'Record Payment',
                    ),
                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          const Color(
                        0xFF00897B,
                      ),
                      foregroundColor:
                          Colors.white,
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 14,
                        vertical: 12,
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

                if (tenant[
                        'paymentStatus'] ==
                    'Paid')
                  IconButton(
                    tooltip:
                        'View Payment History',
                    onPressed: () {
                      viewPaymentHistory(
                        tenant,
                      );
                    },
                    icon: const Icon(
                      Icons
                          .history_rounded,
                      color:
                          Color(0xFF008FA3),
                    ),
                  ),

                IconButton(
                  tooltip:
                      'Send Reminder',
                  onPressed: () {
                    sendReminder(
                      tenant,
                    );
                  },
                  icon: Icon(
                    Icons
                        .notifications_none_rounded,
                    color: Colors
                        .orange
                        .shade700,
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