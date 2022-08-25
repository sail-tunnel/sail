import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, required this.userName, this.avatar, required this.onTap}) : super(key: key);

  final String? avatar;
  final String userName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24, left: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          avatar != null
              ? Row(
                  children: <Widget>[
                    ClipOval(child: Image(image: NetworkImage(avatar!), width: 40, height: 40)),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        userName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    )
                  ],
                )
              : Text(
                  userName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                ),
          avatar != null
              ? Material(
                  color: const Color(0x66000000),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: const Text(
                        '退出',
                        style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
