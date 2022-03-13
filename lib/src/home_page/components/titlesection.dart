import 'package:flutter/material.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';

class TitleSection extends SliverFixedExtentList {
  TitleSection(String title, double height, {Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20, left: Dimensions.width20),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: Dimensions.font26,
                        fontFamily: 'SFBold',
                        color: AppColors.kMain,
                      ),
                    ),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
          itemExtent: height,
        );
}
