import 'package:flutter/material.dart';
// import 'package:flutter_application_1/range_slider_example.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int regimenSelectedButtonIndex = -1;
  int timingSelectedButtonIndex = -1;

  final List<String> regimenButtonNames = [
    'Breakfast',
    'Lunch',
    'Snacks',
    'Dinner',
  ];
  final List<String> timingButtonNames = [
    '15',
    '33',
    '45',
    '60',
  ];

  List<Widget> buttonNames = const [
    Icon(
      Icons.filter,
      size: 15,
    ),
    Text(
      'Cook Now',
    ),
    Text(
      'Breakfast',
    ),
    Text(
      'Low Price',
    ),
    Text(
      'Low Price',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: buttonNames.length,
            itemBuilder: (context, index) {
              return SizedBox(
                // height: buttonHeight,
                width: index == 0 ? 50.0 : 105.0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (index == 0) {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container();
                              },
                            );
                          },
                        );
                      }
                    },
                    child: buttonNames[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
