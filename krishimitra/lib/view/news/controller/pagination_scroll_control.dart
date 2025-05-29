import 'package:flutter/material.dart';

class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  late Function loadAction;

  void init({Function? initAction, required Function loadAction}) {
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    // Ensure the ScrollController is valid and initialized
    if (scrollController.hasClients && !stopLoading) {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.offset;

      // Only trigger loading when necessary
      if (currentScroll >= maxScroll * boundaryOffset && !isLoading) {
        isLoading = true;

        // Ensure loadAction() is awaited and properly handles its result
        loadAction().then((shouldStop) {
          // Reset loading state
          isLoading = false;

          // Increment the current page and update boundaryOffset
          currentPage++;
          boundaryOffset = 1 - 1 / (currentPage * 2); // Dynamic offset update

          // Stop loading if no more data to fetch
          if (shouldStop == true) {
            stopLoading = true;
          }
        }).catchError((error) {
          // Handle potential errors from loadAction
          debugPrint("Error in loadAction: $error");
          isLoading = false;
        });
      }
    }
  }


}
