// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class CurrentContractDetailFilling extends StatefulWidget {
//   const CurrentContractDetailFilling({super.key});

//   @override
//   State<CurrentContractDetailFilling> createState() => _ContractProgressPageState();
// }

// class _ContractProgressPageState extends State<CurrentContractDetailFilling> {
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController lastUpdateController = TextEditingController();
//   final TextEditingController workDescriptionController = TextEditingController();

//   double progressValue = 0.0;
//   List<File> uploadedImages = [];

//   Future<void> pickImages() async {
//     final ImagePicker picker = ImagePicker();
//     final List<XFile> pickedFiles = await picker.pickMultiImage();
//     setState(() {
//       uploadedImages = pickedFiles.map((file) => File(file.path)).toList();
//     });
//     }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(40),
//         child: ClipRRect(
//           borderRadius: BorderRadiusGeometry.circular(20),
//           child: AppBar(
//             centerTitle: true,
//             title: Text("Update Details",style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 255, 255, 255)),),
//             // 1. Set the background color to transparent
//             backgroundColor: Colors.transparent,
//             // 2. Remove the shadow (elevation)
//             elevation: 0,

//             // 3. Use the flexibleSpace property for the gradient
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: <Color>[
//                     Color.fromARGB(255, 90, 161, 75), // A light green
//                     Color.fromARGB(255, 70, 227, 78), // A darker green
//                   ],
//                 ),
//               ),
//             ),
//           ),),),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Client Info
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.grey,
//                   child: Icon(Icons.person, size: 35, color: Colors.white),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text("Client Name",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text("Project Title (e.g. Garden Modernizing)",
//                         style: TextStyle(color: Colors.grey)),
//                     Text("Location: Pune, Maharashtra",
//                         style: TextStyle(color: Colors.black54)),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Start & Update Dates
//             TextField(
//               controller: startDateController,
//               decoration: const InputDecoration(
//                 labelText: "Start Date",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: lastUpdateController,
//               decoration: const InputDecoration(
//                 labelText: "Last Update Date",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Work Description
//             const Text("Current Working Description:",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 6),
//             TextField(
//               controller: workDescriptionController,
//               maxLines: 3,
//               decoration: const InputDecoration(
//                 hintText: "e.g. Bought new trees from nursery",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Progress Bar
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Set Progress:", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text("${progressValue.toStringAsFixed(0)}%"),
//               ],
//             ),
//             Slider(
//               value: progressValue,
//               min: 0,
//               max: 100,
//               activeColor: Color.fromARGB(255, 90, 161, 75),
//               label: "${progressValue.toInt()}%",
//               divisions: 100,
//               onChanged: (value) {
//                 setState(() => progressValue = value);
//               },
//             ),
//             const SizedBox(height: 20),

//             // Image Upload Section
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Updated Images / Videos:",
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 ElevatedButton.icon(
//                   onPressed: pickImages,
//                   icon: const Icon(Icons.upload_file),
//                   label: const Text("Upload"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 90, 161, 75),
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),

//             // Grid for uploaded images
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: uploadedImages.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemBuilder: (context, index) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.file(uploadedImages[index], fit: BoxFit.cover),
//                 );
//               },
//             ),

//             const SizedBox(height: 30),

//             // Save Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Progress Saved Successfully!")),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:Color.fromARGB(255, 90, 161, 75),
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text("Save", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Color.fromARGB(255, 255, 255, 255))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CurrentContractDetailFilling extends StatefulWidget {
  const CurrentContractDetailFilling({super.key});

  @override
  State<CurrentContractDetailFilling> createState() => _ContractProgressPageState();
}

class _ContractProgressPageState extends State<CurrentContractDetailFilling> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController lastUpdateController = TextEditingController();
  final TextEditingController workDescriptionController = TextEditingController();

  double progressValue = 0.0;
  List<File> uploadedImages = [];

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    setState(() {
      uploadedImages = pickedFiles.map((file) => File(file.path)).toList();
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: AppBar(
            centerTitle: true,
            title: Text("Update Details",style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(255, 255, 255, 255)),),
            // 1. Set the background color to transparent
            backgroundColor: Colors.transparent,
            // 2. Remove the shadow (elevation)
            elevation: 0,

            // 3. Use the flexibleSpace property for the gradient
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color.fromARGB(255, 90, 161, 75), // A light green
                    Color.fromARGB(255, 70, 227, 78), // A darker green
                  ],
                ),
              ),
            ),
          ),),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Client Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 35, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Client Name",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Project Title (e.g. Garden Modernizing)",
                        style: TextStyle(color: Colors.grey)),
                    Text("Location: Pune, Maharashtra",
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Start & Update Dates
            TextField(
              controller: startDateController,
              decoration: const InputDecoration(
                labelText: "Start Date",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: lastUpdateController,
              decoration: const InputDecoration(
                labelText: "Last Update Date",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Work Description
            const Text("Current Working Description:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            TextField(
              controller: workDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "e.g. Bought new trees from nursery",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Set Progress:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("${progressValue.toStringAsFixed(0)}%"),
              ],
            ),
            Slider(
              value: progressValue,
              min: 0,
              max: 100,
              activeColor: Color.fromARGB(255, 90, 161, 75),
              label: "${progressValue.toInt()}%",
              divisions: 100,
              onChanged: (value) {
                setState(() => progressValue = value);
              },
            ),
            const SizedBox(height: 20),

            // Image Upload Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Updated Images / Videos:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  onPressed: pickImages,
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Upload"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 90, 161, 75),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Grid for uploaded images
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: uploadedImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(uploadedImages[index], fit: BoxFit.cover),
                );
              },
            ),

            const SizedBox(height: 30),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Progress Saved Successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color.fromARGB(255, 90, 161, 75),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Save", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Color.fromARGB(255, 255, 255, 255))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
