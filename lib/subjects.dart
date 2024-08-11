import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Favourite.dart';
import 'controllers/CategoryController.dart';

///last edition
class CustomRectangle1 extends StatelessWidget {
  final String serviceName;
  final List<Child> children;
  final ValueChanged<double> onHeightChange;
  final bool isLongPress;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  CustomRectangle1({
    required this.serviceName,
    required this.children,
    required this.onHeightChange,
    required this.isLongPress,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          double height = constraints.constrainHeight();
          onHeightChange(height);
        });

        return Center(
          child: Container(
            width: 284,
            constraints: BoxConstraints(
              minHeight: 150,
            ),
            margin: EdgeInsets.only(left: 10, top: 50),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFEE2D7),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(serviceName, style: TextStyle(color: Colors.black, fontSize: 20)),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: children.map((child) => Text(child.serviceName)).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isLongPress)
                  GestureDetector(
                    onTap: () {
                      onFavoriteChanged(!isFavorite);
                    },
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border_rounded,
                      color: isFavorite ? Color(0xffFFB924) : Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class CustomRectangle2 extends StatelessWidget {
  final double height;

  CustomRectangle2({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: height.isFinite ? height : 150,  // التأكد من أن الارتفاع له قيمة محددة
      margin: EdgeInsets.only(left: 60, top: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: Color(0xFFFA8554),
      ),
    );
  }
}

///////////////
class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  double containerHeight = 150;
  bool isSelectMode = false;
  List<bool> isSelectedList = List.generate(20, (index) => false);
  List<bool> favoriteStacks = List.generate(20, (index) => false);

  void updateHeight(double newHeight) {
    setState(() {
      containerHeight = newHeight;
    });
  }
  /*void toggleFavorite(int index) {
    final subject = _categoryController.subjects[index];
    setState(() {
      subject.isFavorite = !subject.isFavorite;
    });

    if (subject.isFavorite) {
      _categoryController.addFavoriteSubject(subject.id);
    } else {
      _categoryController.removeFavoriteSubject(subject.id);
    }
  }*/
//شغاال
  /*void toggleFavorite(int index) {
    final subject = _categoryController.subjects[index];
    setState(() {
      favoriteStacks[index] = !favoriteStacks[index];

    });

    if (favoriteStacks[index]) {
      _categoryController.addFavoriteSubject(subject.id);
    } else {
      // Assuming you have a way to get the InterestedService ID
      // You can maintain a map of serviceId to interestedServiceId
      final interestedServiceId = 6; // replace with actual id
      _categoryController.removeFavoriteSubject(interestedServiceId);
    }
  }*/
  void toggleFavorite(int index) {
    final subject = _categoryController.subjects[index];
    setState(() {
      favoriteStacks[index] = !favoriteStacks[index];
      subject.isFavorite = !subject.isFavorite;
    });

    if (subject.isFavorite) {
      _categoryController.addFavoriteSubject(subject.id);
    } else {
      // Assuming you have a way to get the InterestedService ID
      // You can maintain a map of serviceId to interestedServiceId
      final interestedServiceId = 6; // replace with actual id
      _categoryController.removeFavoriteSubject(interestedServiceId);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292D3D),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
            Get.to(() => FavoriteSubjects());
            },
          ),
        ],
        title: Text('Subjects', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  Obx(() {
                    if (_categoryController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: _categoryController.subjects.length,
                        itemBuilder: (context, index) {
                          final subject = _categoryController.subjects[index];
                          return Stack(
                            children: [
                              CustomRectangle1(
                                serviceName: subject.serviceName,
                                children: subject.children,
                                onHeightChange: updateHeight,
                                isLongPress: true,
                                //isFavorite: favoriteStacks[index],
                                isFavorite: subject.isFavorite,
                                onFavoriteChanged: (isFavorite) {
                                  toggleFavorite(index);
                                },
                              ),
                              Positioned(
                                left: 0,
                                child: CustomRectangle2(height: containerHeight),
                              ),

                            ],
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
///////////شغال حذف واضافة

class Subjects extends StatefulWidget {
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  final CategoryController _categoryController = Get.find<CategoryController>();
  double containerHeight = 150;
  bool isSelectMode = false;
  List<bool> isSelectedList = List.generate(20, (index) => false);
  List<bool> favoriteStacks = List.generate(20, (index) => false);

  void updateHeight(double newHeight) {
    setState(() {
      containerHeight = newHeight;
    });
  }
  /*void toggleFavorite(int index) {
    final subject = _categoryController.subjects[index];
    setState(() {
      subject.isFavorite = !subject.isFavorite;
    });

    if (subject.isFavorite) {
      _categoryController.addFavoriteSubject(subject.id);
    } else {
      _categoryController.removeFavoriteSubject(subject.id);
    }
  }*/

  void toggleFavorite(int index) {
    final subject = _categoryController.subjects[index];
    setState(() {
      favoriteStacks[index] = !favoriteStacks[index];
    });

    if (favoriteStacks[index]) {
      _categoryController.addFavoriteSubject(subject.id);
    } else {
      // Assuming you have a way to get the InterestedService ID
      // You can maintain a map of serviceId to interestedServiceId
      final interestedServiceId = 6; // replace with actual id
      _categoryController.removeFavoriteSubject(interestedServiceId);
    }
  }
  /*void toggleFavorite(int index) {
    final subject = _categoryController.subjects[index];
    setState(() {
      subject.isFavorite = !subject.isFavorite;
    });

    if (subject.isFavorite) {
      _categoryController.addFavoriteSubject(subject.id);
    } else {
      final interestedServiceId = 6; // replace with actual id
      _categoryController.removeFavoriteSubject(interestedServiceId);
    }
  }
*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292D3D),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Get.to(() => FavoriteSubjects());
            },
          ),
        ],
        title: Text('Subjects', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  Obx(() {
                    if (_categoryController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: _categoryController.subjects.length,
                        itemBuilder: (context, index) {
                          final subject = _categoryController.subjects[index];
                          return Stack(
                            children: [
                              CustomRectangle1(
                                serviceName: subject.serviceName,
                                children: subject.children,
                                onHeightChange: updateHeight,
                                isLongPress: true,
                                isFavorite: favoriteStacks[index],
                                onFavoriteChanged: (isFavorite) {
                                  toggleFavorite(index);
                                },
                              ),
                              Positioned(
                                left: 0,
                                child: CustomRectangle2(height: containerHeight),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

*/
//واجهة زي العسل
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'controllers/CategoryController.dart';
//
// class CustomRectangle1 extends StatelessWidget {
//   final String serviceName;
//   final List<Child> children;
//   final ValueChanged<double> onHeightChange;
//   final bool isLongPress;
//   final bool isFavorite;
//   final Function(bool) onFavoriteChanged;
//
//   CustomRectangle1({
//     required this.serviceName,
//     required this.children,
//     required this.onHeightChange,
//     required this.isLongPress,
//     required this.isFavorite,
//     required this.onFavoriteChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           double height = constraints.constrainHeight();
//           onHeightChange(height);
//         });
//
//         return Center(
//           child: Container(
//             width: 284,
//             constraints: BoxConstraints(
//               minHeight: 150,
//             ),
//             margin: EdgeInsets.only(left: 10, top: 50),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Color(0xFFFEE2D7),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(serviceName, style: TextStyle(color: Colors.black, fontSize: 20)),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Wrap(
//                           spacing: 8.0,
//                           runSpacing: 4.0,
//                           children: children.map((child) => Text(child.serviceName)).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (isLongPress)
//                   GestureDetector(
//                     onTap: () {
//                       onFavoriteChanged(!isFavorite);
//                     },
//                     child: Icon(
//                       isFavorite ? Icons.star : Icons.star_border_rounded,
//                       color: isFavorite ? Color(0xffFFB924) : Colors.grey,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// class CustomRectangle2 extends StatelessWidget {
//   final double height;
//
//   CustomRectangle2({required this.height});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 18,
//       height: height,
//       margin: EdgeInsets.only(left: 60, top: 50),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//         ),
//         color: Color(0xFFFA8554),
//       ),
//     );
//   }
// }
//
// class Subjects extends StatefulWidget {
//   @override
//   _SubjectsState createState() => _SubjectsState();
// }
//
// class _SubjectsState extends State<Subjects> {
//   final CategoryController _categoryController = Get.find<CategoryController>();
//   double containerHeight = 150;
//   bool isSelectMode = false;
//   List<bool> isSelectedList = List.generate(20, (index) => false);
//   List<bool> favoriteStacks = List.generate(20, (index) => false);
//
//   void updateHeight(double newHeight) {
//     setState(() {
//       containerHeight = newHeight;
//     });
//   }
//
//   void toggleFavorite(int index) {
//     setState(() {
//       favoriteStacks[index] = !favoriteStacks[index];
//     });
//   }
//
//   void onLongPress(int index) {
//     setState(() {
//       isSelectMode = true;
//       isSelectedList[index] = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF292D3D),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             'assets/icon/back_arrow.svg',
//           ),
//           onPressed: () {},
//         ),
//         elevation: 0,
//         backgroundColor: Color(0xFF292D3D),
//         actions: [],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 60,
//             child: Center(child: Text('Subjects', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Obx(
//                         () => _categoryController.isLoading.value
//                         ? Center(child: CircularProgressIndicator())
//                         : ListView.builder(
//                       itemCount: _categoryController.subjects.length,
//                       itemBuilder: (context, index) {
//                         final subject = _categoryController.subjects[index];
//                         return Stack(
//                           children: [
//                             GestureDetector(
//                               onLongPress: () {
//                                 onLongPress(index);
//                               },
//                               child: CustomRectangle1(
//                                 serviceName: subject.serviceName,
//                                 children: subject.children,
//                                 onHeightChange: updateHeight,
//                                 isLongPress: isSelectMode && isSelectedList[index],
//                                 isFavorite: favoriteStacks[index],
//                                 onFavoriteChanged: (isFavorite) {
//                                   toggleFavorite(index);
//                                 },
//                               ),
//                             ),
//                             Positioned(
//                               left: 0,
//                               child: CustomRectangle2(height: containerHeight),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
/////////////////////////
//
// class CustomRectangle1 extends StatelessWidget {
//   final String serviceName;
//   final List<Child> children;
//   final ValueChanged<double> onHeightChange;
//
//   CustomRectangle1({required this.serviceName, required this.children, required this.onHeightChange});
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           double height = constraints.constrainHeight();
//           onHeightChange(height);
//         });
//
//         return Center(
//           child: Container(
//             width: 284,
//             constraints: BoxConstraints(
//               minHeight: 150,
//             ),
//             margin: EdgeInsets.only(left: 10, top: 50),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Color(0xFFFEE2D7),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(serviceName, style: TextStyle(color: Colors.black, fontSize: 20)),
//                       ),
//                       SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Wrap(
//                           spacing: 8.0,
//                           runSpacing: 4.0,
//                           children: children.map((child) => Text(child.serviceName)).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
//
// class CustomRectangle2 extends StatelessWidget {
//   final double height;
//
//   CustomRectangle2({required this.height});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 18,
//       height: height,
//       margin: EdgeInsets.only(left: 60, top: 50),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//         ),
//         color: Color(0xFFFA8554),
//       ),
//     );
//   }
// }
//
// class Subjects extends StatefulWidget {
//   @override
//   _SubjectsState createState() => _SubjectsState();
// }
//
// class _SubjectsState extends State<Subjects> {
//   final CategoryController _categoryController = Get.find<CategoryController>();
//   double containerHeight = 150;
//   bool isSelectMode = false;
//   List<bool> isSelectedList = List.generate(20, (index) => false);
//   List<int> favoriteStacks = [];
//
//
//   void updateHeight(double newHeight) {
//     setState(() {
//       containerHeight = newHeight;
//     });
//   }
//
//   void toggleFavorite(int index) {
//     setState(() {
//       if (favoriteStacks.contains(index)) {
//         favoriteStacks.remove(index);
//       } else {
//         favoriteStacks.add(index);
//       }
//     });
//   }
//
//   void onLongPress(int index) {
//     setState(() {
//       isSelectMode = true;
//       isSelectedList[index] = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF292D3D),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             'assets/icon/back_arrow.svg',
//           ),
//           onPressed: () {},
//         ),
//         elevation: 0,
//         backgroundColor: Color(0xFF292D3D),
//         actions: [
//
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 60,
//             child: Center(child: Text('Subjects', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold))),
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Obx(
//                         () => _categoryController.isLoading.value
//                         ? Center(child: CircularProgressIndicator())
//                         : ListView.builder(
//                       itemCount: _categoryController.subjects.length,
//                       itemBuilder: (context, index) {
//                         final subject = _categoryController.subjects[index];
//                         return Stack(
//                           children: [
//                             GestureDetector(
//                               onLongPress: () {
//                                 onLongPress(index);
//                               },
//                               child: CustomRectangle1(
//                                 serviceName: subject.serviceName,
//                                 children: subject.children,
//                                 onHeightChange: updateHeight,
//                               ),
//                             ),
//                             Positioned(
//                               left: 0,
//                               child: CustomRectangle2(height: containerHeight),
//                             ),
//                             if (isSelectMode && isSelectedList[index])
//                               Positioned(
//                                 right: 0,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     toggleFavorite(index);
//                                   },
//                                   child: Icon(
//                                     favoriteStacks.contains(index) ? Icons.star : Icons.star_border_rounded,
//                                     color: favoriteStacks.contains(index) ? Colors.yellow : Colors.grey,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

