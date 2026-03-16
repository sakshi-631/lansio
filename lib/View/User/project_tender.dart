import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'show_tender.dart'; 

class ProjectTender extends StatefulWidget {
  const ProjectTender({super.key});

  @override
  State<ProjectTender> createState() => _ProjectTenderState();
}

class _ProjectTenderState extends State<ProjectTender> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Color primaryGreen = const Color(0xFF4C8A4C);
  final Color secondaryColor = const Color(0xFFF5F5E9);

  User? _currentUser;
  bool _isLoadingAuth = true;

  @override
  void initState() {
    super.initState();
    // Listen for authentication state changes
    _auth.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
          _isLoadingAuth = false;
        });
      }
    });
  }

  // --- Stream to Fetch Tenders ---
  Stream<QuerySnapshot> get _tenderStream {
    final userId = _currentUser?.uid;

    if (userId == null) {
      return Stream.empty();
    }

    // This query is causing the 'permission-denied' error if rules aren't set up.
    return _firestore
        .collection('tenders')
        .where('requestedToId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // --- Function to Fetch Contractor Name ---
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
      print('Firestore error fetching contractor $contractorUid: $e');
      return 'Error fetching name';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingAuth) {
      return Scaffold(
        backgroundColor: secondaryColor,
        body: Center(child: CircularProgressIndicator(color: primaryGreen)),
      );
    }

    if (_currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'You must be logged in as a client to view project tenders.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: secondaryColor,
      
      body: StreamBuilder<QuerySnapshot>(
        stream: _tenderStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: primaryGreen));
          }

          if (snapshot.hasError) {
            print('Firestore Query Error: ${snapshot.error}');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  // Show the actual error message (Permission Denied) to help the user
                  'Error loading tenders: ${snapshot.error.toString()}', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
            );
          }

          final tenders = snapshot.data?.docs ?? [];

          if (tenders.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'No tenders have been shared with you yet.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: tenders.length,
            itemBuilder: (context, index) {
              final doc = tenders[index];
              final tenderData = (doc.data() as Map<String, dynamic>?) ?? {};
              final String contractorUid = tenderData['requestedById'] ?? ''; 
              final String projectName = tenderData['projectName'] ?? 'an Unnamed';

              return _buildTenderCard(
                doc.id,
                contractorUid,
                projectName,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildTenderCard(
    String tenderId,
    String contractorUid,
    String projectName,
  ) {
    return FutureBuilder<String>(
      future: _fetchContractorName(contractorUid),
      builder: (context, snapshot) {
        final contractorName = snapshot.data ?? 'Loading Contractor...';

        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          color: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(color: primaryGreen.withOpacity(0.5), width: 1.0),
          ),
          child: InkWell(
            // --- Navigation to details page ---
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowTender(
                    tenderId: tenderId,
                    contractorUid: contractorUid,
                  ),
                ),
              );
            },
            // -------------------------------
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tender for $projectName project',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tender from $contractorName',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Tap to View Details',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
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