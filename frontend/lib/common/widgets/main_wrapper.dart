import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/controllers/drawer_controller.dart';
import 'package:frontend/common/widgets/custom_app_bar.dart';
import 'package:frontend/common/widgets/custom_drawer.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:get/get.dart' as gx;
import 'package:responsive_framework/responsive_framework.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({
    super.key,
    required this.content,
    this.fab,
  });

  final Widget content;
  final FloatingActionButton? fab;

  final drawerController = gx.Get.find<CustomDrawerController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(
          controller: drawerController,
        ),
        floatingActionButton: fab,
        drawerEnableOpenDragGesture: !kIsWeb,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ResponsiveVisibility(
              visible: false,
              visibleConditions: [Condition.smallerThan(name: DESKTOP)],
              child: CustomAppBar(),
            ),
            Expanded(
              child: Row(
                children: [
                  ResponsiveVisibility(
                    visible: true,
                    hiddenConditions: const [
                      Condition.smallerThan(name: DESKTOP)
                    ],
                    child: SizedBox(
                      width: 250,
                      child: CustomDrawer(
                        controller: drawerController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ResponsiveVisibility(
                            visible: false,
                            visibleConditions: const [
                              Condition.smallerThan(name: DESKTOP)
                            ],
                            child: Wrap(
                              children: [
                                Image.asset(
                                  'assets/logos/icon-vetlink.png',
                                  width: 60.0,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SvgPicture.asset(
                                  'assets/logos/logo-first-vetlink.svg',
                                  semanticsLabel: 'VetLink Logo',
                                  height: 60.0,
                                ),
                                SvgPicture.asset(
                                  'assets/logos/logo-second-vetlink.svg',
                                  semanticsLabel: 'VetLink Logo',
                                  colorFilter: ColorFilter.mode(
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? darkAccentColor
                                          : Colors.black,
                                      BlendMode.srcIn),
                                  height: 60.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Expanded(child: content),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
