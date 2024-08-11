// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'controllers/ServiceController.dart';
// import 'controllers/search_controller.dart';
//
// class SearchResultsPage extends StatelessWidget {
//   final String query;
//   final SearchController _searchController = Get.put(SearchController());
//   SearchResultsPage({required this.query});
//
//   @override
//   Widget build(BuildContext context) {
//     // تنفيذ عملية البحث عند فتح الصفحة
//     _searchController.searchServices(query);
//
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor:  const Color(0xFF292D3D),
//         title: Text('Search Results'),
//       ),
//       body: Obx(() {
//         if (_searchController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (_searchController.searchResults.isEmpty) {
//           return Center(child: Text('No results found', style: TextStyle(color: Colors.white)));
//         }
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: _searchController.searchResults.length,
//             itemBuilder: (context, index) {
//               final subject = _searchController.searchResults[index];
//               return Padding(
//                 padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                 child: Container(
//                   width: double.infinity,
//                   height: 200,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(28),
//                     color: Color(0xFFFEE2D7),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Stack(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               subject.serviceName,
//                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 10),
//                             ...subject.children.map((child) => InkWell(
//                               onTap: () {
//                                 // هنا يمكنك تنفيذ الإجراء الذي تريده عند الضغط على اسم الطفل
//                                 print('Pressed on ${child.serviceName}');
//                               },
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                                 child: Text(
//                                   child.serviceName,
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             )).toList(),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//
//     );
//   }
// }
