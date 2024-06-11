import 'package:bidbazar/widgets/buttonController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customRadioBtn extends StatelessWidget {
  customRadioBtn({
    super.key,
    this.isVisible,
    // required userType? usertype, //not necessary
  }); //: _usertype = usertype
  final bool? isVisible;
  // userType? _usertype;

  @override
  Widget build(BuildContext context) {
    // ButtonController controllerBtn = ButtonController();
    return GetBuilder<ButtonController>(
      builder: (controller) {
        return Row(
          children: [
            Visibility(
              visible: isVisible ?? true,
              child: Expanded(
                child: RadioListTile<userType>(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  dense: true,
                  // tileColor: Colors.orange.shade100,
                  title: Text(userType.Admin.name),
                  contentPadding: EdgeInsets.all(0.0),
                  value: userType.Admin,
                  groupValue: controller.getUserType,
                  onChanged: (value) async {
                    controller.setOrderType(value);
                    // _usertype = value;
                  },
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: RadioListTile<userType>(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(width: 1)),
                // tileColor: Color.fromARGB(255, 159, 154, 145),
                // tileColor: Colors.orange[800],
                dense: true,
                title: Text(userType.Seller.name),
                contentPadding: EdgeInsets.all(0.0),
                value: userType.Seller,
                groupValue: controller.getUserType,
                onChanged: (value) async {
                  controller.setOrderType(value);
                  // _usertype = value;
                },
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: RadioListTile<userType>(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                dense: true,
                // tileColor: Colors.orange.shade100,
                title: Text(userType.Buyer.name),
                contentPadding: EdgeInsets.all(0.0),
                value: userType.Buyer,
                groupValue: controller.getUserType,
                onChanged: (value) async {
                  controller.setOrderType(value);
                  // _usertype = value;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
