import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectUrgentLevel extends StatefulWidget {
  const SelectUrgentLevel({super.key, required this.selectedStarsCount, required this.onChanged});

  final int selectedStarsCount;
  final ValueChanged<int> onChanged;

  @override
  State<SelectUrgentLevel> createState() => _SelectUrgentLevelState();
}

class _SelectUrgentLevelState extends State<SelectUrgentLevel> {
  int count = 0;

  @override
  void initState() {
    count = widget.selectedStarsCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            count,
                (index) => GestureDetector(
              onTap: () {
                setState(() {
                  count = index + 1;
                  widget.onChanged.call(count);
                });
              },
              child:const Icon(
                Icons.star,
                size: 30,
                color: Colors.yellow,
              ),
            ),
          ),
          ...List.generate(
            5 - count,
                (index) => GestureDetector(
              onTap: () {
                setState(() {
                  count = index + 1 + count;
                  widget.onChanged.call(count);
                });
              },
              child: const Icon(
               Icons.star,
                size: 30,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
