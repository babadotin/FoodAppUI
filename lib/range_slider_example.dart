import 'package:flutter/material.dart';

class RangeSliderExample extends StatefulWidget {
  const RangeSliderExample({Key? key}) : super(key: key);

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  RangeValues _currentRangeValues = const RangeValues(75, 125);
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startController.text = _currentRangeValues.start.round().toString();
    endController.text = _currentRangeValues.end.round().toString();
  }

  int cuisineSllectedButtonIndex = -1;
  final List<String> cuisineButtonNames = [
    'American',
    'Arbic',
    'Asian',
    'Chinese'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Calorific Value',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Container(
                height: 30,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextField(
                      controller: startController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                      decoration: const InputDecoration(
                        fillColor: Colors.green,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        final value = int.tryParse(text) ?? 0;
                        setState(
                          () {
                            _currentRangeValues = RangeValues(
                              value.toDouble() < 65
                                  ? 65
                                  : value.toDouble() >= _currentRangeValues.end
                                      ? _currentRangeValues.end
                                      : value.toDouble(),
                              _currentRangeValues.end,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Text('to'),
              ),
              Container(
                height: 30,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 214, 214, 214),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: TextField(
                      controller: endController,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        final value = int.tryParse(text) ?? 0;
                        setState(
                          () {
                            _currentRangeValues = RangeValues(
                              _currentRangeValues.start,
                              value.toDouble() > 600
                                  ? 600
                                  : value.toDouble() <=
                                          _currentRangeValues.start
                                      ? _currentRangeValues.start
                                      : value.toDouble(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliderTheme(
          data: const SliderThemeData(
            rangeThumbShape: CircleThumbShape(),
          ),
          child: RangeSlider(
            activeColor: Colors.green,
            inactiveColor: const Color.fromARGB(255, 209, 209, 209),
            values: _currentRangeValues,
            max: 600,
            min: 65,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                startController.text = values.start.floor().toString();
                endController.text = values.end.floor().toString();
              });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25),
          child: Row(
            children: [
              Text(
                '65 Kcal',
                style: TextStyle(fontSize: 11),
              ),
              Spacer(),
              Text(
                '600 Kcal',
                style: TextStyle(fontSize: 11),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Cuisine',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: cuisineButtonNames.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cuisineSllectedButtonIndex = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: index == cuisineSllectedButtonIndex
                          ? Colors.green
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      cuisineButtonNames[index],
                      style: TextStyle(
                        color: index == cuisineSllectedButtonIndex
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CircleThumbShape extends RangeSliderThumbShape {
  const CircleThumbShape({this.thumbRadius = 10.0});

  final double thumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required SliderThemeData sliderTheme,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas
      ..drawCircle(center, thumbRadius, fillPaint)
      ..drawCircle(center, thumbRadius, borderPaint);
  }
}
