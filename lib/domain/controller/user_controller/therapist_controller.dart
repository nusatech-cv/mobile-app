import 'dart:developer';

import 'package:get/get.dart';
import 'package:pijetin/data/model/user/therapist/therapist.dart';
import 'package:pijetin/domain/repository/repository.dart';

import 'package:pijetin/data/model/user/service/service.dart';

class TherapistController extends GetxController {
  var therapistList = <Therapist>[].obs;
  var therapistListInitial = <Therapist>[].obs;
  var topTherapistList = <Therapist>[].obs;
  var isLoadingList = false.obs;
  var isLoading = false.obs;
  var isTabLoading = false.obs;
  var messageListIndex = 0.obs;
  var messageList = <Service>[].obs;
  var selectedMassage = Service().obs;
  var disableFilter = true.obs;
  var tabBarSpeciality = 0.obs;
  var tabBarRating = 0.obs;

  List<String> number = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  @override
  void onInit() {
    getTherapists();
    getServices();
    super.onInit();
  }

  void changeSelectedMassage(Service value) {
    selectedMassage.value = value;
  }

  void changeTabSpeciality(int index) {
    tabBarSpeciality.value = index;
  }

  void changeTabRating(int index) {
    tabBarRating.value = index;
  }

  void selecteMessageListIndex(int index) {
    messageListIndex.value = index;
  }

  Future<void> getTherapists() async {
    isLoadingList.value = true;
    TherapistRepository therapistRepository = TherapistRepository();
    final response = await therapistRepository.getTherapist();
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = therapistFromJson(response.body!);
      log("latitude=> ${data[1].location!.x}");
      log("longitude=> ${data[1].location!.y}");
      therapistListInitial.assignAll(data);
      therapistList.assignAll(data);

      // for (var item in therapistList) {
      //   final location = await placemarkFromCoordinates(
      //       item.location!.y!, item.location!.x!);
      //   item.readableLocation =
      //       "${location.first.subAdministrativeArea} ${location.first.locality}";
      // }
      therapistList.refresh();
      topTherapistList.assignAll(therapistList);
    }

    log("therapist list : ${therapistList.length}");
    isLoadingList.value = false;
  }

  Future<void> getFilterTherapists(
      {required int rating, required int service}) async {
    therapistList.clear();
    try {
      isLoading.value = true;
      TherapistRepository therapistRepository = TherapistRepository();
      final response = await therapistRepository.getFilterTherapist(
        rating: rating,
        service: service,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = therapistFromJson(response.body!);
        therapistList
            .where((value) =>
                value.services!.first.name == selectedMassage.value.name)
            .toList()
            .assignAll(data);
        // for (var item in therapistList) {
        //   final location = await placemarkFromCoordinates(
        //       item.location!.x!, item.location!.y!);

        //   item.readableLocation =
        //       "${location.first.subAdministrativeArea} ${location.first.locality}";
        // }

        therapistList.refresh();
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw Exception(e.toString());
    }
  }

  filterTherapist(int servicesId) {
    List<Therapist> filteredTherapist = [];

    if (servicesId == 1000) {
      filteredTherapist.assignAll(therapistListInitial);
    } else {
      for (var therapist in therapistListInitial) {
        for (var service in therapist.services!) {
          if (service.serviceId == servicesId) {
            filteredTherapist.add(therapist);
          }
        }
      }
    }

    for (var element in filteredTherapist) {
      log(element.firstName!);
    }

    therapistList.assignAll(filteredTherapist);
    topTherapistList.assignAll(filteredTherapist);
    therapistList.refresh();
    topTherapistList.refresh();
  }

  Future<void> getServices() async {
    messageList.clear();
    isTabLoading.value = true;

    ServiceRepository serviceRepository = ServiceRepository();
    final response = await serviceRepository.getServices();

    messageList.add(Service(name: "All", serviceId: 1000));
    messageList.addAll(response);

    isTabLoading.value = false;
  }
}
