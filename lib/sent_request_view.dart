import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/PrivateReservationController.dart';

class SentSwapRequestsView extends StatelessWidget {
  final PrivateReservationController swapRequestController = Get.put(PrivateReservationController());

  SentSwapRequestsView() {
    swapRequestController.fetchSentSwapRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sent Swap Requests'),
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
          } else if (swapRequestController.sentSwapRequests.isEmpty) {
            return Center(child: Text('No Sent Swap Requests'));
          } else {
            return ListView.builder(
              itemCount: swapRequestController.sentSwapRequests.length,
              itemBuilder: (context, index) {
                var swapRequest = swapRequestController.sentSwapRequests[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Color(0xFFDBC6FC),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('${swapRequest.serviceName}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            confirmDeleteDialog(context, swapRequest.swapRequestID);
                          },
                        ),
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
  void confirmDeleteDialog(BuildContext context, int swapRequestID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this swap request?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                swapRequestController.deleteSentSwapRequest(swapRequestID);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
