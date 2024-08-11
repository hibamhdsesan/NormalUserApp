// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'controllers/PrivateReservationController.dart';
//
// class SwapRequestsView extends StatelessWidget {
//   final PrivateReservationController swapRequestController = Get.put(PrivateReservationController());
//
//   SwapRequestsView() {
//     swapRequestController.fetchSwapRequests();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Received Swap Requests'),
//         backgroundColor: Color(0xFF292D3D),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Obx(() {
//           if (swapRequestController.isLoading.value) {
//             return Center(child: CircularProgressIndicator());
//           } else if (swapRequestController.swapRequests.isEmpty) {
//             return Center(child: Text('No Swap Requests'));
//           } else {
//             return ListView.builder(
//               itemCount: swapRequestController.swapRequests.length,
//               itemBuilder: (context, index) {
//                 var swapRequest = swapRequestController.swapRequests[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                   child: Container(
//                     width: 50,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(28),
//                       color: Color(0xFFDBC6FC),
//                     ),
//                     child: ListTile(
//                       title: Text('${swapRequest.serviceName}\nStatus: ${swapRequest.status}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (swapRequest.senderReservation != null)
//                             Text(
//                               'Sender: ${swapRequest.senderReservation!.reservationDate} ${swapRequest.senderReservation!.reservationStartTime} - ${swapRequest.senderReservation!.reservationEndTime}',
//                             ),
//                           if (swapRequest.receiverReservation != null)
//                             Text(
//                               'Receiver: ${swapRequest.receiverReservation!.reservationDate} ${swapRequest.receiverReservation!.reservationStartTime} - ${swapRequest.receiverReservation!.reservationEndTime}',
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         }),
//       ),
//     );
//   }
// }
// swap_requests_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/PrivateReservationController.dart';

class SwapRequestsView extends StatelessWidget {
  final PrivateReservationController swapRequestController = Get.put(PrivateReservationController());

  SwapRequestsView() {
    swapRequestController.fetchSwapRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swap Requests'),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (swapRequestController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (swapRequestController.swapRequests.isEmpty) {
            return Center(child: Text('No Swap Requests'));
          } else {
            return ListView.builder(
              itemCount: swapRequestController.swapRequests.length,
              itemBuilder: (context, index) {
                var swapRequest = swapRequestController.swapRequests[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(0xFFDBC6FC),
                    ),
                    child: ListTile(
                      title: Text('${swapRequest.serviceName}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          if (swapRequest.senderReservation != null)
                            Text(
                              'Sender: ${swapRequest.senderReservation!.reservationDate} ${swapRequest.senderReservation!.reservationStartTime} - ${swapRequest.senderReservation!.reservationEndTime}',
                            ),
                          if (swapRequest.receiverReservation != null)
                            Text(
                              'Receiver: ${swapRequest.receiverReservation!.reservationDate} ${swapRequest.receiverReservation!.reservationStartTime} - ${swapRequest.receiverReservation!.reservationEndTime}',
                            ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              swapRequestController.acceptSwapRequest(swapRequest.swapRequestID);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              swapRequestController.declineSwapRequest(swapRequest.swapRequestID);
                            },
                          ),
                        ],
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
