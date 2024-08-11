// import 'package:flutter/material.dart';
// import 'package:qrpro/Accounts/questions/questionController.dart';
// import 'package:qrpro/Accounts/questions/questionModel.dart';
//
// class Question extends StatefulWidget {
//   @override
//   _QuestionState createState() => _QuestionState();
// }
//
// class _QuestionState extends State<Question> {
//   bool isSelectMode = false;
//   List<bool> isSelectedList = List.generate(19, (index) => false);
//   List<int> favoriteStacks = [];
//   List<Color> itemColors = [
//     Color(0xFFFF8B3A),
//     Color(0xFFBFB9FD),
//     Color(0xFF77B8A1),
//   ];
//   List<String> itemTypes = [
//     'Favorite Color', 'Number of Sisters', 'Number of Brothers',
//     'Number of Mother\'s Sisters', 'Number of Father\'s Sisters', 'Number of Mother\'s Brothers', 'Number of Father\'s Brothers',
//     'Favorite Hobby', 'Favorite Sport', 'Favorite Season', 'Favorite Book Type',
//     'Favorite Travel Country', 'Favorite Food', 'Favorite Drink', 'Favorite Dessert',
//     'Baccalaureate Mark', 'Ninth Grade Mark'
//   ];
//   List<List<dynamic>> itemValues = [
//     ['Yellow', 'Black', 'White', 'Red', 'Blue', 'Green', 'Orange', 'Purple', 'Pink', 'Brown', 'Others'],
//     List.generate(31, (index) => index),
//     List.generate(31, (index) => index),
//     List.generate(31, (index) => index),
//     List.generate(31, (index) => index),
//     List.generate(31, (index) => index),
//     List.generate(31, (index) => index),
//     ['Reading', 'Writing', 'Drawing', 'Music', 'Others'],
//     ['Tennis', 'Football', 'Basketball', 'Swimming', 'Skiing', 'Ping Pong', 'Others'],
//     ['Summer', 'Winter', 'Spring', 'Autumn'],
//     ['Scientific', 'Science Fiction', 'Cultural', 'Religious', 'Fantasy', 'Romance', 'Detective And Action', 'Others'],
//     ['Germany', 'France', 'UAE', 'Saudi Arabia', 'Switzerland', 'Thailand', 'Malaysia', 'Egypt', 'Others'],
//     ['Kubba', 'Kabsa', 'Pasta', 'Pizza', 'Mahashi', 'Grape Leaves', 'Shawarma', 'Broasted', 'Others'],
//     ['Strawberry', 'Orange', 'Lemon', 'Tamarind', 'Fruits', 'Licorice', 'Mango', 'Carrot', 'Others'],
//     ['Kunafa', 'Cake', 'Ice Cream', 'Qatayef', 'Western Sweets', 'Others'],
//     List.generate(241, (index) => index),
//     List.generate(311, (index) => index),
//   ];
//   List<dynamic> selectedValues = List<dynamic>.filled(17, null); // Adjusted length to match itemTypes
//   DateTime? userBirthday;
//   DateTime? motherBirthday;
//   DateTime? fatherBirthday;
//
//   // Initialize the controller
//   final QuestionController _controller = QuestionController(QuestionModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF292D3D),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color(0xFF292D3D),
//         actions: [
//           if (isSelectMode)
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   for (int i = 0; i < isSelectedList.length; i++) {
//                     if (isSelectedList[i]) {
//                       favoriteStacks.add(i);
//                     }
//                   }
//                   isSelectMode = false;
//                 });
//               },
//               icon: Icon(Icons.star, color: Color(0xffFFB924)),
//             ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 60,
//             child: Center(
//               child: Text(
//                 'Questions',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
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
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: itemTypes.length + 3, // Added 3 for the date pickers
//                 itemBuilder: (BuildContext context, int index) {
//                   if (index < itemTypes.length) {
//                     return _buildListItem(index);
//                   } else {
//                     return _buildDatePicker(index - itemTypes.length);
//                   }
//                 },
//               ),
//             ),
//           ),
//           Center(
//             child: CustomElevatedButton(
//               text: 'Next',
//               color: Color(0xffFF7B1C),
//               onPressed: () {
//                 _controller.submitAnswers(
//                   selectedValues,
//                   userBirthday,
//                   motherBirthday,
//                   fatherBirthday,
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 20), // Add some space below the button
//         ],
//       ),
//     );
//   }
//
//   Widget _buildListItem(int index) {
//     final colorIndex = index % itemColors.length;
//     final lighterColor = itemColors[colorIndex].withOpacity(0.6);
//
//     return GestureDetector(
//       onLongPress: () {
//         setState(() {
//           isSelectMode = true;
//         });
//       },
//       child: Stack(
//         children: [
//           Center(
//             child: Container(
//               width: 284,
//               height: 100,
//               margin: EdgeInsets.only(left: 20, top: 50),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: lighterColor,
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     child: Text(
//                       itemTypes[index],
//                       style: TextStyle(color: Colors.black, fontSize: 12),
//                     ),
//                   ),
//                   Expanded(
//                     child: DropdownButton<dynamic>(
//                       value: selectedValues.isNotEmpty ? selectedValues[index] : null,
//                       onChanged: (newValue) {
//                         _updateSelectedValue(index, newValue);
//                       },
//                       items: itemValues[index].map<DropdownMenuItem<dynamic>>((value) {
//                         return DropdownMenuItem<dynamic>(
//                           value: value,
//                           child: _buildItemWidget(value),
//                         );
//                       }).toList(),
//                       style: TextStyle(color: Colors.black, fontSize: 12),
//                       icon: Icon(Icons.arrow_drop_down),
//                       iconSize: 30,
//                       isExpanded: true,
//                       underline: SizedBox(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: 18,
//             height: 100,
//             margin: EdgeInsets.only(left: 60, top: 50),
//             decoration: BoxDecoration(
//               color: selectedValues.isNotEmpty && selectedValues[index] != null ? itemColors[colorIndex] : lighterColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 bottomLeft: Radius.circular(10),
//               ),
//             ),
//           ),
//           if (isSelectMode)
//             Positioned(
//               top: 40,
//               right: 10,
//               child: Checkbox(
//                 value: isSelectedList[index],
//                 onChanged: (newValue) {
//                   setState(() {
//                     isSelectedList[index] = newValue!;
//                   });
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildItemWidget(dynamic value) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         value.toString(),
//         style: TextStyle(color: Colors.black),
//       ),
//     );
//   }
//
//   Widget _buildDatePicker(int datePickerIndex) {
//     String label;
//     DateTime? selectedDate;
//
//     switch (datePickerIndex) {
//       case 0:
//         label = 'Your Birthday';
//         selectedDate = userBirthday;
//         break;
//       case 1:
//         label = 'Mother\'s Birthday';
//         selectedDate = motherBirthday;
//         break;
//       case 2:
//         label = 'Father\'s Birthday';
//         selectedDate = fatherBirthday;
//         break;
//       default:
//         label = '';
//         selectedDate = null;
//     }
//
//     final lighterColor = Color(0xFFBFB9FD).withOpacity(0.6);
//
//     return GestureDetector(
//       onTap: () async {
//         final DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//         );
//         if (pickedDate != null && pickedDate != selectedDate) {
//           setState(() {
//             switch (datePickerIndex) {
//               case 0:
//                 userBirthday = pickedDate;
//                 break;
//               case 1:
//                 motherBirthday = pickedDate;
//                 break;
//               case 2:
//                 fatherBirthday = pickedDate;
//                 break;
//             }
//           });
//         }
//       },
//       child: Stack(
//         children: [
//           Center(
//             child: Container(
//               width: 284,
//               height: 100,
//               margin: EdgeInsets.only(left: 20, top: 50),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: lighterColor,
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     child: Text(
//                       label,
//                       style: TextStyle(color: Colors.black, fontSize: 12),
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       selectedDate != null
//                           ? "${selectedDate.toLocal()}".split(' ')[0]
//                           : "Select Date",
//                       style: TextStyle(color: Colors.black, fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             width: 18,
//             height: 100,
//             margin: EdgeInsets.only(left: 65, top: 50),
//             decoration: BoxDecoration(
//               color: lighterColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 bottomLeft: Radius.circular(10),
//               ),
//             ),
//           ),
//           if (isSelectMode)
//             Positioned(
//               top: 40,
//               right: 10,
//               child: Checkbox(
//                 value: false,
//                 onChanged: null,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _updateSelectedValue(int index, dynamic newValue) {
//     setState(() {
//       if (index < selectedValues.length) {
//         selectedValues[index] = newValue;
//       } else {
//         // Expand the list to fit the new index
//         selectedValues.length = index + 1;
//         selectedValues[index] = newValue;
//       }
//     });
//   }
//
// }
//
// class CustomElevatedButton extends StatelessWidget {
//   final String text;
//   final Color color;
//   final VoidCallback onPressed;
//
//   const CustomElevatedButton({
//     required this.text,
//     required this.color,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white, backgroundColor: color,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//       ),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'questionController.dart';
import 'questionModel.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool isSelectMode = false;
  List<bool> isSelectedList = List.generate(19, (index) => false);
  List<int> favoriteStacks = [];
  List<Color> itemColors = [
    Color(0xFFFF8B3A),
    Color(0xFFBFB9FD),
    Color(0xFF77B8A1),
  ];
  List<String> itemTypes = [
    'Favorite Color', 'Number of Sisters', 'Number of Brothers',
    'Number of Mother\'s Sisters', 'Number of Father\'s Sisters', 'Number of Mother\'s Brothers', 'Number of Father\'s Brothers',
    'Favorite Hobby', 'Favorite Sport', 'Favorite Season', 'Favorite Book Type',
    'Favorite Travel Country', 'Favorite Food', 'Favorite Drink', 'Favorite Dessert',
    'Baccalaureate Mark', 'Ninth Grade Mark'
  ];
  List<List<dynamic>> itemValues = [
    ['Yellow', 'Black', 'White', 'Red', 'Blue', 'Green', 'Orange', 'Purple', 'Pink', 'Brown', 'Others'],
    List.generate(31, (index) => index),
    List.generate(31, (index) => index),
    List.generate(31, (index) => index),
    List.generate(31, (index) => index),
    List.generate(31, (index) => index),
    List.generate(31, (index) => index),
    ['Reading', 'Writing', 'Drawing', 'Music', 'Others'],
    ['Tennis', 'Football', 'Basketball', 'Swimming', 'Skiing', 'Ping Pong', 'Others'],
    ['Summer', 'Winter', 'Spring', 'Autumn'],
    ['Scientific', 'Science Fiction', 'Cultural', 'Religious', 'Fantasy', 'Romance', 'Detective And Action', 'Others'],
    ['Germany', 'France', 'UAE', 'Saudi Arabia', 'Switzerland', 'Thailand', 'Malaysia', 'Egypt', 'Others'],
    ['Kubba', 'Kabsa', 'Pasta', 'Pizza', 'Mahashi', 'Grape Leaves', 'Shawarma', 'Broasted', 'Others'],
    ['Strawberry', 'Orange', 'Lemon', 'Tamarind', 'Fruits', 'Licorice', 'Mango', 'Carrot', 'Others'],
    ['Kunafa', 'Cake', 'Ice Cream', 'Qatayef', 'Western Sweets', 'Others'],
    List.generate(241, (index) => index),
    List.generate(311, (index) => index),
  ];
  List<dynamic> selectedValues = List<dynamic>.filled(17, null); // Adjusted length to match itemTypes
  DateTime? userBirthday;
  DateTime? motherBirthday;
  DateTime? fatherBirthday;

  // Initialize the controller
  final QuestionController _controller = QuestionController(QuestionModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292D3D),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF292D3D),
        actions: [
          if (isSelectMode)
            IconButton(
              onPressed: () {
                setState(() {
                  for (int i = 0; i < isSelectedList.length; i++) {
                    if (isSelectedList[i]) {
                      favoriteStacks.add(i);
                    }
                  }
                  isSelectMode = false;
                });
              },
              icon: Icon(Icons.star, color: Color(0xffFFB924)),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            child: Center(
              child: Text(
                'Questions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: itemTypes.length + 3, // Added 3 for the date pickers
                itemBuilder: (BuildContext context, int index) {
                  if (index < itemTypes.length) {
                    return _buildListItem(index);
                  } else {
                    return _buildDatePicker(index - itemTypes.length);
                  }
                },
              ),
            ),
          ),
          Center(
            child: CustomElevatedButton(
              text: 'Register',
              color: Color(0xffB0E7D3),
              onPressed: () {
                _controller.submitAnswers(
                  selectedValues,
                  userBirthday,
                  motherBirthday,
                  fatherBirthday,
                );
              },
            ),
          ),
          SizedBox(height: 20), // Add some space below the button
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    final colorIndex = index % itemColors.length;
    final lighterColor = itemColors[colorIndex].withOpacity(0.6);

    return GestureDetector(
      onLongPress: () {
        setState(() {
          isSelectMode = true;
        });
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 284,
              height: 100,
              margin: EdgeInsets.only(left: 20, top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lighterColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      itemTypes[index],
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<dynamic>(
                      value: selectedValues.isNotEmpty ? selectedValues[index] : null,
                      onChanged: (newValue) {
                        _updateSelectedValue(index, newValue);
                      },
                      items: itemValues[index].map<DropdownMenuItem<dynamic>>((value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: _buildItemWidget(value),
                        );
                      }).toList(),
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      isExpanded: true,
                      underline: SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 18,
            height: 100,
            margin: EdgeInsets.only(left: 60, top: 50),
            decoration: BoxDecoration(
              color: selectedValues.isNotEmpty && selectedValues[index] != null ? itemColors[colorIndex] : lighterColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          if (isSelectMode)
            Positioned(
              top: 40,
              right: 10,
              child: Checkbox(
                value: isSelectedList[index],
                onChanged: (newValue) {
                  setState(() {
                    isSelectedList[index] = newValue!;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemWidget(dynamic value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        value.toString(),
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildDatePicker(int datePickerIndex) {
    String label;
    DateTime? selectedDate;

    switch (datePickerIndex) {
      case 0:
        label = 'Your Birthday';
        selectedDate = userBirthday;
        break;
      case 1:
        label = 'Mother\'s Birthday';
        selectedDate = motherBirthday;
        break;
      case 2:
        label = 'Father\'s Birthday';
        selectedDate = fatherBirthday;
        break;
      default:
        label = '';
        selectedDate = null;
    }

    final lighterColor = Color(0xFFBFB9FD).withOpacity(0.6);

    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            switch (datePickerIndex) {
              case 0:
                userBirthday = pickedDate;
                break;
              case 1:
                motherBirthday = pickedDate;
                break;
              case 2:
                fatherBirthday = pickedDate;
                break;
            }
          });
        }
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 284,
              height: 100,
              margin: EdgeInsets.only(left: 20, top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: lighterColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      label,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? "${selectedDate.toLocal()}".split(' ')[0]
                          : "Select Date",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 18,
            height: 100,
            margin: EdgeInsets.only(left: 65, top: 50),
            decoration: BoxDecoration(
              color: lighterColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          if (isSelectMode)
            Positioned(
              top: 40,
              right: 10,
              child: Checkbox(
                value: false,
                onChanged: null,
              ),
            ),
        ],
      ),
    );
  }

  void _updateSelectedValue(int index, dynamic newValue) {
    setState(() {
      if (index < selectedValues.length) {
        selectedValues[index] = newValue;
      } else {
        // Expand the list to fit the new index
        selectedValues.length = index + 1;
        selectedValues[index] = newValue;
      }
    });
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
