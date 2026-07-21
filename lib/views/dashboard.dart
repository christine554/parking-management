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
    // Get the same tenant data used by the Tenants Page
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
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Rental Manager"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ------------------------------------------------
            // WELCOME MESSAGE
            // ------------------------------------------------

            const Text(
              "Good Afternoon 👋",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Manage your rental properties efficiently.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // ------------------------------------------------
            // DASHBOARD SUMMARY CARDS
            // ------------------------------------------------

            Row(
              children: [

                Expanded(
                  child: dashboardCard(
                    "Tenants",
                    totalTenants.toString(),
                    Icons.people,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: dashboardCard(
                    "Active Tenants",
                    activeTenants.toString(),
                    Icons.person_outline,
                    Colors.blue,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: dashboardCard(
                    "Rent Collected",
                    "KSh $paidAmount",
                    Icons.payments,
                    Colors.green,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: dashboardCard(
                    "Pending Rent",
                    "KSh $pendingAmount",
                    Icons.warning,
                    Colors.red,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            // ------------------------------------------------
            // TOTAL MONTHLY RENT
            // ------------------------------------------------

            SizedBox(
              width: double.infinity,
              child: dashboardCard(
                "Expected Monthly Rent",
                "KSh $monthlyRevenue",
                Icons.account_balance_wallet,
                Colors.orange,
              ),
            ),

            const SizedBox(height: 30),

            // ------------------------------------------------
            // QUICK ACTIONS
            // ------------------------------------------------

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,

              children: [

                actionButton(
                  Icons.person_add,
                  "Tenant",
                ),

                actionButton(
                  Icons.payments,
                  "Payment",
                ),

                actionButton(
                  Icons.build,
                  "Repair",
                ),

              ],
            ),

            const SizedBox(height: 30),

            // ------------------------------------------------
            // RECENT PAYMENTS
            // ------------------------------------------------

            const Text(
              "Recent Payments",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Show tenants from TenantData
            // instead of hard-coded names

            if (tenants.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "No tenants available.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            else
              ...tenants.map(
                (tenant) {
                  final bool paid =
                      tenant['paymentStatus'] ==
                          'Paid';

                  return paymentTile(
                    tenant['name'].toString(),
                    "House ${tenant['house']}",
                    "KSh ${tenant['rent']}",
                    paid,
                  );
                },
              ),

          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // DASHBOARD CARD
  // ------------------------------------------------------------

  Widget dashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            Icon(
              icon,
              color: color,
              size: 35,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // QUICK ACTION BUTTON
  // ------------------------------------------------------------

  Widget actionButton(
    IconData icon,
    String text,
  ) {
    return Column(
      children: [

        CircleAvatar(
          radius: 28,

          backgroundColor:
              Colors.blue.shade100,

          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),

        const SizedBox(height: 8),

        Text(text),

      ],
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
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor:
              Colors.blue.shade100,

          child: const Icon(
            Icons.person,
          ),
        ),

        title: Text(tenant),

        subtitle: Text(
          "$house\n$amount",
        ),

        isThreeLine: true,

        trailing: Chip(
          backgroundColor:
              paid
                  ? Colors.green.shade100
                  : Colors.red.shade100,

          label: Text(
            paid
                ? "Paid"
                : "Pending",

            style: TextStyle(
              color: paid
                  ? Colors.green
                  : Colors.red,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}