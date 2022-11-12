import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// My custom error message
///
/// It returnes the default error msg if it was in debug mode,
/// If it was in production mode then it returnes a nice error msg,
/// And copies the error Msg to the clipboard
class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(
    this.details, {
    Key? key,
  }) : super(key: key);

  final FlutterErrorDetails details;
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    }

    /// copy the error data to the clipboard
    Clipboard.setData(
      ClipboardData(text: "${details.exception}\nStack trace:\n${details.stack}"),
    );

    return SafeArea(
      child: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: SingleChildScrollView(
            child: ExpansionTile(
              tilePadding: EdgeInsets.all(15.sp),
              childrenPadding: EdgeInsets.all(15.sp),
              backgroundColor: Colors.red.shade200,
              collapsedBackgroundColor: Colors.red.shade200,
              title: Text('Error\n${details.exception}'),
              children: [
                Text('Stack trace:\n${details.stack}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
