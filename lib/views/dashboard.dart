import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

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

            Row(
              children: [

                Expanded(
                  child: dashboardCard(
                    "Houses",
                    "24",
                    Icons.home_work,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: dashboardCard(
                    "Tenants",
                    "20",
                    Icons.people,
                    Colors.green,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: dashboardCard(
                    "Revenue",
                    "KSh 320K",
                    Icons.attach_money,
                    Colors.orange,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: dashboardCard(
                    "Pending",
                    "KSh 45K",
                    Icons.warning,
                    Colors.red,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                actionButton(Icons.person_add, "Tenant"),

                actionButton(Icons.payments, "Payment"),

                actionButton(Icons.build, "Repair"),

              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Payments",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            paymentTile(
              "John Mwangi",
              "House A1",
              "KSh 15,000",
              true,
            ),

            paymentTile(
              "Mary Wanjiku",
              "House B2",
              "KSh 15,000",
              false,
            ),

            paymentTile(
              "Brian Otieno",
              "House C4",
              "KSh 18,000",
              true,
            ),

          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
      String title,
      String value,
      IconData icon,
      Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),

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
                fontWeight: FontWeight.bold,
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

  Widget actionButton(IconData icon, String text) {
    return Column(
      children: [

        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade100,
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

  Widget paymentTile(
      String tenant,
      String house,
      String amount,
      bool paid) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: const Icon(Icons.person),
        ),

        title: Text(tenant),

        subtitle: Text("$house\n$amount"),

        isThreeLine: true,

        trailing: Chip(
          backgroundColor:
              paid ? Colors.green.shade100 : Colors.red.shade100,

          label: Text(
            paid ? "Paid" : "Pending",
            style: TextStyle(
              color: paid ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}