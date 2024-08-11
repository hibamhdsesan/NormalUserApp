// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class AddInterviewSessionDoc extends StatefulWidget {
//   @override
//   State<AddInterviewSessionDoc> createState() => _AddInterviewSessionDocState();
// }
//
// class _AddInterviewSessionDocState extends State<AddInterviewSessionDoc> {
//   double _expandedHeight = 0.0;
//   int _selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     _expandedHeight = MediaQuery.of(context).size.height / 4;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Reservations'),
//           backgroundColor: Color(0xFF292D3D),
//         ),
//       backgroundColor: Color(0xffFFFFFF),
//       body:Column(children: [
//         Center(
//           child: Image(
//             image: AssetImage('assets/images/3D young man in headphone sitting with laptop.png'),
//           ),
//         ),
//         Expanded(
//             child: ListView.builder(
//               itemCount: 5,
//                 itemBuilder: (context, index){
//                   return Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Container(
//
//                       width: 300,
//                       height: 215,
//                       decoration: BoxDecoration(
//                         color: index.isEven ? Color(0xFFA5EAD1) : Color(0xffDEC5FF),
//                         borderRadius: BorderRadius.circular(23.0),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 15.0, top: 15),
//                             child: Row(
//                               children: [
//                                 const Text(
//                                   'Title',
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF292D3D),
//                                     fontFamily: 'Inter',
//                                   ),
//                                 ),
//                                 Expanded(child: SizedBox()),
//                                 SvgPicture.asset(
//                                   'assets/icon/edit.svg',
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: SvgPicture.asset(
//                                     'assets/icon/delete.svg',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(left: 15.0),
//                             child: Text(
//                               'ghjkkjhgfdsdfghjklkjhgfdfghjklkjhgfdfghjklkjhgfdsdfghjukgfdsdfghjkjhgfdsdftgyuj',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Color(0xFF292D3D),
//                                 fontFamily: 'Inter',
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 15.0, top: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: const [
//                                     Text(
//                                       'Date',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color(0xFF292D3D),
//                                         fontFamily: 'Inter',
//                                       ),
//                                     ),
//                                     Text(
//                                       '09:30 AM',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Color(0xFF292D3D),
//                                         fontFamily: 'Inter',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(width: 30),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: const [
//                                     Text(
//                                       'Start',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color(0xFF292D3D),
//                                         fontFamily: 'Inter',
//                                       ),
//                                     ),
//                                     Text(
//                                       '09:30 AM',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Color(0xFF292D3D),
//                                         fontFamily: 'Inter',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(width: 20),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: const [
//                                     Text(
//                                       'End',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color(0xFF292D3D),
//                                         fontFamily: 'Inter',
//                                       ),
//                                     ),
//                                     Text(
//                                       '09:30 AM',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Color(0xFF292D3D),
//                                         fontFamily: 'Inter',
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20,)
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//             ),
//         ),
//
//
//       ],)
//
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Advanceduser_related_session_view.dart';
import 'controllers/PrivateReservationController.dart';

class PrivateReservationsView extends StatelessWidget {
  final int privateSessionID;
  final PrivateReservationController reservationController = Get.put(PrivateReservationController());

  PrivateReservationsView({required this.privateSessionID});

  @override
  Widget build(BuildContext context) {
    reservationController.fetchPrivateReservations(privateSessionID);
    final List<dynamic> args = Get.arguments;
    final int? passedUserId = args[0];
    final int serviceId = args[1];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => Advanced_related_session_view(), arguments: [serviceId, passedUserId]);
          },
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text('Reservations'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (reservationController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (reservationController.reservations.isEmpty) {
            return Center(child: Text('No Reservations Found'));
          } else {
            return ListView.builder(
              itemCount: reservationController.reservations.length,
              itemBuilder: (context, index) {
                var reservation = reservationController.reservations[index];
                return IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: index.isEven ? Color(0xFFA5EAD1) : Color(0xffDEC5FF),
                        borderRadius: BorderRadius.circular(23.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 12),
                        child: ListTile(
                          title: const Text(
                            'Group Member',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF292D3D),
                              height: 1.2,
                            ),
                          ),
                          leading: Text(
                            '${reservation.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFF292D3D),
                              height: 1.2,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${reservation.groupMembers}'),
                              Text('Date: ${reservation.reservationDate}\nStart: ${reservation.reservationStartTime}\nEnd: ${reservation.reservationEndTime}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
