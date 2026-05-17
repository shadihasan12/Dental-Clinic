/// Route names for the application
class AppRoutesNames {
  AppRoutesNames._();

  // Main Routes
  static const String root = 'root';
  static const String home = 'home';
  static const String onboarding = 'onboarding';

  // Authentication Routes
  static const String login = 'login';
  static const String register = 'register';
  static const String emailEntry = 'emailEntry';
  static const String verifyEmailEntry = 'verifyEmailEntry';
  static const String forgotPassword = 'forgotPassword';
  static const String choosePlan = 'choosePlan';
  static const String chooseClinicName = 'chooseClinicName';
  static const String emailVerification = 'emailVerification';
  static const String forgotPasswordVerifyOtp = 'forgotPasswordVerifyOtp';
  static const String setNewPassword = 'setNewPassword';
  static const String changeEmail = 'changeEmail';
  static const String changeEmailOtpPage = 'changeEmailOtpPage';

  // Dashboard
  static const String dashboard = 'dashboard';
  static const String notifications = 'notifications';

  // Appointments Routes
  static const String appointments = 'appointments';
  static const String appointmentDetails = 'appointmentDetails';
  static const String newAppointment = 'newAppointment';

  // Patients Routes
  static const String patients = 'patients';
  static const String patientDetails = 'patientDetails';
  static const String addPatient = 'addPatient';
  static const String editPatient = 'editPatient';

  // Case Routes
  static const String caseDetails = 'caseDetails';
  static const String newCase = 'newCase';

  // Doctors/Dentists Routes
  static const String doctors = 'doctors';
  static const String doctorDetails = 'doctorDetails';

  // Treatments Routes
  static const String treatments = 'treatments';
  static const String treatmentDetails = 'treatmentDetails';
  static const String addTreatment = 'addTreatment';

  // Statistics
  static const String statistics = 'statistics';

  // Profile Routes
  static const String profile = 'profile';
  static const String editProfile = 'editProfile';
  static const String settings = 'settings';
  static const String moreMenu = 'moreMenu';
  static const String clinicInfo = 'clinicInfo';
  static const String workingDays = 'workingDays';
  static const String userHours = 'userHours';
  static const String notificationsSettings = 'notificationsSettings';

  // Clinic Management Routes
  static const String pendingApprovals = 'pendingApprovals';
  static const String contactSupport = 'contactSupport';
  static const String supportChat = 'supportChat';

  // Dentist Routes
  static const String myClinics = 'myClinics';
  static const String createClinic = 'createClinic';
  static const String clinicUsers = 'clinicUsers';

  // Subscription Routes
  static const String pricing = 'pricing';
  static const String subscription = 'subscription';
  static const String manageSubscription = 'manageSubscription';

  // Billing Routes
  static const String billing = 'billing';
  static const String selectBillingPlan = 'selectBillingPlan';
  static const String invoiceDetails = 'invoiceDetails';
  static const String submitPaymentProof = 'submitPaymentProof';

  // Other Routes
  static const String medicalHistory = 'medicalHistory';
}
