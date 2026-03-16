// // import 'package:flutter/material.dart';

// // // Assuming the primary green color from your previous screens
// // const Color _primaryGreen = Color(0xFF4C8A4C);
// // const Color _lightBackground = Color(0xFFF5F5E9);

// // class Tender extends StatefulWidget {
// //   final String clientName;
// //   final String projectName;

// //   const Tender({
// //     super.key,
// //     required this.clientName,
// //     required this.projectName,
// //   });

// //   @override
// //   State<Tender> createState() => _TenderState();
// // }

// // class _TenderState extends State<Tender> {
// //   // Controllers for input fields
// //   final _periodController = TextEditingController();
// //   final _contactController = TextEditingController();

// //   // List to dynamically manage pricing items (plants, materials, etc.)
// //   final List<PricingItem> _pricingItems = [
// //     PricingItem(label: 'Trees/Plants', controller: TextEditingController()),
// //     PricingItem(
// //       label: 'Worker/Labor Cost',
// //       controller: TextEditingController(),
// //     ),
// //     PricingItem(
// //       label: 'Materials (Soil/Fertilizer)',
// //       controller: TextEditingController(),
// //     ),
// //     // Suggestion-based line
// //     PricingItem(
// //       label: 'Special Suggestion (E.g., Lighting)',
// //       controller: TextEditingController(),
// //       isSuggestion: true,
// //     ),
// //   ];

// //   // Variables to hold calculated total
// //   double _totalPrice = 0.0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _calculateTotal();
// //     // Listen to changes in all price fields to update the total
// //     for (var item in _pricingItems) {
// //       item.controller.addListener(_calculateTotal);
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _periodController.dispose();
// //     _contactController.dispose();
// //     for (var item in _pricingItems) {
// //       item.controller.removeListener(_calculateTotal);
// //       item.controller.dispose();
// //     }
// //     super.dispose();
// //   }

// //   // Calculates the sum of all entered pricing amounts
// //   void _calculateTotal() {
// //     double total = 0.0;
// //     for (var item in _pricingItems) {
// //       final value = double.tryParse(item.controller.text) ?? 0.0;
// //       total += value;
// //     }
// //     setState(() {
// //       _totalPrice = total;
// //     });
// //   }

// //   void _addPricingItem() {
// //     setState(() {
// //       _pricingItems.add(
// //         PricingItem(label: 'Custom Item', controller: TextEditingController()),
// //       );
// //       _pricingItems.last.controller.addListener(_calculateTotal);
// //     });
// //   }

// //   void _submitTender() {
// //     // In a real app, you would package this data and send it to your backend
// //     print('--- TENDER SUBMITTED ---');
// //     print('Client: ${widget.clientName}');
// //     print('Project: ${widget.projectName}');
// //     print('Total Price: $_totalPrice');
// //     print('Period: ${_periodController.text}');
// //     print('Contact: ${_contactController.text}');

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Tender submitted successfully!')),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: PreferredSize(
// //         preferredSize: Size.fromHeight(40),
// //         child: ClipRRect(
// //           borderRadius: BorderRadiusGeometry.circular(20),
// //           child: AppBar(
// //             centerTitle: true,
// //             title: Text(
// //               "Tender",
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w600,
// //                 color: Color.fromARGB(255, 255, 255, 255),
// //               ),
// //             ),
// //             // 1. Set the background color to transparent
// //             backgroundColor: Colors.transparent,
// //             // 2. Remove the shadow (elevation)
// //             elevation: 0,

// //             // 3. Use the flexibleSpace property for the gradient
// //             flexibleSpace: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                   colors: <Color>[
// //                     Color.fromARGB(255, 90, 161, 75), // A light green
// //                     Color.fromARGB(255, 70, 227, 78), // A darker green
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //       backgroundColor: _lightBackground,
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // --- Tender Header ---
// //             Center(
// //               child: Text(
// //                 'Tender for "${widget.clientName}"\'s project',
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(
// //                   fontSize: 22,
// //                   fontWeight: FontWeight.bold,
// //                   color: _primaryGreen,
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 24),

// //             // --- 1. Pricing Section ---
// //             const Text(
// //               'Pricing:',
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const Divider(color: Colors.grey),

// //             // Dynamic list of pricing items
// //             ..._pricingItems.asMap().entries.map((entry) {
// //               int index = entry.key;
// //               PricingItem item = entry.value;

// //               return Padding(
// //                 padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       flex: 4,
// //                       child: Text(
// //                         item.label,
// //                         style: TextStyle(
// //                           fontSize: 16,
// //                           fontWeight: item.isSuggestion
// //                               ? FontWeight.w500
// //                               : FontWeight.normal,
// //                           color: item.isSuggestion
// //                               ? Colors.blue.shade700
// //                               : Colors.black87,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 16),
// //                     // Input for Price
// //                     Expanded(
// //                       flex: 3,
// //                       child: CustomInputField(
// //                         controller: item.controller,
// //                         hintText: 'Amount (₹)',
// //                         isNumeric: true,
// //                       ),
// //                     ),
// //                     // Optional button to remove custom items
// //                     if (index >= 4) // Only allow removing custom-added items
// //                       InkWell(
// //                         onTap: () {
// //                           setState(() {
// //                             item.controller.removeListener(_calculateTotal);
// //                             item.controller.dispose();
// //                             _pricingItems.removeAt(index);
// //                             _calculateTotal(); // Recalculate after removal
// //                           });
// //                         },
// //                         child: Icon(Icons.close, color: Colors.red, size: 20),
// //                       ),
// //                   ],
// //                 ),
// //               );
// //             }),

// //             // Add Custom Item Button
// //             TextButton.icon(
// //               onPressed: _addPricingItem,
// //               icon: const Icon(Icons.add, color: _primaryGreen),
// //               label: const Text(
// //                 'Add Custom Item',
// //                 style: TextStyle(color: _primaryGreen),
// //               ),
// //             ),

// //             const Divider(color: Colors.grey),

// //             // Total Pricing Display
// //             Padding(
// //               padding: const EdgeInsets.symmetric(vertical: 8.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   const Text(
// //                     'TOTAL TENDER PRICE:',
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                   Text(
// //                     '₹ ${_totalPrice.toStringAsFixed(2)}',
// //                     style: const TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: _primaryGreen,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 24),

// //             // --- 2. Period Section ---
// //             const Text(
// //               'Period:',
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const Divider(color: Colors.grey),
// //             Padding(
// //               padding: const EdgeInsets.only(bottom: 16.0),
// //               child: CustomInputField(
// //                 controller: _periodController,
// //                 hintText: 'E.g., 2-3 Weeks / 15 Working Days',
// //                 maxLines: 1,
// //               ),
// //             ),
// //             const SizedBox(height: 16),

// //             // --- 3. Contact Detail Section ---
// //             const Text(
// //               'Contact Detail (for negotiation):',
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const Divider(color: Colors.grey),
// //             Padding(
// //               padding: const EdgeInsets.only(bottom: 24.0),
// //               child: CustomInputField(
// //                 controller: _contactController,
// //                 hintText: 'Enter Phone Number / Email',
// //                 isNumeric: true,
// //                 prefixIcon: Icons.phone,
// //               ),
// //             ),

// //             // --- Submit Button ---
// //             Center(
// //               child: ElevatedButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: _primaryGreen,
// //                   foregroundColor: Colors.white,
// //                   padding: const EdgeInsets.symmetric(
// //                     horizontal: 40,
// //                     vertical: 15,
// //                   ),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                 ),
// //                 child: const Text(
// //                   'Submit Tender',
// //                   style: TextStyle(fontSize: 18),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // Helper class for dynamic pricing items
// // class PricingItem {
// //   final String label;
// //   final TextEditingController controller;
// //   final bool isSuggestion;

// //   PricingItem({
// //     required this.label,
// //     required this.controller,
// //     this.isSuggestion = false,
// //   });
// // }

// // // Reusable Input Field Widget
// // class CustomInputField extends StatelessWidget {
// //   final TextEditingController controller;
// //   final String hintText;
// //   final int maxLines;
// //   final bool isNumeric;
// //   final IconData? prefixIcon;

// //   const CustomInputField({
// //     super.key,
// //     required this.controller,
// //     required this.hintText,
// //     this.maxLines = 1,
// //     this.isNumeric = false,
// //     this.prefixIcon,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return TextFormField(
// //       controller: controller,
// //       maxLines: maxLines,
// //       keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
// //       decoration: InputDecoration(
// //         hintText: hintText,
// //         prefixIcon: prefixIcon != null
// //             ? Icon(prefixIcon, color: Colors.grey)
// //             : null,
// //         filled: true,
// //         fillColor: Colors.white,
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: const BorderSide(color: _primaryGreen, width: 2),
// //         ),
// //       ),
// //     );
// //   }
// // }
// // ignore_for_file: file_names

// // ignore_for_file: file_names

// // ignore_for_file: file_names

// import 'package:flutter/material.dart';

// // Assuming the primary green color from your previous screens
// const Color _primaryGreen = Color(0xFF4C8A4C);
// const Color _lightBackground = Color(0xFFF5F5E9);

// class Tender extends StatefulWidget {
//   final String clientName;
//   final String projectName;

//   const Tender({
//     super.key,
//     required this.clientName,
//     required this.projectName,
//   });

//   @override
//   State<Tender> createState() => _TenderState();
// }

// class _TenderState extends State<Tender> {
//   // Controllers for input fields
//   final _periodController = TextEditingController();
//   final _contactController = TextEditingController();

//   // List to dynamically manage pricing items (plants, materials, etc.)
//   final List<PricingItem> _pricingItems = [
//     PricingItem(label: 'Trees/Plants', controller: TextEditingController()),
//     PricingItem(
//       label: 'Worker/Labor Cost',
//       controller: TextEditingController(),
//     ),
//     PricingItem(
//       label: 'Materials (Soil/Fertilizer)',
//       controller: TextEditingController(),
//     ),
//     // Suggestion-based line
//     PricingItem(
//       label: 'Special Suggestion (E.g., Lighting)',
//       controller: TextEditingController(),
//       isSuggestion: true,
//     ),
//   ];

//   // Variables to hold calculated total
//   double _totalPrice = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _calculateTotal();
//     // Listen to changes in all price fields to update the total
//     for (var item in _pricingItems) {
//       item.controller.addListener(_calculateTotal);
//     }
//   }

//   @override
//   void dispose() {
//     _periodController.dispose();
//     _contactController.dispose();
//     for (var item in _pricingItems) {
//       item.controller.removeListener(_calculateTotal);
//       item.controller.dispose();
//     }
//     super.dispose();
//   }

//   // Calculates the sum of all entered pricing amounts
//   void _calculateTotal() {
//     double total = 0.0;
//     for (var item in _pricingItems) {
//       // Safely access controller
//       final value = double.tryParse(item.controller.text) ?? 0.0;
//       total += value;
//     }
//     setState(() {
//       _totalPrice = total;
//     });
//   }

//   // UPDATED FUNCTION: Shows a dialog and ensures controller disposal.
//   void _addPricingItem() {
//     final customLabelController = TextEditingController();
    
//     // Show the dialog and await the result (the custom label string)
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add Custom Pricing Item'),
//           // Wrap content in a Builder to ensure the TextField's controller is managed
//           content: Builder(
//             builder: (context) {
//               return TextField(
//                 controller: customLabelController,
//                 decoration: const InputDecoration(
//                   hintText: "Enter custom item name",
//                 ),
//                 autofocus: true,
//               );
//             }
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Add', style: TextStyle(color: _primaryGreen)),
//               onPressed: () {
//                 final label = customLabelController.text.trim();
//                 if (label.isNotEmpty) {
//                   // Pop the dialog, returning the label
//                   Navigator.of(context).pop(label); 
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     ).then((customLabel) {
//       // 1. **CRITICAL FIX**: Dispose the temporary controller after the dialog closes.
//       customLabelController.dispose();

//       // 2. Add the item if a valid label was returned.
//       if (customLabel != null && customLabel.isNotEmpty) {
//         setState(() {
//           _pricingItems.add(
//             PricingItem(label: customLabel, controller: TextEditingController()),
//           );
//           // Attach listener to the new item
//           _pricingItems.last.controller.addListener(_calculateTotal);
//         });
//       }
//     });
//   }

//   void _submitTender() {
//     // This logic runs safely without immediately popping the screen
//     print('--- TENDER SUBMITTED ---');
//     print('Client: ${widget.clientName}');
//     print('Project: ${widget.projectName}');
//     print('Total Price: $_totalPrice');
//     print('Period: ${_periodController.text}');
//     print('Contact: ${_contactController.text}');

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Tender submitted successfully!')),
//     );

//     // Now, pop the screen *after* showing the SnackBar, or handle navigation.
//     // I'm keeping the pop action here, as it was likely intentional.
//     // If this pop is causing the crash (due to parent being disposed), 
//     // you might need to navigate to a success screen instead.
//     Navigator.of(context).pop(); 
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(40),
//         child: ClipRRect(
//           borderRadius: BorderRadiusGeometry.circular(20),
//           child: AppBar(
//             centerTitle: true,
//             title: const Text(
//               "Tender",
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color.fromARGB(255, 255, 255, 255),
//               ),
//             ),
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
//           ),
//         ),
//       ),
//       backgroundColor: _lightBackground,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // --- Tender Header ---
//             Center(
//               child: Text(
//                 'Tender for "${widget.clientName}"\'s project',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: _primaryGreen,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- 1. Pricing Section ---
//             const Text(
//               'Pricing:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Divider(color: Colors.grey),

//             // Dynamic list of pricing items
//             ..._pricingItems.asMap().entries.map((entry) {
//               int index = entry.key;
//               PricingItem item = entry.value;

//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       flex: 4,
//                       child: Text(
//                         item.label,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: item.isSuggestion
//                               ? FontWeight.w500
//                               : FontWeight.normal,
//                           color: item.isSuggestion
//                               ? Colors.blue.shade700
//                               : Colors.black87,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     // Input for Price
//                     Expanded(
//                       flex: 3,
//                       child: CustomInputField(
//                         controller: item.controller,
//                         hintText: 'Amount (₹)',
//                         isNumeric: true,
//                       ),
//                     ),
//                     // Optional button to remove custom items
//                     if (index >= 4) // Only allow removing custom-added items
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             // 1. Remove listener and dispose the controller first
//                             item.controller.removeListener(_calculateTotal);
//                             item.controller.dispose();
                            
//                             // 2. Remove the item from the list
//                             _pricingItems.removeAt(index);
                            
//                             // 3. Recalculate total (now safe as disposed controller is gone)
//                             _calculateTotal();
//                           });
//                         },
//                         child: const Icon(Icons.close, color: Colors.red, size: 20),
//                       ),
//                   ],
//                 ),
//               );
//             }),

//             // Add Custom Item Button
//             TextButton.icon(
//               onPressed: _addPricingItem,
//               icon: const Icon(Icons.add, color: _primaryGreen),
//               label: const Text(
//                 'Add Custom Item',
//                 style: TextStyle(color: _primaryGreen),
//               ),
//             ),

//             const Divider(color: Colors.grey),

//             // Total Pricing Display
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'TOTAL TENDER PRICE:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '₹ ${_totalPrice.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: _primaryGreen,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 24),

//             // --- 2. Period Section ---
//             const Text(
//               'Period:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Divider(color: Colors.grey),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: CustomInputField(
//                 controller: _periodController,
//                 hintText: 'E.g., 2-3 Weeks / 15 Working Days',
//                 maxLines: 1,
//               ),
//             ),
//             const SizedBox(height: 16),

//             // --- 3. Contact Detail Section ---
//             const Text(
//               'Contact Detail (for negotiation):',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Divider(color: Colors.grey),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 24.0),
//               child: CustomInputField(
//                 controller: _contactController,
//                 hintText: 'Enter Phone Number / Email',
//                 isNumeric: true,
//                 prefixIcon: Icons.phone,
//               ),
//             ),

//             // --- Submit Button ---
//             Center(
//               child: ElevatedButton(
//                 onPressed: _submitTender, 
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: _primaryGreen,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 15,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Submit Tender',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Helper class for dynamic pricing items
// class PricingItem {
//   final String label;
//   final TextEditingController controller;
//   final bool isSuggestion;

//   PricingItem({
//     required this.label,
//     required this.controller,
//     this.isSuggestion = false,
//   });
// }

// // Reusable Input Field Widget
// class CustomInputField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final int maxLines;
//   final bool isNumeric;
//   final IconData? prefixIcon;

//   const CustomInputField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.maxLines = 1,
//     this.isNumeric = false,
//     this.prefixIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       maxLines: maxLines,
//       keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//       decoration: InputDecoration(
//         hintText: hintText,
//         prefixIcon: prefixIcon != null
//             ? Icon(prefixIcon, color: Colors.grey)
//             : null,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: _primaryGreen, width: 2),
//         ),
//       ),
//     );
//   }
// }
















import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// UI Constants from the user's preferred style
const Color _primaryGreen = Color(0xFF4C8A4C);
const Color _lightBackground = Color(0xFFF5F5E9);


class Tender extends StatefulWidget {
  final String clientName;
  final String projectName;
  final String requestId; // Dynamic: ID of the request being tendered for
  final String requestedById; // Dynamic: Client's UID for notification/linking

  const Tender({
    super.key,
    required this.clientName,
    required this.projectName,
    required this.requestId,
    required this.requestedById,
  });

  @override
  State<Tender> createState() => _TenderState();
}

class _TenderState extends State<Tender> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Dynamic: Controllers for Period and Contact Input
  final _periodController = TextEditingController(); 
  final _contactController = TextEditingController();

  // Dynamic: Initial list of pricing items. User inputs values into these.
  final List<PricingItem> _pricingItems = [
    PricingItem(label: 'Trees/Plants', controller: TextEditingController()),
    PricingItem(label: 'Worker/Labor Cost', controller: TextEditingController()),
    PricingItem(label: 'Materials (Soil/Fertilizer)', controller: TextEditingController()),
    PricingItem(label: 'Special Suggestion (E.g., Lighting)', controller: TextEditingController(), isSuggestion: true),
  ];
  double _totalPrice = 0.0; // Dynamic: Calculated total cost
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
    // Listen to changes in all price fields to update the dynamic total
    for (var item in _pricingItems) {
      item.controller.addListener(_calculateTotal);
    }
  }

  @override
  void dispose() {
    _periodController.dispose();
    _contactController.dispose();
    for (var item in _pricingItems) {
      item.controller.removeListener(_calculateTotal);
      item.controller.dispose();
    }
    super.dispose();
  }

  // --- Utility Functions ---

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
  
  // Dynamic: Fetches the current user's name for the notification message
  Future<String> _fetchContractorName() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return 'A Contractor';
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()?['name'] ?? 'A Contractor';
    } catch (e) {
      print('Error fetching contractor name: $e');
      return 'A Contractor';
    }
  }

  // Dynamic: Sends a notification using the client's UID
  Future<void> _sendNotification(String clientUid) async {
    final contractorName = await _fetchContractorName();

    try {
      await _firestore.collection('notifications').add({
        'requestedToId': clientUid, 
        'notificationMsg': '$contractorName has shared a tender for your ${widget.projectName} project.',
        'timestamp': Timestamp.now(),
        'isRead': false,
      });
    } catch (e) {
      print('Error sending tender notification: $e');
    }
  }

  // Dynamic: Recalculates total based on all user input fields
  void _calculateTotal() {
    double total = 0.0;
    for (var item in _pricingItems) {
      final value = double.tryParse(item.controller.text) ?? 0.0;
      total += value;
    }
    setState(() {
      _totalPrice = total;
    });
  }
  
  // Dynamic: Adds a new custom pricing item based on user dialog input
  void _addPricingItem() {
    final customLabelController = TextEditingController();
    
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Custom Pricing Item'),
          content: Builder(
            builder: (context) {
              return TextField(
                controller: customLabelController,
                decoration: const InputDecoration(
                  hintText: "Enter custom item name",
                ),
                autofocus: true,
              );
            }
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(color: _primaryGreen)),
              onPressed: () {
                final label = customLabelController.text.trim();
                if (label.isNotEmpty) {
                  Navigator.of(context).pop(label); 
                }
              },
            ),
          ],
        );
      },
    ).then((customLabel) {
      customLabelController.dispose();

      if (customLabel != null && customLabel.isNotEmpty) {
        setState(() {
          _pricingItems.add(
            PricingItem(label: customLabel, controller: TextEditingController()),
          );
          _pricingItems.last.controller.addListener(_calculateTotal);
        });
      }
    });
  }


  // CORE BACKEND LOGIC: Saves all dynamic data to Firestore
  Future<void> _saveTender() async {
    if (!_formKey.currentState!.validate() || _totalPrice <= 0) {
      _showSnackBar('Please ensure all required fields are filled and the total price is above zero.');
      return;
    }
    
    setState(() { _isLoading = true; });
    final contractorId = _auth.currentUser?.uid;

    if (contractorId == null) {
      _showSnackBar('Error: User not logged in.');
      setState(() { _isLoading = false; });
      return;
    }
    
    // Dynamic: Prepare Detailed Tender Breakdown for Firebase
    final List<Map<String, dynamic>> pricingBreakdown = _pricingItems.map((item) {
      return {
        'label': item.label,
        'cost': double.tryParse(item.controller.text) ?? 0.0,
        'isSuggestion': item.isSuggestion,
      };
    }).toList();


    try {
      // 1. Save the new tender document to the 'tenders' collection with all dynamic data
      await _firestore.collection('tenders').add({
        'requestId': widget.requestId, 
        'contractorId': contractorId,
        'clientRequestedById': widget.requestedById,
        'projectType': widget.projectName,
        
        // Dynamic Data Fields being saved:
        'estimatedCost': _totalPrice, 
        'estimatedTimeframe': _periodController.text.trim(),
        'contactDetail': _contactController.text.trim(),
        'pricingBreakdown': pricingBreakdown, 

        'dateShared': Timestamp.now(),
      });

      // 2. Update the status of the original request
      await _firestore.collection('requests').doc(widget.requestId).update({
        'status': 'Tender Shared', 
      });
      
      // 3. Send notification to the client
      await _sendNotification(widget.requestedById);

      _showSnackBar('Tender shared successfully! Client has been notified.');
      Navigator.of(context).pop();

    } catch (e) {
      print('Error submitting tender: $e');
      _showSnackBar('Failed to share tender. Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), 
        child: ClipRRect(
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "Tender",
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
        ),
      ),
      backgroundColor: _lightBackground,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: _primaryGreen))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Header
                    Center(
                      child: Text(
                        'Tender for "${widget.clientName}"\'s ${widget.projectName} project',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _primaryGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- 1. Pricing Section ---
                    const Text(
                      'Pricing:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: Colors.grey),

                    // Dynamic list of pricing items (input fields)
                    ..._pricingItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      PricingItem item = entry.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: item.isSuggestion
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                  color: item.isSuggestion
                                      ? Colors.blue.shade700
                                      : Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Dynamic Input for Price
                            Expanded(
                              flex: 3,
                              child: CustomInputField(
                                controller: item.controller,
                                hintText: 'Amount (₹)',
                                isNumeric: true,
                                validator: (value) {
                                  if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                                    return 'Invalid amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // Button to remove dynamically added custom items
                            if (index >= 4) 
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    item.controller.removeListener(_calculateTotal);
                                    item.controller.dispose();
                                    _pricingItems.removeAt(index);
                                    _calculateTotal();
                                  });
                                },
                                child: const Icon(Icons.close, color: Colors.red, size: 20),
                              ),
                          ],
                        ),
                      );
                    }),

                    // Add Custom Item Button
                    TextButton.icon(
                      onPressed: _addPricingItem,
                      icon: const Icon(Icons.add, color: _primaryGreen),
                      label: const Text(
                        'Add Custom Item',
                        style: TextStyle(color: _primaryGreen),
                      ),
                    ),

                    const Divider(color: Colors.grey),

                    // Dynamic Total Pricing Display
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TOTAL TENDER PRICE:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹ ${_totalPrice.toStringAsFixed(2)}', 
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- 2. Period Section (Dynamic Input) ---
                    const Text(
                      'Period:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CustomInputField(
                        controller: _periodController,
                        hintText: 'E.g., 2-3 Weeks / 15 Working Days',
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Estimated period is required.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- 3. Contact Detail Section (Dynamic Input) ---
                    const Text(
                      'Contact Detail (for negotiation):',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: CustomInputField(
                        controller: _contactController,
                        hintText: 'Enter Phone Number / Email',
                        isNumeric: false, 
                        prefixIcon: Icons.contact_mail, 
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Contact detail is required.';
                          }
                          return null;
                        },
                      ),
                    ),

                    // --- Submit Button ---
                    Center(
                      child: _isLoading 
                          ? CircularProgressIndicator(color: _primaryGreen)
                          : ElevatedButton(
                              onPressed: _saveTender, 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Submit Tender',
                                style: TextStyle(fontSize: 18),
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

// Helper class for dynamic pricing items
class PricingItem {
  final String label;
  final TextEditingController controller;
  final bool isSuggestion;

  PricingItem({
    required this.label,
    required this.controller,
    this.isSuggestion = false,
  });
}

// Reusable Input Field Widget
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isNumeric;
  final IconData? prefixIcon;
  final String? Function(String?)? validator; 

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.isNumeric = false,
    this.prefixIcon,
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: validator, 
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.grey)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _primaryGreen, width: 2),
        ),
      ),
    );
  }
}