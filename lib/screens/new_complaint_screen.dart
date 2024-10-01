import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewComplaintScreen extends StatefulWidget {
  static const String routeName = "/user/new-complaint";
  const NewComplaintScreen({super.key});

  @override
  State<NewComplaintScreen> createState() => _NewComplaintScreenState();
}

class _NewComplaintScreenState extends State<NewComplaintScreen> {
  File? _image;
  final picker = ImagePicker();

  final _issueTitleController = TextEditingController();
  final _issueDescController = TextEditingController();
  bool _issueTitleValidate = false;
  bool _issueDescValidate = false;
  bool _issueTypeValidate = false;
  String? _selectedIssueType;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    List<MenuItem> issueTypes = [
      MenuItem(id: 0, label: "Road"),
      MenuItem(id: 1, label: "Drainage"),
      MenuItem(id: 2, label: "Land Conflicts")
    ];
    // String? selectedIssueType;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Issue",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Issue title Text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                controller: _issueTitleController,
                decoration: InputDecoration(
                  labelText: "Issue Title",
                  errorText:
                      _issueTitleValidate ? "Issue Title can't be Empty" : null,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Issue type drop down
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DropdownMenu(
                width: mediaQuery.size.width,
                inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                hintText: "Issue Type",
                errorText: _issueTypeValidate ? "Please Select a type" : null,
                dropdownMenuEntries:
                    issueTypes.map<DropdownMenuEntry<MenuItem>>((menuItem) {
                  return DropdownMenuEntry(
                    value: menuItem,
                    label: menuItem.label,
                  );
                }).toList(),
                onSelected: (value) {
                  _selectedIssueType = value?.label;
                },
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Issue Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                maxLines: 6,
                controller: _issueDescController,
                decoration: InputDecoration(
                  labelText: "Issue Description",
                  alignLabelWithHint: true,
                  errorText: _issueDescValidate
                      ? "Issue Description can't be Empty"
                      : null,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Image Picker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Image",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                      onPressed: showOptions,
                      icon: Icon(Icons.add_photo_alternate_outlined))
                ],
              ),
            ),
            _image == null
                ? const Text("No Image Selected")
                : SizedBox(
                    height: 400,
                    child: Image.file(_image!),
                  ),

            const SizedBox(
              height: 20,
            ),

            _isLoading ? const CircularProgressIndicator() : ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _issueTitleValidate = _issueTitleController.text.isEmpty;
                  _issueTypeValidate = _selectedIssueType == null;
                  _issueDescValidate = _issueDescController.text.isEmpty;

                  if (_issueTitleValidate || _issueTypeValidate || _issueDescValidate) _isLoading = false;

                  if (_image == null) {
                    _isLoading = false;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("No Image Selected!"),
                          content:
                              const Text("Please add an image to continue."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Okay"),
                            )
                          ],
                        );
                      },
                    );
                  }
                });

                if (_isLoading) {
                  //TODO: Upload the Issue
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer),
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 40),
                ),
              ),
              child: const Text(
                "Submit Issue",
                style: TextStyle(fontSize: 14),
              ),
            ),

            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
}

// Supporting Class for Menu Items
class MenuItem {
  int id;
  String label;
  MenuItem({required this.id, required this.label});
}
