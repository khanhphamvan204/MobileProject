import 'package:flutter/material.dart';
import 'package:food_ordering/Utility/dimensions.dart';
import 'package:food_ordering/widgets/app_icon.dart';
import 'package:food_ordering/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  const AccountWidget({
    super.key,
    required this.appIcon,
    required this.bigText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.width10,
        bottom: Dimensions.height10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 5),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [appIcon, SizedBox(width: Dimensions.width20), bigText],
      ),
    );
  }
}
