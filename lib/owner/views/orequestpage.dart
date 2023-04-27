import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/requestTabController.dart';

class RequestsTab extends StatelessWidget {
  RequestListController _requestListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_requestListController.requestsList.isEmpty) {
          return Center(
            child: Text('No requests to display.'),
          );
        } else {
          return ListView.builder(
            itemCount: _requestListController.requestsList.length,
            itemBuilder: (context, index) {
              var request = _requestListController.requestsList[index];
              return Card(
                child: ListTile(
                  title: Text(request.name),
                  subtitle: Text(request.service),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!request.isAccepted && !request.isRejected)
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _requestListController
                                    .acceptRequest(request.id);
                              },
                              icon: Icon(Icons.check),
                            ),
                            IconButton(
                              onPressed: () {
                                _requestListController
                                    .rejectRequest(request.id);
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ],
                        ),
                      if (request.isAccepted)
                        Text(
                          'Accepted',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      if (request.isRejected)
                        Text(
                          'Rejected',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
