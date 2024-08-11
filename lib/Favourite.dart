import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/CategoryController.dart';
import 'subjects.dart';
class FavoriteSubjects extends StatefulWidget {
  @override
  _FavoriteSubjectsState createState() => _FavoriteSubjectsState();
}

class _FavoriteSubjectsState extends State<FavoriteSubjects> {
  final CategoryController _categoryController = Get.find<CategoryController>();

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
        title: Text('Favorite Subjects', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF292D3D),
      ),
      body: Obx(() {
        if (_categoryController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (_categoryController.favoriteSubjects.isEmpty) {
          return Center(child: Text('No favorite subjects found', style: TextStyle(color: Colors.white)));
        } else {
          return ListView.builder(
            itemCount: _categoryController.favoriteSubjects.length,
            itemBuilder: (context, index) {
              final subject = _categoryController.favoriteSubjects[index];
              return CustomRectangle1(
                serviceName: subject.serviceName,
                children: subject.children,
                onHeightChange: (height) {},
                isLongPress: false,
                isFavorite: true,
                onFavoriteChanged: (isFavorite) {
                  if (!isFavorite) {
                    _categoryController.removeFavoriteSubject(subject.id);
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tired/subjects.dart';
// import 'controllers/CategoryController.dart';
//
// class FavoriteSubjects extends StatefulWidget {
//   @override
//   _FavoriteSubjectsState createState() => _FavoriteSubjectsState();
// }
//
// class _FavoriteSubjectsState extends State<FavoriteSubjects> {
//   final CategoryController _categoryController = Get.find<CategoryController>();
//
//   @override
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF292D3D),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: Text('Favorite Subjects', style: TextStyle(color: Colors.white)),
//         backgroundColor: Color(0xFF292D3D),
//       ),
//       body: Obx(() {
//         if (_categoryController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else if (_categoryController.favoriteSubjects.isEmpty) {
//           return Center(child: Text('No favorite subjects found', style: TextStyle(color: Colors.white)));
//         } else {
//           return ListView.builder(
//             itemCount: _categoryController.favoriteSubjects.length,
//             itemBuilder: (context, index) {
//               final subject = _categoryController.favoriteSubjects[index];
//               return CustomRectangle1(
//                 serviceName: subject.serviceName,
//                 children: subject.children,
//                 onHeightChange: (height) {},
//                 isLongPress: false,
//                 isFavorite: true,
//                 onFavoriteChanged: (isFavorite) {
//                   if (!isFavorite) {
//                     _categoryController.removeFavoriteSubject(subject.id); // استخدم `subject.id`
//                   }
//                 },
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }
