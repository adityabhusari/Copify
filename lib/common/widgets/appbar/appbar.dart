
import 'package:copyify/common/helpers/is_dark_extension.dart';
import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget ? title;
  final Widget ? action;
  final bool hideBack;
  final Color ? bgColor;
  const BasicAppBar({
    this.hideBack = false,
    this.title = const Text(''),
    this.action,
    this.bgColor,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? Colors.transparent,
      title: title,
      actions: [
        action ?? Container()
      ],
      centerTitle: true ,
      elevation: 0,
      leading: hideBack ? null : IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: context.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
