// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const ContractorInfoPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ContractorInfoPage extends StatefulWidget {
//   const ContractorInfoPage({super.key});

//   @override
//   State<ContractorInfoPage> createState() => _ContractorInfoPageState();
// }

// class _ContractorInfoPageState extends State<ContractorInfoPage>
//     with TickerProviderStateMixin {
//   final _services = [
//     'Garden Design',
//     'Lawn Maintenance',
//     'Tree Planting & Trimming',
//     'Irrigation Setup',
//     'Hardscaping',
//     'Seasonal Planting',
//     'Organic Gardening'
//   ];

//   final Set<String> _selectedServices = {};

//   final TextEditingController experienceController = TextEditingController();
//   final TextEditingController rateController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController equipmentController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   List<File> _portfolioImages = [];
//   final ImagePicker _picker = ImagePicker();

//   Map<String, bool> _daysAvailable = {
//     'Mon': false,
//     'Tue': false,
//     'Wed': false,
//     'Thu': false,
//     'Fri': false,
//     'Sat': false,
//     'Sun': false
//   };

//   TimeOfDay? startTime;
//   TimeOfDay? endTime;

//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     _fadeAnimation =
//         CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickPortfolioImages() async {
//     final pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _portfolioImages.addAll(pickedFiles.map((e) => File(e.path)));
//       });
//     }
//   }

//   Future<void> _pickTime(bool isStart) async {
//     final TimeOfDay? picked =
//         await showTimePicker(context: context, initialTime: TimeOfDay.now());
//     if (picked != null) {
//       setState(() {
//         if (isStart) {
//           startTime = picked;
//         } else {
//           endTime = picked;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contractor Info'),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1️⃣ Services
//               const Text('Services Offered', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               Wrap(
//                 spacing: 10,
//                 children: _services.map((service) {
//                   final isSelected = _selectedServices.contains(service);
//                   return ChoiceChip(
//                     label: Text(service),
//                     selected: isSelected,
//                     onSelected: (selected) {
//                       setState(() {
//                         if (selected) {
//                           _selectedServices.add(service);
//                         } else {
//                           _selectedServices.remove(service);
//                         }
//                       });
//                     },
//                     selectedColor: Colors.green.shade300,
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),

//               // 2️⃣ Experience & Description
//               const Text('Experience & Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: experienceController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Years of Experience',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: descriptionController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(
//                   labelText: 'Brief Description',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // 3️⃣ Portfolio Images
//               const Text('Portfolio Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: _pickPortfolioImages,
//                     icon: const Icon(Icons.add_a_photo),
//                     label: const Text('Add Images'),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
//                   ),
//                   const SizedBox(width: 10),
//                   Text('${_portfolioImages.length} added'),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _portfolioImages.length,
//                   itemBuilder: (_, index) {
//                     return Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       child: Image.file(_portfolioImages[index], width: 100, height: 100, fit: BoxFit.cover),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // 4️⃣ Location & Service Area
//               const Text('Service Area', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: areaController,
//                 decoration: const InputDecoration(
//                   labelText: 'Primary Service Area / City',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // 5️⃣ Availability
//               const Text('Availability', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               Wrap(
//                 spacing: 10,
//                 children: _daysAvailable.keys.map((day) {
//                   return FilterChip(
//                     label: Text(day),
//                     selected: _daysAvailable[day]!,
//                     onSelected: (selected) {
//                       setState(() => _daysAvailable[day] = selected);
//                     },
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () => _pickTime(true),
//                     child: Text(startTime == null ? 'Start Time' : startTime!.format(context)),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: () => _pickTime(false),
//                     child: Text(endTime == null ? 'End Time' : endTime!.format(context)),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade700),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               // 6️⃣ Equipment
//               const Text('Tools / Equipment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: equipmentController,
//                 maxLines: 2,
//                 decoration: const InputDecoration(
//                   labelText: 'List your tools / equipment',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Submit button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle save contractor profile logic here
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 18),
//                     backgroundColor: Colors.green.shade700,
//                   ),
//                   child: const Text('Save Profile', style: TextStyle(fontSize: 18, color: Colors.white)),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const ContractorProfilePage(),
    );
  }
}

class ContractorProfilePage extends StatefulWidget {
  const ContractorProfilePage({super.key});

  @override
  State<ContractorProfilePage> createState() => _ContractorProfilePageState();
}

class _ContractorProfilePageState extends State<ContractorProfilePage>
    with TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;
  List<File> portfolioImages = [];

  // Controllers
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  // Services & Availability
  List<String> services = ['Garden Design', 'Lawn Maintenance', 'Tree Planting', 'Hardscaping'];
  List<String> selectedServices = [];
  List<String> days = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
  List<String> selectedDays = [];
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Animation controllers
  late AnimationController _controller;
  late Animation<double> _fadeProfile;
  late Animation<double> _fadePersonal;
  late Animation<double> _fadeBusiness;
  late Animation<double> _fadeServices;
  late Animation<double> _fadeExperience;
  late Animation<double> _fadePortfolio;
  late Animation<double> _fadeAvailability;
  late Animation<double> _fadeSubmit;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _fadeProfile = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0,0.15, curve: Curves.easeIn)));
    _fadePersonal = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.1,0.25, curve: Curves.easeIn)));
    _fadeBusiness = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.2,0.35, curve: Curves.easeIn)));
    _fadeServices = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.3,0.45, curve: Curves.easeIn)));
    _fadeExperience = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4,0.55, curve: Curves.easeIn)));
    _fadePortfolio = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5,0.65, curve: Curves.easeIn)));
    _fadeAvailability = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.6,0.75, curve: Curves.easeIn)));
    _fadeSubmit = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.75,1.0, curve: Curves.easeIn)));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) setState(() => _profileImage = File(pickedFile.path));
  }

  Future<void> _pickPortfolioImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() => portfolioImages.addAll(pickedFiles.map((e) => File(e.path))));
  }

  Future<void> _pickStartTime() async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 9, minute: 0));
    if (time != null) setState(() => startTime = time);
  }

  Future<void> _pickEndTime() async {
    final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 18, minute: 0));
    if (time != null) setState(() => endTime = time);
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _animatedFade({required Animation<double> anim, required Widget child}) {
    return FadeTransition(opacity: anim, child: child);
  }

  Widget _buildProfileImageSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickProfileImage,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.green.shade300, width: 3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
              image: _profileImage != null
                  ? DecorationImage(image: FileImage(_profileImage!), fit: BoxFit.cover)
                  : null,
              color: Colors.grey[200],
            ),
            child: _profileImage == null ? Icon(Icons.camera_alt, size: 40, color: Colors.grey[600]) : null,
          ),
        ),
        const SizedBox(height: 8),
        const Text("Upload Profile Picture", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contractor Profile"),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _animatedFade(anim: _fadeProfile, child: _buildProfileImageSection()),

              _animatedFade(
                anim: _fadePersonal,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(controller: fullNameController, decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                      const SizedBox(height: 12),
                      TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                      const SizedBox(height: 12),
                      TextField(controller: mobileController, decoration: InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                    ],
                  ),
                ),
              ),

              _animatedFade(
                anim: _fadeBusiness,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(controller: companyController, decoration: InputDecoration(labelText: 'Business / Company Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                      const SizedBox(height: 12),
                      TextField(controller: officeAddressController, maxLines: 2, decoration: InputDecoration(labelText: 'Office Address', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                      const SizedBox(height: 12),
                      TextField(controller: cityController, decoration: InputDecoration(labelText: 'City / State / Zip', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                    ],
                  ),
                ),
              ),

              _animatedFade(
                anim: _fadeServices,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Services Offered", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        children: services.map((service) {
                          bool selected = selectedServices.contains(service);
                          return ChoiceChip(
                            label: Text(service),
                            selected: selected,
                            selectedColor: Colors.green.shade300,
                            elevation: 2,
                            onSelected: (bool value) {
                              setState(() {
                                if (value) {
                                  selectedServices.add(service);
                                } else {
                                  selectedServices.remove(service);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              _animatedFade(
                anim: _fadeExperience,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(controller: experienceController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Years of Experience', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                      const SizedBox(height: 12),
                      TextField(controller: bioController, maxLines: 3, decoration: InputDecoration(labelText: 'Short Bio / Description', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                    ],
                  ),
                ),
              ),

              _animatedFade(
                anim: _fadePortfolio,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Portfolio Images", style: TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(icon: const Icon(Icons.add_a_photo, color: Colors.green), onPressed: _pickPortfolioImages)
                        ],
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: portfolioImages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(6),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(image: FileImage(portfolioImages[index]), fit: BoxFit.cover),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

              _animatedFade(
                anim: _fadeAvailability,
                child: _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Availability", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        children: days.map((day) {
                          bool selected = selectedDays.contains(day);
                          return ChoiceChip(
                            label: Text(day),
                            selected: selected,
                            selectedColor: Colors.green.shade300,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  selectedDays.add(day);
                                } else {
                                  selectedDays.remove(day);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _pickStartTime,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade400),
                              child: Text(startTime != null ? "Start: ${startTime!.format(context)}" : "Select Start Time"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _pickEndTime,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade400),
                              child: Text(endTime != null ? "End: ${endTime!.format(context)}" : "Select End Time"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              _animatedFade(
                anim: _fadeSubmit,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: implement save profile logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text("Save Profile", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
