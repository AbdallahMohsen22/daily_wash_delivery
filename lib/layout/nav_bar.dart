import 'package:flutter/material.dart';
import '../shared/styles/colors.dart';
import 'cubit/app_cubit.dart';

class NavBar extends StatelessWidget {
  final List<Map<String, Widget>> items;
  NavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Container(
      height: 100,
      color: Colors.transparent,
      padding:const EdgeInsets.only(bottom: 30,top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((e) {
          return InkWell(
            onTap: () => cubit.changeIndex(items.indexOf(e)),
            child: cubit.currentIndex == (items.indexOf(e))
                ? Container(
              height: 58,width: 58,
              decoration: BoxDecoration(
                color: defaultColor,
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: e['activeIcon'],
              ),
            )
                : e['icon']!,
          );
        }).toList(),
      ),
    );
  }
}
