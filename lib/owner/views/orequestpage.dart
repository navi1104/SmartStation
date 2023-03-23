import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:get/get.dart';

class RequestsTab extends StatefulWidget {
  RequestsTab({Key? key}) : super(key: key);

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  void dispose() {
    super.dispose();
    _stopWatchTimer.dispose();
  }

  @override
  List<Map> products = [
    {"id": "₹ 500", "name": "NAVANIT KRISH K M", "service": "parking"},
    {"id": "₹ 1000", "name": "BHARANIDHARAN", "service": "parking"},
    {"id": "₹ 300", "name": "HARISH", "service": "parking"},
    {"id": "₹ 600", "name": "JEEVAN", "service": "charging"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 5)]),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      trailing: Text(products[index]["id"]),
                      title: Text(products[index]["name"]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                            Get.defaultDialog(
                                title: '',
                                content: Column(
                                  children: [
                                    StreamBuilder<int>(
                                        stream: _stopWatchTimer.rawTime,
                                        initialData:
                                            _stopWatchTimer.rawTime.value,
                                        builder: (context, snapshot) {
                                          final value = snapshot.data;
                                          final displayTime =
                                              StopWatchTimer.getDisplayTime(
                                                  value!,
                                                  milliSecond: false,
                                                  hours: _isHours);
                                          return Text(
                                            displayTime,
                                            style: const TextStyle(
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        }),
                                    ElevatedButton(
                                      onPressed: () {
                                        _stopWatchTimer.onExecute
                                            .add(StopWatchExecute.stop);
                                      },
                                      child: Text("End"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    )
                                  ],
                                ));
                          },
                          child: Text('Accept'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              products.removeAt(index);
                            });
                          },
                          child: Text('Reject'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
