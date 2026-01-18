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
  static const String forgotPassword = 'forgotPassword';
  static const String choosePlan = 'choosePlan';
  static const String chooseClinicName = 'chooseClinicName';

  // Dashboard
  static const String dashboard = 'dashboard';

  // Appointments Routes
  static const String appointments = 'appointments';
  static const String appointmentDetails = 'appointmentDetails';
  static const String bookAppointment = 'bookAppointment';

  // Patients Routes
  static const String patients = 'patients';
  static const String patientDetails = 'patientDetails';
  static const String addPatient = 'addPatient';

  // Case Routes
  static const String caseDetails = 'caseDetails';
  static const String newCase = 'newCase';

  // Doctors/Dentists Routes
  static const String doctors = 'doctors';
  static const String doctorDetails = 'doctorDetails';

  // Treatments Routes
  static const String treatments = 'treatments';
  static const String treatmentDetails = 'treatmentDetails';

  // Statistics
  static const String statistics = 'statistics';

  // Profile Routes
  static const String profile = 'profile';
  static const String editProfile = 'editProfile';
  static const String settings = 'settings';
  static const String moreMenu = 'moreMenu';

  // Clinic Management Routes
  static const String staffManagement = 'staffManagement';
  static const String inviteStaff = 'inviteStaff';
  static const String pendingApprovals = 'pendingApprovals';

  // Dentist Routes
  static const String myClinics = 'myClinics';
  static const String createClinic = 'createClinic';

  // Subscription Routes
  static const String pricing = 'pricing';
  static const String subscription = 'subscription';
  static const String manageSubscription = 'manageSubscription';

  // Other Routes
  static const String notifications = 'notifications';
  static const String medicalHistory = 'medicalHistory';
}
