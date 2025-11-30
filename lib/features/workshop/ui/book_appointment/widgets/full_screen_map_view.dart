import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullscreenMapView extends StatefulWidget {
  final Widget mapWidget;
  final Color? buttonColor;
  final Function? goToLocation;

  const FullscreenMapView({
    super.key,
    required this.mapWidget,
    this.buttonColor,
    this.goToLocation,
  });

  @override
  State<FullscreenMapView> createState() => _FullscreenMapViewState();
}

class _FullscreenMapViewState extends State<FullscreenMapView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // _scaleAnimation = Tween<double>(
    //   begin: 0.8,
    //   end: 1.0,
    // ).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeOutBack,
    // ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _closeFullscreen() async {
    await _controller.reverse();
    // if (mounted) {
    //   Get.back();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // onWillPop: () async {
      //   await _closeFullscreen();
      //   return false;
      // },
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          await _closeFullscreen();
          return;
        }
        Get.back(result: result);
      },
      child: Scaffold(
        body: SafeArea(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Stack(
                  children: [
                    // Fullscreen map
                    // Transform.scale(
                    //   scale: _scaleAnimation.value,
                    SizedBox.expand(
                      child: widget.mapWidget,
                    ),

                    // Back button
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(100),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () => Get.back(),
                            borderRadius: BorderRadius.circular(50),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Back button
                    if (widget.goToLocation != null)
                      Positioned(
                        bottom: 120,
                        right: 16,
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () => widget.goToLocation?.call(),
                              borderRadius: BorderRadius.circular(50),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  FluentIcons.location_20_regular,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Optional: Exit fullscreen button (alternative position)
                    // SafeArea(
                    //   child: Positioned(
                    //     top: 16,
                    //     right: 24,
                    //     child: Material(
                    //       color: Colors.transparent,
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(12),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black.withAlpha(100),
                    //               blurRadius: 8,
                    //               offset: const Offset(0, 2),
                    //             ),
                    //           ],
                    //         ),
                    //         child: InkWell(
                    //           onTap: () => Get.back(),
                    //           borderRadius: BorderRadius.circular(12),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(12.0),
                    //             child: Icon(
                    //               Icons.fullscreen_exit,
                    //               color: buttonColor ?? const Color(0xFF2196F3),
                    //               size: 24,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
