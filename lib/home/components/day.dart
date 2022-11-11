import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  const Day(
    this.day, {
    this.hasEvents = false,
    this.hasParticipation = false,
    this.currentMonth = true,
    this.color,
    this.isToday = false,
    Key? key,
  })  : assert(!(hasEvents || hasParticipation) || color != null),
        super(key: key);

  final int day;
  final bool hasEvents;
  final bool hasParticipation;
  final Color? color;
  final bool currentMonth;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final text = Text('$day');
    return currentMonth
        ? hasEvents
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: isToday
                      ? CircleBorder(side: BorderSide(color: color!))
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: color!)),
                  elevation: 0,
                  backgroundColor: color,
                ),
                onPressed: () => _detailsBottomSheet(
                  context: context,
                  child:
                      text, //criar página de detalhes para eventos com participação
                  //routeName: 'routeName',
                ),
                child: text,
              )
            : hasParticipation
                ? OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: color,
                      side: BorderSide(width: 2.0, color: color!),
                      shape: isToday
                          ? const CircleBorder()
                          : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                    ),
                    onPressed: () => _detailsBottomSheet(
                      context: context,
                      child:
                          text, //criar página de detalhes para eventos sem participação
                      //routeName: 'routeName',
                    ),
                    child: text,
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: Colors.black54,
                      side: const BorderSide(
                        width: 2.0,
                        color: Colors.black45,
                      ),
                      shape: isToday
                          ? const CircleBorder()
                          : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                    ),
                    onPressed: null,
                    child: text,
                  )
        : TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              foregroundColor: Colors.black45,
            ),
            onPressed: null,
            child: text,
          );
  }
}

Future<T?> _detailsBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  //required String routeName,
  bool enableDrag = true,
  bool isDismissible = true,
  bool useRootNavigator = false,
  bool showTopDotGrey = true,
  bool isScrollControlled = false,
  double heightRatio = 0.5,
}) async =>
    await showModalBottomSheet<T>(
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      context: context,
      //routeSettings: RouteSettings(name: routeName),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      builder: (BuildContext context) => SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * heightRatio,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                child,
                Visibility(
                  visible: showTopDotGrey,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: SizedBox.shrink(), //ModalPill(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
