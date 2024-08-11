import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewGroup extends StatefulWidget {
  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  List<String> userNames = [
    'User1',
    'User2',
    'User3',
    // Add more usernames here...
  ];

  final List<String> suggestions = [
    'John',
    'Alice',
    'Bob',
    'Emily',
    'Michael',
    'Sophia',
    'William',
  ];

  TextEditingController _textEditingController = TextEditingController();
  List<TextEditingController> _addedControllers = [];

  void initState() {
    super.initState();
    _addedControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffFFFFFF),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/Ellipse/Ellipse 7.svg',
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Container(
                            width: 48,
                            height: 50.49,
                            child: FloatingActionButton(
                              backgroundColor: Color(0xffFF8B3A),
                              onPressed: () {
                                setState(() {
                                  _addedControllers.add(TextEditingController());
                                });
                              },
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9, top: 20),
                          child: Text(
                            'Add New Member',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xFFFF8B3A),
                              fontFamily: 'Inter',
                              height: 24 / 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _addedControllers.map((controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                return suggestions.where((String option) {
                                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                controller.text = selection;
                              },
                              fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9),
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  width: 300,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 5, top: 20),
                                  child: TextField(
                                    controller: fieldTextEditingController,
                                    focusNode: fieldFocusNode,
                                    onChanged: (String value) {
                                      setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.search),
                                      labelText: 'Type User Name',
                                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      labelStyle: TextStyle(fontSize: 14), // تحديد حجم النص
                                      border: InputBorder.none, // حذف الخط الخاص بال TextField
                                    ),
                                  ),
                                );

                              },
                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                if (options.isEmpty && controller.text.isNotEmpty) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      elevation: 4.0,
                                      child: SizedBox(
                                        height: 200.0,
                                        child: ListTile(
                                          title: Text('This name is not found'),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    child: SizedBox(
                                      height: 200.0,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: options.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          final String option = options.elementAt(index);
                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                            },
                                            child: ListTile(
                                              title: Text(option),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      }).toList(),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle submit action
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffB0E7D3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 160,
                        height: 60,
                        margin: EdgeInsets.only(left: 20, top: 160),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'Inter',
                              height: 29 / 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Center(child: Image(image: AssetImage('assets/images/group.png'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
