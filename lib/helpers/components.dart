import 'package:flutter/material.dart';

pushToStack(context, Widget) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return Widget;
  }));
}

pushToStackAndReplacement(context, Widget) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
    return Widget;
  }));
}

pushToStackAndRemove(context, Widget) {
  Navigator.of(context)
      .pushAndRemoveUntil(Widget, (Route<dynamic> route) => false);

  /* Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
    return Widget;
  }));*/
}

goBack(BuildContext context) {
  Navigator.of(context).pop();
}

/*showToast(BuildContext context, String msg) {
  final scaffold = ScaffoldMessenger.of(context);
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black54,
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return CustomAlertDialog(
        onTapXButton: () {
          Navigator.pop(context);
        },
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontFamily: "Hacen", fontSize: 12.sp),
          ),
        ),
        cardImgUrl: "assets/images/info.svg",
      );
    },
  );
}*/
