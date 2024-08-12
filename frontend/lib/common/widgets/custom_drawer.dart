import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/controllers/drawer_controller.dart';
import 'package:frontend/styles/dark_theme.dart';
import 'package:frontend/styles/light_theme.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.controller});

  final CustomDrawerController controller;

  @override
  Widget build(BuildContext context) {
    controller.loadCurrentRoute();

    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Image.asset(
                    'assets/logos/icon-vetlink.png',
                    width: 30.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SvgPicture.asset(
                    'assets/logos/logo-first-vetlink.svg',
                    semanticsLabel: 'VetLink Logo',
                    height: 30.0,
                  ),
                  SvgPicture.asset(
                    'assets/logos/logo-second-vetlink.svg',
                    semanticsLabel: 'VetLink Logo',
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).brightness == Brightness.dark
                          ? darkAccentColor
                          : Colors.black,
                      BlendMode.srcIn,
                    ),
                    height: 30.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Wrap(
                runSpacing: 10.0,
                children: [
                  ...controller.getNavItems().map(
                        (item) => Obx(
                          () => ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              tileColor: controller.isActive(item['route'])
                                  ? Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? darkSecondaryColor
                                      : lightSecondaryColor
                                  : null,
                              leading: Icon(
                                item['icon']!,
                                size: 24.0,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? darkOnSurfaceColor
                                    : lightOnSurfaceColor,
                              ),
                              title: Text(
                                item['title']!,
                                style: smallSemiboldPoppins.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? darkOnSurfaceColor
                                      : lightOnSurfaceColor,
                                ),
                              ),
                              onTap: () => controller.goTo(item['route'])),
                        ),
                      ),
                ],
              ),
              const Divider(),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                leading: Icon(
                  Icons.logout,
                  size: 24.0,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? darkOnSurfaceColor
                      : lightOnSurfaceColor,
                ),
                title: Text(
                  'Logout',
                  style: smallSemiboldPoppins.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? darkOnSurfaceColor
                        : lightOnSurfaceColor,
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
