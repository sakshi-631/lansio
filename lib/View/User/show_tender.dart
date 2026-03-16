import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowTender extends StatefulWidget {
  // Required data passed from the list screen
  final String tenderId;
  final String contractorUid; 
  
  const ShowTender({
    super.key,
    required this.tenderId,
    required this.contractorUid,
  });

  @override
  State<ShowTender> createState() => _ShowTenderState();
}

class _ShowTenderState extends State<ShowTender> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Color _primaryGreen = const Color(0xFF4C8A4C);
  final Color _secondaryColor = const Color(0xFFF5F5E9);

  // --- 1. Fetch Tender Details by ID ---
  Future<DocumentSnapshot> _fetchTenderDetails() {
    return _firestore.collection('tenders').doc(widget.tenderId).get();
  }

  // --- 2. Fetch Contractor Name ---
  Future<String> _fetchContractorName(String contractorUid) async {
    if (contractorUid.isEmpty) return 'Unknown Contractor';
    try {
      // Attempt 1: Check the 'contractors' collection
      final contractorDoc = await _firestore.collection('contractors').doc(contractorUid).get();
      if (contractorDoc.exists) {
        return contractorDoc.data()?['name'] ?? 'Contractor Name Missing';
      }
      // Attempt 2: Fallback to the 'users' collection
      final userDoc = await _firestore.collection('users').doc(contractorUid).get();
      if (userDoc.exists) {
        return userDoc.data()?['name'] ?? 'Contractor Name Missing';
      }
      return 'Contractor Not Found';
    } catch (e) {
      print('Firestore error fetching contractor ${widget.contractorUid}: $e');
      return 'Error fetching name';
    }
  }

  // --- Helper Widget for Detail Row ---
  Widget _buildDetailRow(String label, String value, {bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: isLarge ? 18 : 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: isLarge ? 18 : 16,
                fontWeight: isLarge ? FontWeight.bold : FontWeight.normal,
                color: isLarge ? _primaryGreen : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for Pricing Breakdown ---
  Widget _buildPricingBreakdown(List<dynamic> pricingDetails) {
    // Safely cast the list of dynamic items to a list of maps
    List<Map<String, dynamic>> details = pricingDetails.cast<Map<String, dynamic>>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cost Breakdown:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const Divider(height: 10, thickness: 1.5),
        
        // Use a map function to generate the breakdown rows
        ...details.map((item) {
          final String label = item['label'] ?? 'Custom Item';
          // Safely convert amount to double
          final double amount = (item['amount'] as num?)?.toDouble() ?? 0.0;
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Text(
                  '₹${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _secondaryColor,
      appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Tender Details",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(255, 90, 161, 75),
                    Color.fromARGB(255, 70, 227, 78),
                  ],
                ),
              ),
            ),
          ),
      body: FutureBuilder<List<dynamic>>(
        // Fetch both tender details and contractor name concurrently
        future: Future.wait([
          _fetchTenderDetails(),
          _fetchContractorName(widget.contractorUid),
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: _primaryGreen));
          }

          if (snapshot.hasError) {
            print('Error fetching tender or contractor: ${snapshot.error}');
            return Center(child: Text('Failed to load details due to error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !(snapshot.data![0] as DocumentSnapshot).exists) {
            return const Center(child: Text('Tender not found or deleted.'));
          }
          
          // Safely cast and extract data
          final DocumentSnapshot doc = snapshot.data![0] as DocumentSnapshot;
          final Map<String, dynamic> data = (doc.data() as Map<String, dynamic>?) ?? {};
          final String contractorName = snapshot.data![1] as String;

          final String projectName = data['projectName'] ?? 'N/A';
          final double totalPrice = (data['totalPrice'] as num?)?.toDouble() ?? 0.0;
          final String period = data['period'] ?? 'N/A';
          final String contact = data['contact'] ?? 'N/A';
          // Ensure pricingDetails is treated as a list, even if it's null or a different type
          final List<dynamic> pricingDetails = data['pricingDetails'] is List ? data['pricingDetails'] : [];
          final String status = data['status'] ?? 'Pending';
          final Timestamp? timestamp = data['timestamp'];
          final String dateShared = timestamp != null 
              ? '${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}' 
              : 'N/A';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Title
                    Text(
                      'Tender for "$projectName"',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: _primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Contractor Info
                    Text(
                      'Shared by $contractorName',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const Divider(height: 25),

                    // Key Details (Status, Period, Contact, Date)
                    _buildDetailRow('Status', status),
                    _buildDetailRow('Period (Estimated)', period),
                    _buildDetailRow('Contractor Contact', contact),
                    _buildDetailRow('Date Shared', dateShared),
                    
                    const Divider(height: 25),
                    
                    // Pricing Breakdown (Only show if there are details)
                    if (pricingDetails.isNotEmpty) ...[
                      _buildPricingBreakdown(pricingDetails),
                      const Divider(height: 25, thickness: 3, color: Colors.black38),
                    ],

                    // Total Price
                    _buildDetailRow(
                      'TOTAL PRICE', 
                      '₹${totalPrice.toStringAsFixed(2)}', 
                      isLarge: true
                    ),
                    
                    const SizedBox(height: 30),

                    // Action Buttons 
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           // Placeholder Action: Reject
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             const SnackBar(content: Text('Tender Rejected.')),
                    //           );
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.red.shade600,
                    //           padding: const EdgeInsets.symmetric(vertical: 15),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //         ),
                    //         child: const Text(
                    //           'Reject',
                    //           style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 15),
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           // Placeholder Action: Accept
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             const SnackBar(content: Text('Tender Accepted!')),
                    //           );
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: _primaryGreen,
                    //           padding: const EdgeInsets.symmetric(vertical: 15),
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //         ),
                    //         child: const Text(
                    //           'Accept',
                    //           style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}