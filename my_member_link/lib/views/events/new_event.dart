import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  String startDateTime = "", endDateTime = "";
  String eventtypevalue = 'Conference';
  var items = [
    'Conference',
    'Exibition',
    'Seminar',
    'Hackathon',
  ];
  late double screenWidth, screenHeight;
  File? _image;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("New Event")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                     showSelectionDialog();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                       image: DecorationImage(
                                //  fit: BoxFit.contain,
                                image: _image == null
                                    ? const AssetImage(
                                        "assets/images/image_icon.webp")
                                    : FileImage(_image!) as ImageProvider),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                        height: screenHeight * 0.3,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: "Event Name"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Column(
                        children: [
                          const Text("Select Start Date"),
                          Text(startDateTime),
                        ],
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectTime) {
                              if (selectTime != null) {
                                DateTime selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectTime.hour,
                                  selectTime.minute,
                                );
                                var formatter =
                                    DateFormat('dd-MM-yyyy hh:mm a');
                                String formattedDate =
                                    formatter.format(selectedDateTime);
                                startDateTime = formattedDate.toString();
                                // print(startDateTime);
                                // print(selectedDateTime);
                                setState(() {});
                              }
                            });
                          }
                        });
                      },
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          const Text("Select End Date"),
                          Text(endDateTime),
                        ],
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectTime) {
                              if (selectTime != null) {
                                DateTime selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectTime.hour,
                                  selectTime.minute,
                                );
                                var formatter =
                                    DateFormat('dd-MM-yyyy hh:mm a');
                                String formattedDate =
                                    formatter.format(selectedDateTime);
                                endDateTime = formattedDate.toString();
                                setState(() {});
                              }
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    // validator: (value) =>
                    //     value!.isEmpty ? "Enter Location" : null,
                    // controller: locationController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Event Location")),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelStyle: TextStyle(
                        // fontSize: resWidth * 0.04,
                        ),
                  ),
                  value: eventtypevalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
                const SizedBox(height: 10),
                TextFormField(
                    // validator: (value) =>
                    //     value!.isEmpty ? "Enter Description" : null,
                    // controller: descriptionController,
                    maxLines: 18,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Event Description")),
                const SizedBox(height: 10),
                MaterialButton(
                  elevation: 10,
                  onPressed: () {
                    // if (!_formKey.currentState!.validate()) {
                    //   print("STILL HERE");
                    //   return;
                    // }
                    // if (_image == null) {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(const SnackBar(
                    //     content: Text("Please take a photo"),
                    //     backgroundColor: Colors.red,
                    //   ));
                    //   return;
                    // }
                    // double filesize = getFileSize(_image!);
                    // print(filesize);

                    // if (filesize > 100) {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(const SnackBar(
                    //     content: Text("Image size too large"),
                    //     backgroundColor: Colors.red,
                    //   ));
                    //   return;
                    // }

                    // if (startDateTime == "" || endDateTime == "") {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(const SnackBar(
                    //     content: Text("Please select start/end date"),
                    //     backgroundColor: Colors.red,
                    //   ));
                    //   return;
                    // }

                    // insertEventDialog();
                  },
                  minWidth: screenWidth,
                  height: 50,
                  color: Theme.of(context)
                      .colorScheme
                      .secondary, // Uses primary color from theme
                  child: Text(
                    "Insert",
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary, // Text color matches onPrimary color
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
  
  void showSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 8)),
                  child: const Text('Gallery'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectfromGallery(),
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 8)),
                  child: const Text('Camera'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                     _selectFromCamera(),
                  },
                ),
              ],
            ));
      },
    );
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    // print("BEFORE CROP: ");
    // print(getFileSize(_image!));
    if (pickedFile != null) {
      //_image = File(pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
      // cropImage();
    } else {}
  }

    Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    // print("BEFORE CROP: ");
    // print(getFileSize(_image!));
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
      // cropImage();
    } else {}
  }
}
