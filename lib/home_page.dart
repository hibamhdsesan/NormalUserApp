import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'AdvancedPrivateReservationsView.dart';
import 'My_Announcement.dart';
import 'NewAnnouncement.dart';
import 'NewSub.dart';
import 'controllers/FavoriteCategory.dart';
import 'controllers/ServiceController.dart';
import 'controllers/SessionsController.dart';
import 'model/Session_model.dart';
import 'service_view.dart';


class home_page extends StatelessWidget {
  final SessionController _sessionController = Get.put(SessionController());
  final ServiceController _serviceController = Get.put(ServiceController());
  final TextEditingController _searchController = TextEditingController();
  final FavoriteController _categoryController = Get.put(FavoriteController());
  final List<Color> colors = [
    Color(0xFF9C66F3),
    Color(0xFF33A7E7),
    Color(0xFFFF8932),
    Color(0xFFEF5173),
    Color(0xFFDBC6FC),
    Color(0xFF77B8A1),
    Color(0xFFFF8932),
    Color(0xFF33A7E7),
    Color(0xFF9C66F3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ITE', style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'Inter')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icon/more.svg'),
          onPressed: () {
            Get.to(()=> ServiceView());
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: SvgPicture.asset('assets/icon/notification.svg'),
        //     onPressed: () {},
        //   ),
        // ],

          actions: [
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                Get.toNamed('/saved');
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.person),
            //   onPressed: () {
            //     Get.to(MyAnnouncementPage());
            //   },
            // ),
            IconButton(
              icon: Icon(Icons.announcement),
              onPressed: () {
                Get.to(()=> AnnouncementPage());
              },
            ),
          ],

      ),
      backgroundColor: Color(0xFF292D3D),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar and other widgets
            Center(
              child: Container(
                width: 400,
                height: 120,
                child: Stack(
                  children: [
                    Positioned(
                      width: 350,
                      height: 52,
                      left: 24,
                      top: 24,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color(0xFF9DA7AE),
                        ),
                        child: TextField(

                          controller: _searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 50),
                          ),
                          onSubmitted: (query) {
                          //  Get.to(() => SearchResultsPage(query: query));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Positioned(
                      left: 40,
                      top: 36,
                      child: SvgPicture.asset('assets/icon/search.svg'),
                    ),
                  ],
                ),
              ),
            ),

            Obx(() {
              if (_sessionController.isLoading.value) {
                return CircularProgressIndicator();
              }
              return Column(
                children: [
                  _buildSessionList('Theoretical', _sessionController.theoreticalSessions),
                  _buildSessionList('Practical', _sessionController.practicalSessions),
                ],
              );
            }),
            Stack(
              children: [
                Center(
                  child: Container(
                    width:  MediaQuery.of(context).size.width,
                    height: 449,
                    margin: const EdgeInsets.only(left: 2, top: 100),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Obx(
                            () => _categoryController.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: _categoryController.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final category = _categoryController.categories[index];
                            Color color = colors[index % colors.length];
                            return GestureDetector(
                              onTap: () {
                                _categoryController.fetchSubjects(category.id);
                                Get.to(() => SubjectPage());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: color,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        category.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:Color(0xFF292D3D),),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${category.serviceYear}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionList(String title, RxList<Session> sessions) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Divider(color: Colors.white, height: 1)),
              SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Inter')),
              SizedBox(width: 8),
              Expanded(child: Divider(color: Colors.white, height: 1)),
            ],
          ),
        ),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Stack(
                  children: [
                    Container(
                      width: 77,
                      height: 73,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF5FE),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(session.parentServiceName, textAlign: TextAlign.center),
                            SizedBox(height: 5),
                            //Text(session.serviceID.toString(), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55, top: 5),
                      child: Container(
                        width: 23,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0BFD6B),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tired/search.dart';

import 'NewSub.dart';
import 'controllers/FavoriteCategory.dart';
import 'controllers/ServiceController.dart';
import 'model/service_model.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final ServiceController _serviceController = Get.put(ServiceController());
  final TextEditingController _searchController = TextEditingController();
  final FavoriteController _categoryController = Get.put(FavoriteController());
  final List<Color> colors = [
    Color(0xFF9C66F3),
    Color(0xFF33A7E7),
    Color(0xFFFF8932),
    Color(0xFFEF5173),
    Color(0xFFDBC6FC),
    Color(0xFF77B8A1),
    Color(0xFFFF8932),
    Color(0xFF33A7E7),
    Color(0xFF9C66F3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'ITE',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset('assets/icon/more.svg'),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset('assets/icon/notification.svg'),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF292D3D),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 400,
                height: 120,
                child: Stack(
                  children: [
                    Positioned(
                      width: 350,
                      height: 52,
                      left: 24,
                      top: 24,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Color(0xFF9DA7AE),
                        ),
                        child: TextField(

                          controller: _searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 50),
                          ),
                          onSubmitted: (query) {
                            Get.to(() => SearchResultsPage(query: query));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Positioned(
                      left: 40,
                      top: 36,
                      child: SvgPicture.asset('assets/icon/search.svg'),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 20,right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 8), // المسافة بين الخطوط والنص
                  Text(
                    'Theoretical',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Inter',
                      // height: 1.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25,  ),
                    child: Stack(
                      children: [
                        Container(
                          width: 77,
                          height: 73,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF5FE),
                            shape: BoxShape.circle,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 55,top: 5 ),
                          child: Container(
                            width: 23,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xFF0BFD6B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 20,right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Practical',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Inter',
                      // height: 1.5,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25,  ),
                    child: Stack(
                      children: [
                        Container(
                          width: 77,
                          height: 73,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF5FE),
                            shape: BoxShape.circle,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 55,top: 5 ),
                          child: Container(
                            width: 23,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0BFD6B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    width:  MediaQuery.of(context).size.width,
                    height: 449,
                    margin: const EdgeInsets.only(left: 2, top: 100),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Obx(
                            () => _categoryController.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: _categoryController.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final category = _categoryController.categories[index];
                            Color color = colors[index % colors.length];
                            return GestureDetector(
                              onTap: () {
                                _categoryController.fetchSubjects(category.id);
                                Get.to(() => SubjectPage());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: color,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        category.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${category.serviceYear}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:tired/subjects.dart';
//
// import 'NewSub.dart';
// import 'controllers/CategoryController.dart';
// import 'controllers/FavoriteCategory.dart';
// import 'controllers/ServiceController.dart';
//
//
// class home_page extends StatefulWidget {
//
//   const home_page({Key? key}) : super(key: key);
//
//   @override
//   State<home_page> createState() => _home_pageState();
// }
//
// class _home_pageState extends State<home_page> {
//   final FavoriteController _categoryController = Get.put(FavoriteController());
//
//
//
//   final List<Color> colors = [
//
//     Color(0xFF9C66F3),
//     Color(0xFF33A7E7),
//     Color(0xFFFF8932),
//     Color(0xFFEF5173),
//     Color(0xFFDBC6FC),
//     Color(0xFF77B8A1),
//     Color(0xFFFF8932),
//     Color(0xFF33A7E7),
//     Color(0xFF9C66F3),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60),
//         child: AppBar(
//           title: Text(
//             'ITE',
//             style: TextStyle(
//               fontSize: 30,
//               color: Colors.white,
//               fontFamily: 'Inter',
//             ),
//           ),
//           backgroundColor: Colors.transparent, // جعل الخلفية شفافة
//           elevation: 0, // إزالة الحدود
//           centerTitle: true, // توسيط عنوان الـ AppBar
//           leading: IconButton(
//             icon: SvgPicture.asset(
//               'assets/icon/more.svg',
//             ),
//             onPressed: () {
//             },
//           ),
//           actions: [
//
//             IconButton(
//               icon: SvgPicture.asset(
//                 'assets/icon/notification.svg',
//               ), onPressed: () {  },
//             ),
//
//           ],
//         ),
//       ),
//         backgroundColor: Color(0xFF292D3D),
//      body: SingleChildScrollView(
//       child: Column(
//       children: [
//         Center(
//           child: Container(
//             width: 400,
//             height: 120,
//             child: Stack(
//               children: [
//
//                 Positioned(
//                   width: 350,
//                   height: 52,
//                   left: 24,
//                   top: 24,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(13),
//                       color: Color(0xFF9DA7AE),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   width: 33,
//                   height: 33,
//                   left: 40,
//                   top: 34,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(13),
//                       color: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   width: 117,
//                   height: 34,
//                   left: 102,
//                   top: 42,
//                   child: Text(
//                     'Search',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontFamily: 'Inter',
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 50,
//                   top: 36,
//                   child: SvgPicture.asset(
//                     'assets/icon/search.svg',
//                   ),
//
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 25.0, bottom: 20,right: 25),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Divider(
//                   color: Colors.white,
//                   height: 1,
//                 ),
//               ),
//               SizedBox(width: 8), // المسافة بين الخطوط والنص
//               Text(
//                 'Theoretical',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontFamily: 'Inter',
//                  // height: 1.5,
//                 ),
//               ),
//               SizedBox(width: 8), // المسافة بين الخطوط والنص
//               Expanded(
//                 child: Divider(
//                   color: Colors.white,
//                   height: 1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 10, // تعديل عدد العناصر حسب الحاجة
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 25,  ),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 77,
//                       height: 73,
//                       decoration: BoxDecoration(
//                         color: Color(0xFFEFF5FE),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     //SizedBox(width: 46), // مسافة بين الدوائر
//                     Padding(
//                       padding: const EdgeInsets.only(left: 55,top: 5 ),
//                       child: Container(
//                         width: 23,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           color: Color(0xFF0BFD6B),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 25.0, bottom: 20,right: 25),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: const [
//               Expanded(
//                 child: Divider(
//                   color: Colors.white,
//                   height: 1,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'Practical',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontFamily: 'Inter',
//                   // height: 1.5,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: Divider(
//                   color: Colors.white,
//                   height: 1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 10,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 25,  ),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 77,
//                       height: 73,
//                       decoration: const BoxDecoration(
//                         color: Color(0xFFEFF5FE),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.only(left: 55,top: 5 ),
//                       child: Container(
//                         width: 23,
//                         height: 20,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFF0BFD6B),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         Stack(
//         children: [
//               Center(
//               child: Container(
//                   width:  MediaQuery.of(context).size.width,
//                   height: 449,
//                   margin: const EdgeInsets.only(left: 2, top: 100),
//                   decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                   ),
//                   color: Colors.white,
//                   ),
//                         child: Padding(
//                         padding: const EdgeInsets.all(25.0),
//                         child: Obx(
//                             () => _categoryController.isLoading.value
//                             ? Center(child: CircularProgressIndicator())
//                             : GridView.builder(
//                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             mainAxisSpacing: 20,
//                             crossAxisSpacing: 20,
//                             childAspectRatio: 1.0,
//                           ),
//               itemCount: _categoryController.categories.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final category = _categoryController.categories[index];
//                 Color color = colors[index % colors.length];
//                 return GestureDetector(
//                   onTap: () {
//                     _categoryController.fetchSubjects(category.id);
//                     Get.to(() => SubjectPage());
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: color,
//                     ),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             category.name,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             '${category.serviceYear}',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//
//         ),
//         ),
//
//         ],
//         ),
//       ],
//     ),
//     ),
//     );
//
//   }
// }