import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:m_health_app/Models/FilterModel.dart';
import 'package:m_health_app/Pages/dashboard/components/CustomDateWidget.dart';
import 'package:m_health_app/utils/Debounce.dart';
import 'package:m_health_app/utils/colors.dart';
import 'package:m_health_app/widget/CustomRefresh.dart';
import 'package:m_health_app/widget/CustomTextField.dart';

import '../../../utils/Date.dart';

class FilterTemplate extends StatefulWidget {
  const FilterTemplate({
    super.key,
    required this.onChangeFilter,
    required this.child,
  });
  final Function(FilterParam param) onChangeFilter;
  final Widget child;
  @override
  State<FilterTemplate> createState() => _FilterTemplateState();
}

class _FilterTemplateState extends State<FilterTemplate> {
  TextEditingController searchCon = TextEditingController();
  var isSearch = false;
  var startDate = Date.format(Date.now);
  var endDate = Date.format(Date.now);

  var debouce = Debounce(milliseconds: 400);
  FilterParam get getParam {
    return FilterParam(
      searchTxt: searchCon.text.trim(),
      endDate: this.endDate,
      startDate: this.startDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch
          ? AppBar(
              backgroundColor: AppColor.primaryColor,
              surfaceTintColor: Colors.transparent,
              leading: FadeInDown(
                from: 5,
                duration: Durations.medium2,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                ),
              ),
              bottom: datePicker(),
              title: FadeIn(
                child: SizedBox(
                  height: kToolbarHeight - 15,
                  child: StatefulBuilder(builder: (context, rebuild) {
                    return CustomTextField(
                      autoFocus: true,
                      hint: "search".tr(),
                      controller: searchCon,
                      backGroundColor: AppColor.txtFieldColor,
                      suffixIcon: searchCon.text.isEmpty
                          ? null
                          : FadeIn(
                              child: IconButton(
                                onPressed: () {
                                  searchCon.clear();
                                  widget.onChangeFilter(getParam);
                                  rebuild(() {});
                                },
                                icon: const Icon(
                                  Icons.clear_rounded,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                      onChange: (text) {
                        debouce.run(() {
                          widget.onChangeFilter(getParam);
                        });

                        rebuild(() {});
                      },
                    );
                  }),
                ),
              ),
              actions: const [],
            )
          : AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: AppColor.primaryColor,
              actions: [
                FadeIn(
                  child: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                      });
                    },
                  ),
                ),
              ],
              bottom: datePicker(),
            ),
      body: CustomRefresh(
        onRefresh: () async {},
        onPagination: () {},
        child: widget.child,
      ),
    );
  }

  PreferredSize datePicker() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: CustomDateWidget(
        onPickedStart: (date) {
          startDate = date;
          widget.onChangeFilter(getParam);
        },
        onPickedEnd: (date) {
          endDate = date;
          widget.onChangeFilter(getParam);
        },
        startDate: this.startDate,
        endDate: this.endDate,
      ),
    );
  }
}
