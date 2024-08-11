/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'controllers/NewannouncementController.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final AnnouncementController announcementController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Obx(() {
              if (announcementController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: announcementController.announcements.length,
                      itemBuilder: (context, index) {
                        var announcement = announcementController.announcements[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: 100,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Color(0xFFDBC6FC),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        announcement.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(announcement.description),
                                      SizedBox(height: 10),
                                      Text("Service ID: ${announcement.serviceID}"),
                                      Text("User ID: ${announcement.userID}"),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Obx(() => IconButton(
                                      icon: SvgPicture.asset(announcement.isSaved.value ? 'assets/icon/save.svg' : 'assets/icon/unsave.svg'),
                                      onPressed: () {
                                        if (announcement.isSaved.value) {
                                          announcementController.unsaveAnnouncement(announcement.id);
                                        } else {
                                          announcementController.saveAnnouncement(announcement.id);
                                        }
                                      },
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
*/

//واجهة زي العسل
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'My_Announcement.dart';
// import 'controllers/NewannouncementController.dart';
//
//
//
// class AnnouncementPage extends StatefulWidget {
//   @override
//   State<AnnouncementPage> createState() => _AnnouncementPageState();
// }
//
// class _AnnouncementPageState extends State<AnnouncementPage> {
//   final AnnouncementController announcementController = Get.put(AnnouncementController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       /* appBar: AppBar(
//         title: Text('Home'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.bookmark),
//             onPressed: () {
//               Get.toNamed('/saved');
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {
//               Get.to(()=>MyAnnouncementPage());
//             },
//           ),
//         ],
//       ),*/
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//
//           ),
//         ),
//         child: Stack(
//           children: [
//             Obx(() {
//               if (announcementController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Obx(() =>
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: announcementController.announcements
//                               .length,
//                           itemBuilder: (context, index) {
//                             var announcement = announcementController
//                                 .announcements[index];
//                             return Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20, right: 30, left: 30),
//                               child: Container(
//                                 width: 100,
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(28),
//                                   color: Color(0xFFDBC6FC),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Stack(
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment
//                                             .start,
//                                         children: [
//                                           Text(
//                                             announcement.title,
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 24,
//                                               color: Color(0xFF292D3D),
//                                               height: 1.2, // Equivalent to line height 24sp
//                                             ),
//                                           ),
//                                           SizedBox(height: 10),
//                                           Text(announcement.description,
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               color: Color(0xFF292D3D),
//                                               height: 1.2, // Equivalent to line height 24sp
//                                             ),),
//                                           SizedBox(height: 10),
//                                           Text("Service ID: ${announcement
//                                               .serviceID}"),
//                                           //Text("User ID: ${announcement.userID}"),
//                                           if (announcement.fileStored != null) // عرض الملف في حال وجوده
//                                             Text("File: ${announcement.fileStored}"),
//                                         ],
//                                       ),
//                                       Align(
//                                         alignment: Alignment.bottomRight,
//                                         child: IconButton(
//                                           icon: SvgPicture.asset(
//                                               announcement.isSaved
//                                                   ? 'assets/icon/save.svg'
//                                                   : 'assets/icon/unsave.svg'),
//                                           onPressed: () {
//                                             announcementController
//                                                 .toggleSaveAnnouncement(index);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         )),
//                   ],
//                 ),
//               );
//             }),
//             Positioned(
//               bottom: 20,
//               right: 20,
//               child: FloatingActionButton(
//                 onPressed: () => _showAddAnnouncementDialog(context),
//                 child: Icon(Icons.add),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }void _showAddAnnouncementDialog(BuildContext context) {
//     final TextEditingController titleController = TextEditingController();
//     final TextEditingController descriptionController = TextEditingController();
//     final TextEditingController serviceIDController = TextEditingController();
//     XFile? selectedFile;
//
//     void _pickFile() async {
//       final ImagePicker _picker = ImagePicker();
//       final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
//       if (file != null) {
//         setState(() {
//           selectedFile = file;
//         });
//       }
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Announcement'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: serviceIDController,
//                 decoration: InputDecoration(labelText: 'Service ID'),
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _pickFile,
//                 child: Text('Pick File'),
//               ),
//               if (selectedFile != null)
//                 Text('File: ${selectedFile!.name}'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (titleController.text.isNotEmpty || descriptionController.text.isNotEmpty) {
//                   announcementController.addAnnouncement(
//                     titleController.text,
//                     descriptionController.text,
//                     serviceIDController.text.isNotEmpty ? int.parse(serviceIDController.text) : null,
//                     selectedFile,
//                   );
//                   Navigator.of(context).pop();
//                 } else {
//                   print('يجب تعبئة حقل واحد على الأقل');
//                 }
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// }
//قبل الاستعراض
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
//
// import 'My_Announcement.dart';
// import 'controllers/NewannouncementController.dart';
//
// class AnnouncementPage extends StatefulWidget {
//   @override
//   State<AnnouncementPage> createState() => _AnnouncementPageState();
// }
//
// class _AnnouncementPageState extends State<AnnouncementPage> {
//   final AnnouncementController announcementController = Get.put(AnnouncementController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Obx(() {
//               if (announcementController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Obx(() => ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: announcementController.announcements.length,
//                       itemBuilder: (context, index) {
//                         var announcement = announcementController.announcements[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
//                           child: Container(
//                             width: 100,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(28),
//                               color: Color(0xFFDBC6FC),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Stack(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         announcement.title,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 24,
//                                           color: Color(0xFF292D3D),
//                                           height: 1.2,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Text(
//                                         announcement.description,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Color(0xFF292D3D),
//                                           height: 1.2,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Text("Service ID: ${announcement.serviceID}"),
//                                       if (announcement.files != null && announcement.files!.isNotEmpty)
//                                         ...announcement.files!.map((file) {
//                                           return Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text('File Name: ${file.fileName}'),
//                                               Text('File Path: ${file.filePath}'),
//                                             ],
//                                           );
//                                         }).toList(),
//                                     ],
//                                   ),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: IconButton(
//                                       icon: SvgPicture.asset(
//                                           announcement.isSaved ? 'assets/icon/save.svg' : 'assets/icon/unsave.svg'),
//                                       onPressed: () {
//                                         announcementController.toggleSaveAnnouncement(index);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     )),
//                   ],
//                 ),
//               );
//             }),
//             Positioned(
//               bottom: 20,
//               right: 20,
//               child: FloatingActionButton(
//                 onPressed: () => _showAddAnnouncementDialog(context),
//                 child: Icon(Icons.add),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showAddAnnouncementDialog(BuildContext context) {
//     final TextEditingController titleController = TextEditingController();
//     final TextEditingController descriptionController = TextEditingController();
//     final TextEditingController serviceIDController = TextEditingController();
//     PlatformFile? selectedFile;
//
//     void _pickFile() async {
//       FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//       if (result != null) {
//         setState(() {
//           selectedFile = result.files.first;
//         });
//       }
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Announcement'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: serviceIDController,
//                 decoration: InputDecoration(labelText: 'Service ID'),
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _pickFile,
//                 child: Text('Pick File'),
//               ),
//               if (selectedFile != null)
//                 Text('File: ${selectedFile!.name}'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 if (titleController.text.isNotEmpty || descriptionController.text.isNotEmpty) {
//                   announcementController.addAnnouncement(
//                     titleController.text,
//                     descriptionController.text,
//                     serviceIDController.text.isNotEmpty ? int.parse(serviceIDController.text) : null,
//                     selectedFile,
//                   );
//                   Navigator.of(context).pop();
//                 } else {
//                   print('يجب تعبئة حقل واحد على الأقل');
//                 }
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'My_Announcement.dart';
import 'controllers/NewannouncementController.dart';



class AnnouncementPage extends StatefulWidget {
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final AnnouncementController announcementController = Get.put(AnnouncementController());

  void openFileViewer(BuildContext context, String filePath) {
    String fileExtension = filePath.split('.').last;

    switch (fileExtension) {
      case 'txt':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FileContentPage(filePath: filePath)),
        );
        break;
      // case 'pdf':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => PDFViewerPage(filePath: filePath)),
      //   );
      //   break;
      case 'jpg':
      case 'jpeg':
      case 'png':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImageViewerPage(filePath: filePath)),
        );
        break;

      // case 'docx':
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => WordViewerPage(filePath: filePath)),
      //   );
      //   break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unsupported file type')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Obx(() {
              if (announcementController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: announcementController.announcements.length,
                      itemBuilder: (context, index) {
                        var announcement = announcementController.announcements[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                          child: Container(
                            width: 100,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              color: Color(0xFFDBC6FC),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        announcement.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Color(0xFF292D3D),
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        announcement.description,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF292D3D),
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Service ID: ${announcement.serviceID}"),
                                      if (announcement.files != null && announcement.files!.isNotEmpty)
                                        ...announcement.files!.map((file) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('File Name: ${file.fileName}'),
                                              Text('File Path: ${file.filePath}'),
                                              ElevatedButton(
                                                onPressed: () => openFileViewer(context, file.filePath),
                                                child: Text('Open File'),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                          announcement.isSaved ? 'assets/icon/save.svg' : 'assets/icon/unsave.svg'),
                                      onPressed: () {
                                        announcementController.toggleSaveAnnouncement(index);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              );
            }),
            // Positioned(
            //   bottom: 20,
            //   right: 20,
            //   child: FloatingActionButton(
            //     onPressed: () => _showAddAnnouncementDialog(context),
            //     child: Icon(Icons.add),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  // void _showAddAnnouncementDialog(BuildContext context) {
  //   final TextEditingController titleController = TextEditingController();
  //   final TextEditingController descriptionController = TextEditingController();
  //   final TextEditingController serviceIDController = TextEditingController();
  //   PlatformFile? selectedFile;
  //
  //   void _pickFile() async {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //     if (result != null) {
  //       setState(() {
  //         selectedFile = result.files.first;
  //       });
  //     }
  //   }
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Add Announcement'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: titleController,
  //               decoration: InputDecoration(labelText: 'Title'),
  //             ),
  //             TextField(
  //               controller: descriptionController,
  //               decoration: InputDecoration(labelText: 'Description'),
  //             ),
  //             TextField(
  //               controller: serviceIDController,
  //               decoration: InputDecoration(labelText: 'Service ID'),
  //               keyboardType: TextInputType.number,
  //             ),
  //             SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: _pickFile,
  //               child: Text('Pick File'),
  //             ),
  //             if (selectedFile != null)
  //               Text('File: ${selectedFile!.name}'),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               if (titleController.text.isNotEmpty || descriptionController.text.isNotEmpty) {
  //                 announcementController.addAnnouncement(
  //                   titleController.text,
  //                   descriptionController.text,
  //                   serviceIDController.text.isNotEmpty ? int.parse(serviceIDController.text) : null,
  //                   selectedFile,
  //                 );
  //                 Navigator.of(context).pop();
  //               } else {
  //                 print('يجب تعبئة حقل واحد على الأقل');
  //               }
  //             },
  //             child: Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

class FileContentPage extends StatelessWidget {
  final String filePath;

  FileContentPage({required this.filePath});

  Future<String> readFileContent() async {
    try {
      final file = File(filePath);
      String content = await file.readAsString();
      return content;
    } catch (e) {
      return 'Error reading file: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Content')),
      body: FutureBuilder<String>(
        future: readFileContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(child: Text(snapshot.data ?? '')),
            );
          }
        },
      ),
    );
  }
}

// class PDFViewerPage extends StatelessWidget {
//   final String filePath;
//
//   PDFViewerPage({required this.filePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('PDF Viewer')),
//       body: PDFView(
//         filePath: filePath,
//       ),
//     );
//   }
// }

class ImageViewerPage extends StatelessWidget {
  final String filePath;

  ImageViewerPage({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Viewer')),
      body: Center(
        child: Image.file(File(filePath)),
      ),
    );
  }
}




// class WordViewerPage extends StatefulWidget {
//   final String filePath;
//
//   WordViewerPage({Key? key, required this.filePath}) : super(key: key);
//
//   @override
//   _WordViewerPageState createState() => _WordViewerPageState();
// }
//
// class _WordViewerPageState extends State<WordViewerPage> {
//   late Future<String> _fileContent;
//
//   @override
//   void initState() {
//     super.initState();
//     _fileContent = readWordFile();
//   }
//
//   Future<String> readWordFile() async {
//     // Read the file and return its content
//     return 'Content of the Word file'; // Replace with actual file reading logic
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Word Viewer')),
//       body: FutureBuilder<String>(
//         future: _fileContent,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return Padding(
//               padding: EdgeInsets.all(16.0),
//               child: SingleChildScrollView(child: HtmlWidget(data: snapshot.data ?? '')),
//             );
//           }
//         },
//       ),
//     );
//   }
// }


