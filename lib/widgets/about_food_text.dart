import 'package:flutter/material.dart';
import 'package:food_app/utilities/colors.dart';
import 'package:food_app/utilities/dynamic_dimensions.dart';
import 'package:food_app/widgets/sub_text.dart';

// stateful is used since the Ui will be changing depending on a certain click
class AboutFoodText extends StatefulWidget {
  const AboutFoodText({super.key, required this.text});

  final String text;

  @override
  State<AboutFoodText> createState() => _AboutFoodTextState();
}

class _AboutFoodTextState extends State<AboutFoodText> {
  late String halfText;
  late String fullText;
  bool isLongText = false;

  double textHeight = DynamicDimensions.size150;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Getting the text height and spliting it to two to determine what to be display on the screen...
    if (widget.text.length > textHeight) {
      halfText = widget.text.substring(0, textHeight.toInt());
      fullText = widget.text.substring(
        textHeight.toInt() + 1,
        widget.text.length,
      );
    } else {
      halfText = widget.text;
      fullText = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          fullText.isEmpty
              ? SubText(
                text: halfText,
                height: DynamicDimensions.size2,
                fontSize: DynamicDimensions.size16,
                color: AppColors.paraColor,
                textAlign: TextAlign.justify,
              )
              : Column(
                children: [
                  SubText(
                    fontSize: DynamicDimensions.size16,
                    color: AppColors.paraColor,
                    height: DynamicDimensions.size2,
                    textAlign: TextAlign.justify,
                    text:
                        isLongText == false
                            ? '$halfText...'
                            : '$halfText$fullText',
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isLongText = !isLongText;
                      });
                    },
                    child: Row(
                      children: [
                        SubText(
                          text: isLongText == false ? 'Show more' : 'Show less',
                          color: AppColors.mainColor,
                          fontSize: DynamicDimensions.size16,
                        ),
                        Icon(
                          isLongText == false
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
