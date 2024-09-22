import 'package:flutter/material.dart';
import 'package:state_management/API/Get_Api/Single_Multiple_API/api_service_sm.dart';
import 'package:state_management/API/Get_Api/Single_Multiple_API/model_sm.dart';

class ScreenWithSM extends StatefulWidget {
  const ScreenWithSM({super.key});

  @override
  State<ScreenWithSM> createState() => _ScreenWithSMState();
}

class _ScreenWithSMState extends State<ScreenWithSM> {
  // Model to hold API data
  MultiData multiData = MultiData();
  bool isReady = false;
  bool hasPressedButton = false; // Track if the button has been pressed

  // Method to fetch data from API
  void _getMultiData() {
    setState(() {
      isReady = true;
      hasPressedButton = true; // Indicate that the button has been pressed
    });
    ApiServices().getSMData().then((value) {
      setState(() {
        multiData = value!;
        isReady = false;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  // Method to clear the screen data
  void _clearData() {
    setState(() {
      multiData = MultiData(); // Reset the model to initial empty values
      hasPressedButton = false; // Indicate that no button has been pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api SM'),
        backgroundColor: Colors.blueGrey,
        actions: const [Icon(Icons.ice_skating)],
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _getMultiData, // Fetch data when button is pressed
                child: const Text('Fetch API Data'),
              ),
              const SizedBox(width: 20), // Add some space between buttons
              ElevatedButton(
                onPressed: _clearData, // Clear data when button is pressed
                child: const Text('Clear Data'),
              ),
            ],
          ),
          Expanded(
            child: isReady
                ? const Center(child: CircularProgressIndicator())
                : hasPressedButton
                    ? Container(
                        color: const Color.fromRGBO(205, 220, 250, 0.3),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              multiData.page.toString(),
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                            Text(
                              multiData.total.toString(),
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                            Text(
                              multiData.totalPages.toString(),
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                            Text(
                              multiData.support?.text ?? '',
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: multiData.data?.length ?? 0,
                                itemBuilder: (context, i) {
                                  return Card(
                                    color: const Color(100),
                                    child: ListTile(
                                      leading: Text(
                                          multiData.data![i].id.toString()),
                                      title: Text(
                                          multiData.data![i].name.toString()),
                                      subtitle: Text(multiData
                                          .data![i].pantoneValue
                                          .toString()),
                                      trailing: Text(
                                          multiData.data![i].year.toString()),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text('Press the button to fetch data.'),
                      ),
          ),
        ],
      ),
    );
  }
}
