import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/create_log_project/bindings/create_log_project_binding.dart';
import '../modules/create_log_project/views/create_log_project_view.dart';
import '../modules/create_update_customer/bindings/create_update_customer_binding.dart';
import '../modules/create_update_customer/views/create_update_customer_view.dart';
import '../modules/create_update_error_bug/bindings/create_update_error_bug_binding.dart';
import '../modules/create_update_error_bug/views/create_update_error_bug_view.dart';
import '../modules/create_update_project/bindings/create_update_project_binding.dart';
import '../modules/create_update_project/views/create_update_project_view.dart';
import '../modules/error_bug_tickets/bindings/error_bug_tickets_binding.dart';
import '../modules/error_bug_tickets/views/error_bug_tickets_view.dart';
import '../modules/error_bug_tickets_customer/bindings/error_bug_tickets_customer_binding.dart';
import '../modules/error_bug_tickets_customer/views/error_bug_tickets_customer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list_customer/bindings/list_customer_binding.dart';
import '../modules/list_customer/views/list_customer_view.dart';
import '../modules/list_project/bindings/list_project_binding.dart';
import '../modules/list_project/views/list_project_view.dart';
import '../modules/list_project_customer/bindings/list_project_customer_binding.dart';
import '../modules/list_project_customer/views/list_project_customer_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/logs_project/bindings/logs_project_binding.dart';
import '../modules/logs_project/views/logs_project_view.dart';
import '../modules/logs_project_customer/bindings/los_project_customer_binding.dart';
import '../modules/logs_project_customer/views/los_project_customer_view.dart';
import '../modules/update_project_customer/bindings/update_project_customer_binding.dart';
import '../modules/update_project_customer/views/update_project_customer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CUSTOMER,
      page: () => ListCustomerView(),
      binding: ListCustomerBinding(),
    ),
    GetPage(
      name: _Paths.LIST_PROJECT,
      page: () => ListProjectView(),
      binding: ListProjectBinding(),
    ),
    GetPage(
      name: _Paths.ERROR_BUG_TICKETS,
      page: () => ErrorBugTicketsView(),
      binding: ErrorBugTicketsBinding(),
    ),
    GetPage(
      name: "${_Paths.CREATE_UPDATE_CUSTOMER}/:type/:uid",
      page: () => CreateUpdateCustomerView(),
      binding: CreateUpdateCustomerBinding(),
    ),
    GetPage(
      name: "${_Paths.CREATE_UPDATE_PROJECT}/:type/:id",
      page: () => CreateUpdateProjectView(),
      binding: CreateUpdateProjectBinding(),
    ),
    GetPage(
      name: "${_Paths.LOGS_PROJECT}/:id",
      page: () => LogsProjectView(),
      binding: LogsProjectBinding(),
    ),
    GetPage(
      name: "${_Paths.CREATE_LOG_PROJECT}/:id",
      page: () => CreateLogProjectView(),
      binding: CreateLogProjectBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_UPDATE_ERROR_BUG,
      page: () => CreateUpdateErrorBugView(),
      binding: CreateUpdateErrorBugBinding(),
    ),
    GetPage(
      name: _Paths.LIST_PROJECT_CUSTOMER,
      page: () => ListProjectCustomerView(),
      binding: ListProjectCustomerBinding(),
    ),
    GetPage(
      name: "${_Paths.UPDATE_PROJECT_CUSTOMER}/:id",
      page: () => UpdateProjectCustomerView(),
      binding: UpdateProjectCustomerBinding(),
    ),
    GetPage(
      name: "${_Paths.LOGS_PROJECT_CUSTOMER}/:id",
      page: () => LogsProjectCustomerView(),
      binding: LogsProjectCustomerBinding(),
    ),
    GetPage(
      name: _Paths.ERROR_BUG_TICKETS_CUSTOMER,
      page: () => ErrorBugTicketsCustomerView(),
      binding: ErrorBugTicketsCustomerBinding(),
    ),
  ];
}
