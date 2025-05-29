import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry; // Add this parameter

  const NoInternetWidget({
    Key? key,
    this.onRetry, // Add this to constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_wifi_off,
            size: 100.sp,
            color: Colors.grey,
          ),
          SizedBox(height: 20.h),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Please check your internet connection',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
          if (onRetry != null) // Only show button if onRetry is provided
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ),
        ],
      ),
    );
  }
}
