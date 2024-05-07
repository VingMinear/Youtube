import 'package:flutter/material.dart';
import 'package:m_health_app/utils/Date.dart';
import 'package:m_health_app/utils/utils.dart';
import 'package:m_health_app/widget/ModifyRow.dart';
import 'package:m_health_app/widget/SplashButton.dart';
import 'package:m_health_app/widget/SvgIcon.dart';

class CustomDateWidget extends StatelessWidget {
  const CustomDateWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.onPickedStart,
    required this.onPickedEnd,
  });
  final String startDate, endDate;
  final Function(String date) onPickedStart;
  final Function(String date) onPickedEnd;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            date(title: 'From Date', date: startDate, onPicked: onPickedStart),
            const VerticalDivider(
              endIndent: 10,
              indent: 10,
              width: 30,
              thickness: 2,
              color: Colors.white,
            ),
            date(title: "End Date", date: endDate, onPicked: onPickedEnd),
          ],
        ),
      ),
    );
  }

  Widget date({
    required String title,
    required String date,
    required Function(String date) onPicked,
  }) {
    return Expanded(
      child: StatefulBuilder(builder: (context, state) {
        return ModifyRow(
          left: const Expanded(
            flex: 1,
            child: SvgIcon(
              'assets/icons/e-wallet/calendar.svg',
              color: Colors.white,
            ),
          ),
          right: Expanded(
            flex: 3,
            child: SplashButton(
              animate: false,
              onTap: () {
                dismissKeyboard();
                Date.picker(
                  context: context,
                  pickType: Pick.date,
                  onConfirm: (p0) {
                    date = p0;
                    onPicked(date);
                    state(() {});
                  },
                  initialDate: Date.parse(date),
                );
              },
              color: Colors.black.withOpacity(0.38),
              horizontal: 16,
              vertical: 10,
              borderRaduis: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
