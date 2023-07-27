import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pijetin/config/config.dart';
import 'package:pijetin/data/model/user/service/service.dart';
import 'package:pijetin/domain/controller/controller.dart';
import 'package:pijetin/domain/controller/user_controller/therapist_controller.dart';
import 'package:pijetin/utils/utils.dart';
import 'package:pijetin/view/pages/user/therapist_profile/therapist_profile_page.dart';
import 'package:pijetin/view/widget/card_therapist.dart';
import 'package:pijetin/view/widget/empty.dart';
import 'package:pijetin/view/widget/tab_bar_category.dart';
import 'package:pijetin/view/widget/widget.dart';

class NearbyTherapist extends StatefulWidget {
  const NearbyTherapist({super.key});

  @override
  State<NearbyTherapist> createState() => _NearbyTherapistState();
}

class _NearbyTherapistState extends State<NearbyTherapist> {
  final TherapistController controller = Get.put(TherapistController());
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.appBar(
        title: userController.myLocation.value,
        isWithFavorite: false,
        // leading: GestureDetector(
        //   onTap: () {
        //     sheetFilter(context);
        //   },
        //   child: Image.asset(
        //     AppIcon.moreIcon,
        //     height: 20.w,
        //     width: 20.w,
        //   ),
        // ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: controller.isTabLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.messageList.isEmpty
                      ? const SizedBox()
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: TabBarCategory(
                              selectedCategory:
                                  controller.selectedMassage.value,
                              onTap: (value) {
                                controller.selectedMassage.value = Service();
                                controller.changeSelectedMassage(value);
                                controller.filterTherapist(controller
                                    .selectedMassage.value.serviceId!);
                                // controller.getFilterTherapists(
                                //   rating: 1,
                                //   service: controller
                                //           .selectedMassage.value.serviceId ??
                                //       1,
                                // );
                              },
                              category: controller.messageList,
                              fonsize: 12,
                              centerTab: true,
                            ),
                          ),
                        ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: (controller.isLoadingList.value ||
                        controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.therapistList.isEmpty
                        ? const Center(
                            child: Empty(
                            title: "No Therapist Found",
                            subtitle: "Try another params",
                            width: 200,
                          ))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.therapistList.length,
                            itemBuilder: (context, index) {
                              return CardTherapist(
                                onTap: () => Get.to(() => TherapistPage(
                                    therapist:
                                        controller.therapistList[index])),
                                therapist: controller.therapistList[index],
                                isAppointment: false,
                              );
                            },
                          ),
              ),
            )
          ],
        );
      }),
    );
  }

  Future<dynamic> sheetFilter(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: AppColor.background,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Obx(() {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 24.h,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Filter',
                        style: AppFont.medium24,
                      ),
                    ),
                    16.0.height,
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            'Speciality',
                            style: AppFont.medium16,
                          ),
                          16.0.height,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: TabBarCategory(
                                selectedCategory:
                                    controller.selectedMassage.value,
                                onTap: (value) {
                                  controller.selectedMassage.value = Service();
                                  controller.changeSelectedMassage(value);
                                },
                                category: controller.messageList,
                                fonsize: 12,
                                centerTab: true,
                              ),
                            ),
                          ),
                          16.0.height,
                          Text(
                            'Rating',
                            style: AppFont.medium16,
                          ),
                          16.0.height,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: CustomTabBar(
                              titles: controller.number.toList(),
                              isRating: true,
                              selectedIndex: controller.tabBarRating.value,
                              onTap: (index) =>
                                  controller.changeTabRating(index),
                            ),
                          ),
                          16.0.height,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 24.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SecondaryButton(
                                    height: 52.h,
                                    borderColor: AppColor.background,
                                    backgroundColor:
                                        AppColor.primaryColor.withOpacity(0.2),
                                    title: 'Reset',
                                    onPressed: () {
                                      Get.back();
                                      controller.getTherapists();
                                    },
                                  ),
                                ),
                                16.0.width,
                                Expanded(
                                  child: PrimaryButton(
                                    height: 52.h,
                                    title: 'Apply',
                                    onPressed: () {
                                      Get.back();
                                      controller.getFilterTherapists(
                                        rating:
                                            controller.tabBarRating.value + 1,
                                        service: controller.selectedMassage
                                                .value.serviceId ??
                                            1,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
