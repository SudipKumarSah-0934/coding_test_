import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import '../../../../utils/strings_enum.dart';
import '../../../components/api_error_widget.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/my_widgets_animator.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_shimmer.dart';
import 'widgets/weather_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final TextEditingController searchController = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: GetBuilder<HomeController>(
            builder: (controller) => RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                // Perform refresh action
                WeatherCard(weather: controller.currentWeather);
              },
              child: MyWidgetsAnimator(
                apiCallStatus: controller.apiCallStatus,
                loadingWidget: () => const HomeShimmer(),
                errorWidget: () => ApiErrorWidget(
                  retryAction: () => controller.getUserLocation(),
                ),
                successWidget: () => ListView(
                  children: [
                    20.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.helloNote.tr,
                                style: theme.textTheme.displayMedium,
                              ),
                              8.verticalSpace,
                              Text(
                                Strings.discoverTheWeather.tr,
                                style: theme.textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                        20.horizontalSpace,
                        Obx(() => CustomIconButton(
                              onPressed: () {
                                controller.toggleSearchPane();
                                if (!controller.showSearchPane.value) {
                                  searchController.clear();
                                }
                              },
                              icon: Icon(
                                controller.showSearchPane.value
                                    ? Icons.close
                                    : Icons.search,
                              ),
                            )),
                        20.horizontalSpace,
                        CustomIconButton(
                          onPressed: () => controller.onChangeThemePressed(),
                          icon: GetBuilder<HomeController>(
                            id: controller.themeId,
                            builder: (_) => Icon(
                              controller.isLightTheme
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              color: theme.iconTheme.color,
                            ),
                          ),
                          borderColor: theme.dividerColor,
                        ),
                      ],
                    ).animate().fade().slideX(
                          duration: 300.ms,
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                    24.verticalSpace,
                    Obx(() {
                      if (controller.showSearchPane.value) {
                        return Column(
                          children: [
                            Focus(
                              onFocusChange: (hasFocus) {
                                // Trigger re-build when focus changes
                                controller.update();
                              },
                              child: TextField(
                                controller: searchController,
                                focusNode: searchFocusNode,
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isSearching.value
                                          ? Icons.close
                                          : Icons.search,
                                    ),
                                    onPressed: () {
                                      if (controller.isSearching.value) {
                                        controller.clearSearch();
                                        searchController.clear();
                                      } else {
                                        controller
                                            .search(searchController.text);
                                      }
                                    },
                                  ),
                                  errorText:
                                      controller.searchError.value.isEmpty
                                          ? null
                                          : controller.searchError.value,
                                ),
                                onSubmitted: (value) {
                                  controller.search(value);
                                },
                              ),
                            ),
                            16.verticalSpace,
                            Obx(() {
                              if (controller.searchResults.isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Search Results',
                                      style: theme.textTheme.displayMedium,
                                    ),
                                    16.verticalSpace,
                                    WeatherCard(
                                      weather: controller.weatherByCity,
                                    )
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 170.h,
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  onPageChanged: controller.onCardSlided,
                                ),
                                itemCount: 3,
                                itemBuilder:
                                    (context, itemIndex, pageViewIndex) {
                                  return WeatherCard(
                                    weather: controller.currentWeather,
                                  );
                                },
                              ).animate().fade().slideY(
                                    duration: 300.ms,
                                    begin: 1,
                                    curve: Curves.easeInSine,
                                  ),
                            ),
                            16.verticalSpace,
                            GetBuilder<HomeController>(
                              id: controller.dotIndicatorsId,
                              builder: (_) => Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: controller.activeIndex,
                                  count: 3,
                                  effect: WormEffect(
                                    activeDotColor: theme.primaryColor,
                                    dotColor: theme.colorScheme.secondary,
                                    dotWidth: 10.w,
                                    dotHeight: 10.h,
                                  ),
                                ),
                              ),
                            ),
                            24.verticalSpace,
                            Text(
                              Strings.aroundTheWorld.tr,
                              style: theme.textTheme.displayMedium,
                            ).animate().fade().slideX(
                                  duration: 300.ms,
                                  begin: -1,
                                  curve: Curves.easeInSine,
                                ),
                            16.verticalSpace,
                            ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  controller.weatherArroundTheWorld.length,
                              separatorBuilder: (context, index) =>
                                  16.verticalSpace,
                              itemBuilder: (context, index) => WeatherCard(
                                weather:
                                    controller.weatherArroundTheWorld[index],
                              ).animate(delay: (100 * index).ms).fade().slideY(
                                    duration: 300.ms,
                                    begin: 1,
                                    curve: Curves.easeInSine,
                                  ),
                            ),
                            16.verticalSpace,
                          ],
                        );
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
