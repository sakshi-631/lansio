import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerRequest {
  final String workerName;
  final String skillSet;
  final String location;
  final String experience;
  final String availability;
  bool isAccepted;
  bool isRejected;

  WorkerRequest({
    required this.workerName,
    required this.skillSet,
    required this.location,
    required this.experience,
    required this.availability,
    this.isAccepted = false,
    this.isRejected = false,
  });

  bool get hasActioned => isAccepted || isRejected;
}

class WorkerRequestScreen extends StatefulWidget {
  const WorkerRequestScreen({super.key}); // Removed workerId parameter

  @override
  State<WorkerRequestScreen> createState() => _WorkerRequestScreenState();
}

class _WorkerRequestScreenState extends State<WorkerRequestScreen>
    with SingleTickerProviderStateMixin {
  final List<WorkerRequest> _requests = [
    WorkerRequest(
      workerName: 'Ravi Kumar',
      skillSet: 'Gardening, Tree Planting',
      location: 'Nashik, Maharashtra',
      experience: '3 Years',
      availability: 'Full Time (Mon–Sat)',
    ),
    WorkerRequest(
      workerName: 'Meera Singh',
      skillSet: 'Landscape Design Assistant',
      location: 'Hyderabad, Telangana',
      experience: '1.5 Years',
      availability: 'Part Time (Weekends)',
    ),
    WorkerRequest(
      workerName: 'Amit Verma',
      skillSet: 'Irrigation System Setup',
      location: 'Indore, MP',
      experience: '5 Years',
      availability: 'Project Based',
    ),
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleAccept(int index) {
    setState(() {
      _requests[index].isAccepted = true;
      _requests[index].isRejected = false;
      _showSnackBar('Request from ${_requests[index].workerName} accepted!');
    });
  }

  void _handleReject(int index) {
    setState(() {
      _requests[index].isRejected = true;
      _requests[index].isAccepted = false;
      _showSnackBar('Request from ${_requests[index].workerName} rejected!');
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade400,
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Colors.green.shade600;

    return Scaffold(
      backgroundColor: const Color(0xFFECF2EC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _requests.isEmpty
            ? const Center(
                child: Text(
                  'No new worker requests.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _requests.length,
                itemBuilder: (context, index) {
                  final request = _requests[index];
                  return _buildRequestCard(request, index, primaryGreen);
                },
              ),
      ),
    );
  }

  Widget _buildRequestCard(
    WorkerRequest request,
    int index,
    Color primaryGreen,
  ) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.1 * index, 1.0, curve: Curves.easeOut),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade100,
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.workerName,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '- Skill Set: ${request.skillSet}',
                          style: GoogleFonts.poppins(color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '- Location: ${request.location}',
                          style: GoogleFonts.poppins(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, thickness: 0.5),
              Text(
                'Experience: ${request.experience}',
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Availability:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Text(
                  request.availability,
                  style: GoogleFonts.poppins(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 16),
              if (!request.hasActioned)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _handleAccept(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        foregroundColor: Colors.white,
                      ),
                      child: const Icon(Icons.check),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => _handleReject(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        foregroundColor: Colors.white,
                      ),
                      child: const Icon(Icons.close),
                    ),
                  ],
                )
              else
                Center(
                  child: Text(
                    request.isAccepted
                        ? 'Request Accepted'
                        : 'Request Rejected',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: request.isAccepted
                          ? primaryGreen
                          : Colors.red.shade700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
