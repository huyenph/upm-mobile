import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/core/services/firebase_fcm.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/modules/auth/screens/forms/signin_form.dart';
import 'package:upm/modules/auth/screens/forms/signup_form.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/molecules/upm_app_bar.dart';

List<Widget> forms = [
  SigninForm(),
  SignupForm(),
];

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends BaseState<AuthScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  int _formIndex = 0;

  @override
  void initState() {
    super.initState();
    // // _initFirebaseFCM();
    // /// Create an Android Notification Channel.
    // ///
    // /// We use this channel in the `AndroidManifest.xml` file to override the
    // /// default FCM channel to enable heads up notifications.
    // await injector<FlutterLocalNotificationsPlugin>()
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(
    //       injector<AndroidNotificationChannel>(),
    //     );
    _tabController = TabController(
      initialIndex: _formIndex,
      length: forms.length,
      vsync: this,
    );
  }

  void _initFirebaseFCM(BuildContext context) {
    FirebaseFCM(context).registerNotification();
  }

  @override
  Widget buildBody(BuildContext context) {
    _initFirebaseFCM(context);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        padding: const EdgeInsets.symmetric(vertical: AppSize.fieldSpacingL),
        color: AppColors.backgroundLightColor,
        child: TabBarView(
          controller: _tabController,
          children: forms,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => UpmAppBar(
        title: '',
        backgroundColor: AppColors.backgroundLightColor,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(AppSize.fieldSpacingM),
              child: Icon(
                Icons.language_outlined,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      );
}
