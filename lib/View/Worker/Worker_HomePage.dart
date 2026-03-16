import 'package:flutter/material.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({super.key});

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  // Sample job data
  final List<Map<String, dynamic>> jobs = [
    {
      'contractorName': 'EcoSpace Pvt Ltd',
      'workDescription': 'Green Roof Installation',
      'location': 'Nashik, Maharashtra',
      'rating': 4.7,
      'datePosted': '20 Nov 2023',
    },
    {
      'contractorName': 'John Doe',
      'workDescription': 'Landscape Design Project',
      'location': 'Mumbai, Maharashtra',
      'rating': 4.5,
      'datePosted': '15 Oct 2023',
    },
    {
      'contractorName': 'BuildWell Inc.',
      'workDescription': 'Residential Renovation',
      'location': 'Pune, Maharashtra',
      'rating': 4.9,
      'datePosted': '01 Dec 2023',
    },
    {
      'contractorName': 'AquaFlow Solutions',
      'workDescription': 'Plumbing System Upgrade',
      'location': 'Bengaluru, Karnataka',
      'rating': 4.2,
      'datePosted': '25 Nov 2023',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF2EC),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xFFD0F0C0), Color(0xFFE8F5E9)],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return JobCard(
                contractorName: job['contractorName'],
                workDescription: job['workDescription'],
                location: job['location'],
                rating: job['rating'],
                datePosted: job['datePosted'],
                onViewDetails: () => _showJobDetails(context, job),
                onApply: () => _showApplyConfirmation(context, job),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showJobDetails(BuildContext context, Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.green[50],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Text(
                    job['workDescription'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF388E3C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Contractor: ${job['contractorName']}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const Text(
                    'Job Details:\nThis job involves working on landscaping and renovation projects with a focus on eco-friendly methods.',
                    style: TextStyle(fontSize: 15, height: 1.4),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showApplyConfirmation(context, job),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      "Apply Now",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showApplyConfirmation(BuildContext context, Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Application"),
        content: Text("Do you want to apply for '${job['workDescription']}'?"),
        actions: [
          TextButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.green)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text("Apply"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Applied for ${job['workDescription']}!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String contractorName;
  final String workDescription;
  final String location;
  final double rating;
  final String datePosted;
  final VoidCallback onViewDetails;
  final VoidCallback onApply;

  const JobCard({
    super.key,
    required this.contractorName,
    required this.workDescription,
    required this.location,
    required this.rating,
    required this.datePosted,
    required this.onViewDetails,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.95),
      shadowColor: Colors.green.shade100,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(Icons.business_center, color: Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contractorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      Text(
                        workDescription,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  datePosted,
                  style: const TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                Text(
                  rating.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: onViewDetails,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text("View Details"),
                ),
                ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  child: const Text("Apply"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
