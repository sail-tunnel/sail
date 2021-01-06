import 'package:flutter/material.dart';

class ServerItemWidget extends StatelessWidget {
  const ServerItemWidget(
      {Key key,
      @required this.label,
      @required this.icon,
      @required this.flagAsset,
      @required this.onTap, this.isFaded = false})
      : super(key: key);

  final String label;
  final IconData icon;
  final String flagAsset;
  final Function onTap;
  final isFaded;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  backgroundImage: ExactAssetImage(
                    flagAsset,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            IconButton(
              icon: Icon(icon),
              onPressed: onTap,
              iconSize: 18,
              color: isFaded ? Colors.grey : Theme.of(context).iconTheme.color,
            )
          ],
        ),
      ),
    );
  }
}
