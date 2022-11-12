import 'package:flutter/material.dart';

Future<T?> bottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double heightRatio = 0.3,
}) async =>
    await showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) => SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * heightRatio,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    height: 4.0,
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.black12,
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
