class PermissionSlugs {
  PermissionSlugs._();

  // Clinic Working Days
  static const manageWorkingDays = 'clinic-manage-working-days';

  // Clinic User Working Days
  static const manageUserWorkingDays = 'clinic-manage-user-working-days';

  // Clinic Availability Exceptions
  static const manageUserAvailabilityExceptions =
      'clinic-manage-user-availability-exceptions';
  static const showUserAvailabilityExceptions =
      'show-clinic-user-availability-exceptions';

  // Clinic Holidays
  static const manageHolidays = 'clinic-manage-holidays';

  // Subscriptions
  static const getSubscriptionInfo = 'get-current-clinic-subscription-info';
  static const requestSubscription = 'request-clinic-subscription';

  // Clinic Payments
  static const viewClinicPayments = 'view-clinic-payments';
  static const submitClinicPayments = 'submit-clinic-payments';

  /// The four slugs a `billing_only` clinic keeps. Holding any of them is
  /// what makes the subscription section visible - they are granted to the
  /// ADMIN role only, and everyone else gets 403 on every billing call.
  static const billing = [
    getSubscriptionInfo,
    requestSubscription,
    viewClinicPayments,
    submitClinicPayments,
  ];

  // Clinic Patients
  static const viewClinicPatients = 'view-clinic-patients';
  static const manageClinicPatients = 'clinic-manage-patients';

  // Clinic Expenses
  static const viewClinicExpenses = 'view-clinic-expenses';
  static const manageClinicExpenses = 'manage-clinic-expenses';

  // Clinic Appointments
  static const viewClinicAppointments = 'view-clinic-appointments';
  static const manageClinicAppointments = 'manage-clinic-appointments';

  // Clinic Management
  static const updateClinicInfo = 'update-clinic-info';
  static const manageStaff = 'clinic-manage-staff';

  // Media Management
  static const manageMedia = 'manage-media-files';
}
