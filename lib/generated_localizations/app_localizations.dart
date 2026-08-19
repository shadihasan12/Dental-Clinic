import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated_localizations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Dental Clinic'**
  String get appTitle;

  /// No description provided for @addPatient.
  ///
  /// In en, this message translates to:
  /// **'Add Patient'**
  String get addPatient;

  /// No description provided for @scheduleAppointment.
  ///
  /// In en, this message translates to:
  /// **'Schedule Appointment'**
  String get scheduleAppointment;

  /// No description provided for @scheduleVisit.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get scheduleVisit;

  /// No description provided for @recordPayment.
  ///
  /// In en, this message translates to:
  /// **'Record Payment'**
  String get recordPayment;

  /// No description provided for @newCase.
  ///
  /// In en, this message translates to:
  /// **'New Case'**
  String get newCase;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @cases.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get cases;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @medicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Medical History'**
  String get medicalHistory;

  /// No description provided for @allergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergies;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @dentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get dentist;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @cancelledByClinic.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by clinic'**
  String get cancelledByClinic;

  /// No description provided for @cancelledByPatient.
  ///
  /// In en, this message translates to:
  /// **'Cancelled by patient'**
  String get cancelledByPatient;

  /// No description provided for @changeStatus.
  ///
  /// In en, this message translates to:
  /// **'Change status'**
  String get changeStatus;

  /// No description provided for @noShow.
  ///
  /// In en, this message translates to:
  /// **'No show'**
  String get noShow;

  /// No description provided for @appointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Appointment details'**
  String get appointmentDetails;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @viewPatientDetails.
  ///
  /// In en, this message translates to:
  /// **'View patient details'**
  String get viewPatientDetails;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @expenseType.
  ///
  /// In en, this message translates to:
  /// **'Expense type'**
  String get expenseType;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @areYouSureLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureLogout;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2025 Dental Clinic App'**
  String get copyright;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @recentActivities.
  ///
  /// In en, this message translates to:
  /// **'Recent Activities'**
  String get recentActivities;

  /// No description provided for @totalPatients.
  ///
  /// In en, this message translates to:
  /// **'Total Patients'**
  String get totalPatients;

  /// No description provided for @totalAppointments.
  ///
  /// In en, this message translates to:
  /// **'Total Appointments'**
  String get totalAppointments;

  /// No description provided for @totalCases.
  ///
  /// In en, this message translates to:
  /// **'Total Cases'**
  String get totalCases;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @subscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Subscription Status'**
  String get subscriptionStatus;

  /// No description provided for @subscriptionPlan.
  ///
  /// In en, this message translates to:
  /// **'Subscription Plan'**
  String get subscriptionPlan;

  /// No description provided for @renewSubscription.
  ///
  /// In en, this message translates to:
  /// **'Renew Subscription'**
  String get renewSubscription;

  /// No description provided for @upgradeSubscription.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Subscription'**
  String get upgradeSubscription;

  /// No description provided for @subscriptionLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription limit reached'**
  String get subscriptionLimitTitle;

  /// No description provided for @dentistLimitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your current plan doesn\'t allow adding more dentists. Upgrade your subscription to add more clinic users.'**
  String get dentistLimitMessage;

  /// No description provided for @roleLimitInfo.
  ///
  /// In en, this message translates to:
  /// **'Your current plan is at its limit for: {roles}. Upgrade to add users with this role.'**
  String roleLimitInfo(String roles);

  /// No description provided for @daysRemaining.
  ///
  /// In en, this message translates to:
  /// **'Days Remaining'**
  String get daysRemaining;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @clinicInformation.
  ///
  /// In en, this message translates to:
  /// **'Clinic Information'**
  String get clinicInformation;

  /// No description provided for @clinicName.
  ///
  /// In en, this message translates to:
  /// **'Clinic Name'**
  String get clinicName;

  /// No description provided for @workingDays.
  ///
  /// In en, this message translates to:
  /// **'Working Days'**
  String get workingDays;

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

  /// No description provided for @fullClinicHours.
  ///
  /// In en, this message translates to:
  /// **'Full clinic hours'**
  String get fullClinicHours;

  /// No description provided for @manageWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'Manage working hours'**
  String get manageWorkingHours;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @shifts.
  ///
  /// In en, this message translates to:
  /// **'Shifts'**
  String get shifts;

  /// No description provided for @oneShift.
  ///
  /// In en, this message translates to:
  /// **'One shift'**
  String get oneShift;

  /// No description provided for @shiftNumber.
  ///
  /// In en, this message translates to:
  /// **'Shift {number}'**
  String shiftNumber(int number);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @termsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Terms & Privacy'**
  String get termsPrivacy;

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription coming soon'**
  String get manageSubscription;

  /// No description provided for @newAppointment.
  ///
  /// In en, this message translates to:
  /// **'New Appointment'**
  String get newAppointment;

  /// No description provided for @addTreatment.
  ///
  /// In en, this message translates to:
  /// **'Add Treatment'**
  String get addTreatment;

  /// No description provided for @todaysSchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get todaysSchedule;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account to continue'**
  String get signInToContinue;

  /// No description provided for @allFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFilter;

  /// No description provided for @newFilter.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newFilter;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @nextVisit.
  ///
  /// In en, this message translates to:
  /// **'Next visit'**
  String get nextVisit;

  /// No description provided for @outstandingBalance.
  ///
  /// In en, this message translates to:
  /// **'Outstanding balance'**
  String get outstandingBalance;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @medicalInformation.
  ///
  /// In en, this message translates to:
  /// **'Medical Information'**
  String get medicalInformation;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get selectGender;

  /// No description provided for @previousDentalProcedures.
  ///
  /// In en, this message translates to:
  /// **'Previous dental procedures, conditions, etc.'**
  String get previousDentalProcedures;

  /// No description provided for @hasAllergies.
  ///
  /// In en, this message translates to:
  /// **'Has Allergies'**
  String get hasAllergies;

  /// No description provided for @listAnyAllergies.
  ///
  /// In en, this message translates to:
  /// **'List any known allergies'**
  String get listAnyAllergies;

  /// No description provided for @savingPatient.
  ///
  /// In en, this message translates to:
  /// **'Saving Patient...'**
  String get savingPatient;

  /// No description provided for @patientSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Patient Saved Successfully!'**
  String get patientSavedSuccessfully;

  /// No description provided for @addTreatmentQuestion.
  ///
  /// In en, this message translates to:
  /// **'Would you like to add treatment for this patient?'**
  String get addTreatmentQuestion;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @savingTreatment.
  ///
  /// In en, this message translates to:
  /// **'Saving Treatment...'**
  String get savingTreatment;

  /// No description provided for @treatmentSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Treatment saved successfully'**
  String get treatmentSavedSuccessfully;

  /// No description provided for @treatmentType.
  ///
  /// In en, this message translates to:
  /// **'Treatment Type'**
  String get treatmentType;

  /// No description provided for @teeth.
  ///
  /// In en, this message translates to:
  /// **'Teeth'**
  String get teeth;

  /// No description provided for @addNotesAboutTreatment.
  ///
  /// In en, this message translates to:
  /// **'Add any notes about the treatment...'**
  String get addNotesAboutTreatment;

  /// No description provided for @totalCost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get totalCost;

  /// No description provided for @totalCostHint.
  ///
  /// In en, this message translates to:
  /// **'Total cost'**
  String get totalCostHint;

  /// No description provided for @labFees.
  ///
  /// In en, this message translates to:
  /// **'Lab Fees'**
  String get labFees;

  /// No description provided for @labFeesHint.
  ///
  /// In en, this message translates to:
  /// **'Lab fees (if any)'**
  String get labFeesHint;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @addXraysOrPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add X-rays or Photos'**
  String get addXraysOrPhotos;

  /// No description provided for @cleaning.
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get cleaning;

  /// No description provided for @filling.
  ///
  /// In en, this message translates to:
  /// **'Filling'**
  String get filling;

  /// No description provided for @rootCanal.
  ///
  /// In en, this message translates to:
  /// **'Root Canal'**
  String get rootCanal;

  /// No description provided for @extraction.
  ///
  /// In en, this message translates to:
  /// **'Extraction'**
  String get extraction;

  /// No description provided for @crown.
  ///
  /// In en, this message translates to:
  /// **'Crown'**
  String get crown;

  /// No description provided for @implant.
  ///
  /// In en, this message translates to:
  /// **'Implant'**
  String get implant;

  /// No description provided for @whitening.
  ///
  /// In en, this message translates to:
  /// **'Whitening'**
  String get whitening;

  /// No description provided for @veneer.
  ///
  /// In en, this message translates to:
  /// **'Veneer'**
  String get veneer;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noOngoingCase.
  ///
  /// In en, this message translates to:
  /// **'No Ongoing Case'**
  String get noOngoingCase;

  /// No description provided for @patientNoActiveTreatment.
  ///
  /// In en, this message translates to:
  /// **'This patient doesn\'t have any active treatment case at the moment.'**
  String get patientNoActiveTreatment;

  /// No description provided for @createNew.
  ///
  /// In en, this message translates to:
  /// **'Create New'**
  String get createNew;

  /// No description provided for @markAsFinished.
  ///
  /// In en, this message translates to:
  /// **'Mark as Finished'**
  String get markAsFinished;

  /// No description provided for @markCaseFinishedQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to mark this case as finished?'**
  String get markCaseFinishedQuestion;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @visits.
  ///
  /// In en, this message translates to:
  /// **'visits'**
  String get visits;

  /// No description provided for @case_.
  ///
  /// In en, this message translates to:
  /// **'Case'**
  String get case_;

  /// No description provided for @addTreatmentButton.
  ///
  /// In en, this message translates to:
  /// **'Add Treatment'**
  String get addTreatmentButton;

  /// No description provided for @addPaymentButton.
  ///
  /// In en, this message translates to:
  /// **'Add Payment'**
  String get addPaymentButton;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @paidLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidLabel;

  /// No description provided for @pendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingLabel;

  /// No description provided for @viewPaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'View Payment History'**
  String get viewPaymentHistory;

  /// No description provided for @startedLabel.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get startedLabel;

  /// No description provided for @totalVisitsLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Visits'**
  String get totalVisitsLabel;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @noTreatmentsRecorded.
  ///
  /// In en, this message translates to:
  /// **'No treatments recorded'**
  String get noTreatmentsRecorded;

  /// No description provided for @allTreatmentsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All treatments completed!'**
  String get allTreatmentsCompleted;

  /// No description provided for @noCaseHistory.
  ///
  /// In en, this message translates to:
  /// **'No case history'**
  String get noCaseHistory;

  /// No description provided for @completedCasesWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Completed cases will appear here'**
  String get completedCasesWillAppear;

  /// No description provided for @treatments.
  ///
  /// In en, this message translates to:
  /// **'Treatments'**
  String get treatments;

  /// No description provided for @previousTreatments.
  ///
  /// In en, this message translates to:
  /// **'Previous Treatments'**
  String get previousTreatments;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// No description provided for @noPaymentsYet.
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get noPaymentsYet;

  /// No description provided for @recordPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Record Payment'**
  String get recordPaymentTitle;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Patient Name'**
  String get patientName;

  /// No description provided for @alreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Already Paid'**
  String get alreadyPaid;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get remaining;

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (Optional)'**
  String get noteOptional;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add a note...'**
  String get addNote;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount *'**
  String get amountRequired;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get pleaseEnterAmount;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @fullAmount.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get fullAmount;

  /// No description provided for @paymentMethodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentMethodCash;

  /// No description provided for @paymentMethodCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get paymentMethodCreditCard;

  /// No description provided for @paymentMethodDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Debit Card'**
  String get paymentMethodDebitCard;

  /// No description provided for @paymentMethodInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get paymentMethodInsurance;

  /// No description provided for @paymentMethodBankTransfer.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get paymentMethodBankTransfer;

  /// No description provided for @paymentMethodOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get paymentMethodOther;

  /// No description provided for @treatment.
  ///
  /// In en, this message translates to:
  /// **'Treatment'**
  String get treatment;

  /// No description provided for @treatmentNumber.
  ///
  /// In en, this message translates to:
  /// **'Treatment #{number}'**
  String treatmentNumber(Object number);

  /// No description provided for @treatmentTypes.
  ///
  /// In en, this message translates to:
  /// **'Treatment Types'**
  String get treatmentTypes;

  /// No description provided for @treatedTeeth.
  ///
  /// In en, this message translates to:
  /// **'Treated Teeth'**
  String get treatedTeeth;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @noExpensesThisMonth.
  ///
  /// In en, this message translates to:
  /// **'No expenses this month'**
  String get noExpensesThisMonth;

  /// No description provided for @addOne.
  ///
  /// In en, this message translates to:
  /// **'Add one'**
  String get addOne;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'transactions'**
  String get transactions;

  /// No description provided for @whatWasThisFor.
  ///
  /// In en, this message translates to:
  /// **'What was this for?'**
  String get whatWasThisFor;

  /// No description provided for @addNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Add a note (optional)'**
  String get addNoteOptional;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @saveExpense.
  ///
  /// In en, this message translates to:
  /// **'Save Expense'**
  String get saveExpense;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @deleteExpenseButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get deleteExpenseButton;

  /// No description provided for @deleteExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get deleteExpenseTitle;

  /// No description provided for @deleteExpenseConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this expense?'**
  String get deleteExpenseConfirmation;

  /// No description provided for @expenseCategorySupplies.
  ///
  /// In en, this message translates to:
  /// **'Supplies'**
  String get expenseCategorySupplies;

  /// No description provided for @expenseCategoryLab.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get expenseCategoryLab;

  /// No description provided for @expenseCategoryEquipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get expenseCategoryEquipment;

  /// No description provided for @expenseCategoryRent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get expenseCategoryRent;

  /// No description provided for @expenseCategorySalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get expenseCategorySalary;

  /// No description provided for @expenseCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get expenseCategoryOther;

  /// No description provided for @myClinics.
  ///
  /// In en, this message translates to:
  /// **'My Clinics'**
  String get myClinics;

  /// No description provided for @useThisClinic.
  ///
  /// In en, this message translates to:
  /// **'Use this clinic'**
  String get useThisClinic;

  /// No description provided for @currentlyActive.
  ///
  /// In en, this message translates to:
  /// **'Currently active'**
  String get currentlyActive;

  /// No description provided for @clinicSelectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Now working on {name}'**
  String clinicSelectedMessage(String name);

  /// No description provided for @leaveClinic.
  ///
  /// In en, this message translates to:
  /// **'Leave Clinic'**
  String get leaveClinic;

  /// No description provided for @leaveClinicConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave {clinicName}? You will need to be re-invited to rejoin.'**
  String leaveClinicConfirmation(Object clinicName);

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined {date}'**
  String joined(Object date);

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @roleDentist.
  ///
  /// In en, this message translates to:
  /// **'Dentist'**
  String get roleDentist;

  /// No description provided for @roleReceptionist.
  ///
  /// In en, this message translates to:
  /// **'Receptionist'**
  String get roleReceptionist;

  /// No description provided for @invitationAccepted.
  ///
  /// In en, this message translates to:
  /// **'Invitation Accepted'**
  String get invitationAccepted;

  /// No description provided for @invitationAcceptedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have joined the clinic'**
  String get invitationAcceptedMessage;

  /// No description provided for @invitationDeclined.
  ///
  /// In en, this message translates to:
  /// **'Invitation Declined'**
  String get invitationDeclined;

  /// No description provided for @invitationDeclinedMessage.
  ///
  /// In en, this message translates to:
  /// **'The invitation has been declined'**
  String get invitationDeclinedMessage;

  /// No description provided for @invitations.
  ///
  /// In en, this message translates to:
  /// **'Invitations'**
  String get invitations;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @sendInvite.
  ///
  /// In en, this message translates to:
  /// **'Send invite'**
  String get sendInvite;

  /// No description provided for @sendInviteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Invite a colleague to join this clinic.'**
  String get sendInviteSubtitle;

  /// No description provided for @inviteSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Invitation sent'**
  String get inviteSentSuccess;

  /// No description provided for @invitedBy.
  ///
  /// In en, this message translates to:
  /// **'by {name}'**
  String invitedBy(String name);

  /// No description provided for @noInvitations.
  ///
  /// In en, this message translates to:
  /// **'No invitations'**
  String get noInvitations;

  /// No description provided for @noPendingInvitations.
  ///
  /// In en, this message translates to:
  /// **'No pending invitations'**
  String get noPendingInvitations;

  /// No description provided for @noAcceptedInvitations.
  ///
  /// In en, this message translates to:
  /// **'No accepted invitations'**
  String get noAcceptedInvitations;

  /// No description provided for @noDeclinedInvitations.
  ///
  /// In en, this message translates to:
  /// **'No declined invitations'**
  String get noDeclinedInvitations;

  /// No description provided for @noPendingSentInvitations.
  ///
  /// In en, this message translates to:
  /// **'No pending invitations sent'**
  String get noPendingSentInvitations;

  /// No description provided for @noAcceptedSentInvitations.
  ///
  /// In en, this message translates to:
  /// **'No accepted invitations sent'**
  String get noAcceptedSentInvitations;

  /// No description provided for @noDeclinedSentInvitations.
  ///
  /// In en, this message translates to:
  /// **'No declined invitations sent'**
  String get noDeclinedSentInvitations;

  /// No description provided for @appLanguageWillChangeImmediately.
  ///
  /// In en, this message translates to:
  /// **'The app language will change immediately'**
  String get appLanguageWillChangeImmediately;

  /// No description provided for @pleaseSelectAPatient.
  ///
  /// In en, this message translates to:
  /// **'Please select a patient'**
  String get pleaseSelectAPatient;

  /// No description provided for @pleaseSelectADoctor.
  ///
  /// In en, this message translates to:
  /// **'Please select a doctor'**
  String get pleaseSelectADoctor;

  /// No description provided for @selectDoctor.
  ///
  /// In en, this message translates to:
  /// **'Select doctor'**
  String get selectDoctor;

  /// No description provided for @selectDoctorFirst.
  ///
  /// In en, this message translates to:
  /// **'Select a doctor to see available slots'**
  String get selectDoctorFirst;

  /// No description provided for @vipAppointment.
  ///
  /// In en, this message translates to:
  /// **'VIP appointment'**
  String get vipAppointment;

  /// No description provided for @vipAppointmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bypass the doctor\'s schedule and show every slot'**
  String get vipAppointmentSubtitle;

  /// No description provided for @missingData.
  ///
  /// In en, this message translates to:
  /// **'Missing Data'**
  String get missingData;

  /// No description provided for @pleaseSelectAtLeastOneTreatment.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one treatment'**
  String get pleaseSelectAtLeastOneTreatment;

  /// No description provided for @pleaseSelectAnAvailableTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Please select an available time slot'**
  String get pleaseSelectAnAvailableTimeSlot;

  /// No description provided for @appointmentScheduled.
  ///
  /// In en, this message translates to:
  /// **'Appointment Scheduled'**
  String get appointmentScheduled;

  /// No description provided for @successfullyAddedToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Successfully added to calendar'**
  String get successfullyAddedToCalendar;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @availableSlots.
  ///
  /// In en, this message translates to:
  /// **'Available Slots'**
  String get availableSlots;

  /// No description provided for @addNewPatient.
  ///
  /// In en, this message translates to:
  /// **'Add new patient'**
  String get addNewPatient;

  /// No description provided for @searchPatientName.
  ///
  /// In en, this message translates to:
  /// **'Search patient name'**
  String get searchPatientName;

  /// No description provided for @noPatientsFound.
  ///
  /// In en, this message translates to:
  /// **'No patients found'**
  String get noPatientsFound;

  /// No description provided for @noAvailableSlotsForThisDate.
  ///
  /// In en, this message translates to:
  /// **'No available slots for this date'**
  String get noAvailableSlotsForThisDate;

  /// No description provided for @noWorkingHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your working hours'**
  String get noWorkingHoursTitle;

  /// No description provided for @noWorkingHoursMessage.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added your working hours yet, so we can\'t show available slots. Add them once and you\'ll be able to schedule appointments right away.'**
  String get noWorkingHoursMessage;

  /// No description provided for @setWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'Set working hours'**
  String get setWorkingHours;

  /// No description provided for @notWorkingOnThisDayTitle.
  ///
  /// In en, this message translates to:
  /// **'You don\'t work on this day'**
  String get notWorkingOnThisDayTitle;

  /// No description provided for @notWorkingOnThisDayMessage.
  ///
  /// In en, this message translates to:
  /// **'Your working hours don\'t cover this day. Pick another date or update your hours to add it.'**
  String get notWorkingOnThisDayMessage;

  /// No description provided for @updateWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'Update working hours'**
  String get updateWorkingHours;

  /// No description provided for @clinicWorkingDaysMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up clinic working days first'**
  String get clinicWorkingDaysMissingTitle;

  /// No description provided for @clinicWorkingDaysMissingAdminMessage.
  ///
  /// In en, this message translates to:
  /// **'Your clinic doesn\'t have working days yet. Add them once and you\'ll be able to set your own hours on top of them.'**
  String get clinicWorkingDaysMissingAdminMessage;

  /// No description provided for @clinicWorkingDaysMissingNonAdminMessage.
  ///
  /// In en, this message translates to:
  /// **'Your clinic\'s admin hasn\'t set up working days yet. Ask them to add them before you can save your hours.'**
  String get clinicWorkingDaysMissingNonAdminMessage;

  /// No description provided for @setClinicWorkingDays.
  ///
  /// In en, this message translates to:
  /// **'Set clinic working days'**
  String get setClinicWorkingDays;

  /// No description provided for @sendReminderToPatient.
  ///
  /// In en, this message translates to:
  /// **'Send reminder to patient'**
  String get sendReminderToPatient;

  /// No description provided for @addNotesForAppointment.
  ///
  /// In en, this message translates to:
  /// **'Any special notes or instructions...'**
  String get addNotesForAppointment;

  /// No description provided for @checkup.
  ///
  /// In en, this message translates to:
  /// **'Checkup'**
  String get checkup;

  /// No description provided for @consultation.
  ///
  /// In en, this message translates to:
  /// **'Consultation'**
  String get consultation;

  /// No description provided for @xray.
  ///
  /// In en, this message translates to:
  /// **'X-Ray'**
  String get xray;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No Appointments'**
  String get noAppointments;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get specialization;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @generalDentistry.
  ///
  /// In en, this message translates to:
  /// **'General Dentistry'**
  String get generalDentistry;

  /// No description provided for @endodontics.
  ///
  /// In en, this message translates to:
  /// **'Endodontics'**
  String get endodontics;

  /// No description provided for @orthodontics.
  ///
  /// In en, this message translates to:
  /// **'Orthodontics'**
  String get orthodontics;

  /// No description provided for @cosmeticDentistry.
  ///
  /// In en, this message translates to:
  /// **'Cosmetic Dentistry'**
  String get cosmeticDentistry;

  /// No description provided for @oralSurgery.
  ///
  /// In en, this message translates to:
  /// **'Oral Surgery'**
  String get oralSurgery;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @caseCurrency.
  ///
  /// In en, this message translates to:
  /// **'Case Currency'**
  String get caseCurrency;

  /// No description provided for @exchangeRate.
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeRate;

  /// No description provided for @holidays.
  ///
  /// In en, this message translates to:
  /// **'Holidays & Days Off'**
  String get holidays;

  /// No description provided for @addHoliday.
  ///
  /// In en, this message translates to:
  /// **'Add Holiday'**
  String get addHoliday;

  /// No description provided for @editHoliday.
  ///
  /// In en, this message translates to:
  /// **'Edit Holiday'**
  String get editHoliday;

  /// No description provided for @holidayName.
  ///
  /// In en, this message translates to:
  /// **'Holiday Name'**
  String get holidayName;

  /// No description provided for @holidayNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Eid Al-Fitr'**
  String get holidayNameHint;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @recurringDescription.
  ///
  /// In en, this message translates to:
  /// **'Repeats every year'**
  String get recurringDescription;

  /// No description provided for @noHolidays.
  ///
  /// In en, this message translates to:
  /// **'No holidays added yet'**
  String get noHolidays;

  /// No description provided for @supportResponseTime.
  ///
  /// In en, this message translates to:
  /// **'We typically respond within 24 hours'**
  String get supportResponseTime;

  /// No description provided for @newConversation.
  ///
  /// In en, this message translates to:
  /// **'New Conversation'**
  String get newConversation;

  /// No description provided for @previousConversations.
  ///
  /// In en, this message translates to:
  /// **'Previous Conversations'**
  String get previousConversations;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeAMessage;

  /// No description provided for @noConversations.
  ///
  /// In en, this message translates to:
  /// **'No previous conversations'**
  String get noConversations;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @supportTeam.
  ///
  /// In en, this message translates to:
  /// **'Support Team'**
  String get supportTeam;

  /// No description provided for @startConversationDesc.
  ///
  /// In en, this message translates to:
  /// **'Our support team is here to help you with any questions or issues.'**
  String get startConversationDesc;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @updates.
  ///
  /// In en, this message translates to:
  /// **'Updates'**
  String get updates;

  /// No description provided for @communication.
  ///
  /// In en, this message translates to:
  /// **'Communication'**
  String get communication;

  /// No description provided for @appointmentReminders.
  ///
  /// In en, this message translates to:
  /// **'Appointment Reminders'**
  String get appointmentReminders;

  /// No description provided for @appointmentRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified before upcoming appointments'**
  String get appointmentRemindersDesc;

  /// No description provided for @paymentReminders.
  ///
  /// In en, this message translates to:
  /// **'Payment Reminders'**
  String get paymentReminders;

  /// No description provided for @paymentRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Alerts when patient invoices are due'**
  String get paymentRemindersDesc;

  /// No description provided for @patientFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Patient Follow-up'**
  String get patientFollowUp;

  /// No description provided for @patientFollowUpDesc.
  ///
  /// In en, this message translates to:
  /// **'Reminders to follow up with patients after treatment'**
  String get patientFollowUpDesc;

  /// No description provided for @newsAndUpdates.
  ///
  /// In en, this message translates to:
  /// **'News & Updates'**
  String get newsAndUpdates;

  /// No description provided for @newsAndUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Clinic tips, dental news and useful content'**
  String get newsAndUpdatesDesc;

  /// No description provided for @newFeatures.
  ///
  /// In en, this message translates to:
  /// **'New Features'**
  String get newFeatures;

  /// No description provided for @newFeaturesDesc.
  ///
  /// In en, this message translates to:
  /// **'Discover new app features and improvements'**
  String get newFeaturesDesc;

  /// No description provided for @promotionalOffers.
  ///
  /// In en, this message translates to:
  /// **'Promotional Offers'**
  String get promotionalOffers;

  /// No description provided for @promotionalOffersDesc.
  ///
  /// In en, this message translates to:
  /// **'Special deals and subscription updates'**
  String get promotionalOffersDesc;

  /// No description provided for @smsNotifications.
  ///
  /// In en, this message translates to:
  /// **'SMS Notifications'**
  String get smsNotifications;

  /// No description provided for @smsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Receive alerts via text message'**
  String get smsNotificationsDesc;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @emailNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Get important updates sent to your email'**
  String get emailNotificationsDesc;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'In-app and device push notifications'**
  String get pushNotificationsDesc;

  /// No description provided for @statisticsUpdates.
  ///
  /// In en, this message translates to:
  /// **'Statistics Updates'**
  String get statisticsUpdates;

  /// No description provided for @statisticsUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'Weekly summaries and performance insights about your clinic'**
  String get statisticsUpdatesDesc;

  /// No description provided for @savingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Saving appointment ...'**
  String get savingAppointment;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @noNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up! New notifications will appear here.'**
  String get noNotificationsDesc;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String daysAgo(int count);

  /// No description provided for @notificationsSettings.
  ///
  /// In en, this message translates to:
  /// **'Notifications Settings'**
  String get notificationsSettings;

  /// No description provided for @freeTrial.
  ///
  /// In en, this message translates to:
  /// **'Free Trial'**
  String get freeTrial;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} days left'**
  String daysLeft(int count);

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @storageUsed.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storageUsed;

  /// No description provided for @storageValue.
  ///
  /// In en, this message translates to:
  /// **'{used} / {total} GB'**
  String storageValue(String used, String total);

  /// No description provided for @viewAllPlans.
  ///
  /// In en, this message translates to:
  /// **'View All Plans'**
  String get viewAllPlans;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @renewsOn.
  ///
  /// In en, this message translates to:
  /// **'Renews {date}'**
  String renewsOn(String date);

  /// No description provided for @trialEndsIn.
  ///
  /// In en, this message translates to:
  /// **'Your trial ends in {count} days'**
  String trialEndsIn(int count);

  /// No description provided for @noSubscription.
  ///
  /// In en, this message translates to:
  /// **'No Active Plan'**
  String get noSubscription;

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get startFreeTrial;

  /// No description provided for @tryAllFeatures.
  ///
  /// In en, this message translates to:
  /// **'Try all features free for 30 days'**
  String get tryAllFeatures;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Manage Patients\nEffortlessly'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Streamline patient management with automated case creation and comprehensive patient profiles'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Smart Scheduling'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Easily manage appointments with intuitive calendar views and automated reminders'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Track & Grow\nYour Practice'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Monitor clinic performance with comprehensive analytics and financial insights'**
  String get onboardingDesc3;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone Number'**
  String get emailOrPhone;

  /// No description provided for @emailOrPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'doctor@example.com or 0935315978'**
  String get emailOrPhoneHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'********'**
  String get passwordHint;

  /// No description provided for @forgotPasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordQuestion;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @copyrightSmylos.
  ///
  /// In en, this message translates to:
  /// **'© 2026 SmylOS Pro. All rights reserved.'**
  String get copyrightSmylos;

  /// No description provided for @pleaseEnterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or phone number'**
  String get pleaseEnterEmailOrPhone;

  /// No description provided for @pleaseEnterValidEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email or phone number'**
  String get pleaseEnterValidEmailOrPhone;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get loginFailed;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SmylOS Pro'**
  String get appName;

  /// No description provided for @professionalClinicManagement.
  ///
  /// In en, this message translates to:
  /// **'Professional Clinic Management'**
  String get professionalClinicManagement;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @joinDentalCommunity.
  ///
  /// In en, this message translates to:
  /// **'Join our dental community'**
  String get joinDentalCommunity;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First Name *'**
  String get firstNameRequired;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'John'**
  String get firstNameHint;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last Name *'**
  String get lastNameRequired;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Smith'**
  String get lastNameHint;

  /// No description provided for @pleaseEnterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get pleaseEnterFirstName;

  /// No description provided for @pleaseEnterLastName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get pleaseEnterLastName;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email *'**
  String get emailRequired;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'doctor@example.com'**
  String get emailHint;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number *'**
  String get mobileNumber;

  /// No description provided for @mobileHint.
  ///
  /// In en, this message translates to:
  /// **'091234567'**
  String get mobileHint;

  /// No description provided for @selectYourSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Select your specialization'**
  String get selectYourSpecialization;

  /// No description provided for @specializationRequired.
  ///
  /// In en, this message translates to:
  /// **'Specialization *'**
  String get specializationRequired;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get createPassword;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password *'**
  String get passwordRequired;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password *'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @mobileRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is required'**
  String get mobileRequired;

  /// No description provided for @mobileTooShort.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is too short'**
  String get mobileTooShort;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationError;

  /// No description provided for @pleaseSelectSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Please select a specialization'**
  String get pleaseSelectSpecialization;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup Failed'**
  String get signupFailed;

  /// No description provided for @failedToLoadData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load required data'**
  String get failedToLoadData;

  /// No description provided for @checkConnectionRetry.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again'**
  String get checkConnectionRetry;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @signupInfoBox.
  ///
  /// In en, this message translates to:
  /// **'Create your account, then set up or join a clinic from your dashboard.'**
  String get signupInfoBox;

  /// No description provided for @enterEmailToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to get started'**
  String get enterEmailToGetStarted;

  /// No description provided for @verificationCodeInfo.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a verification code to confirm your email address.'**
  String get verificationCodeInfo;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @sendVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendVerificationCode;

  /// No description provided for @emailRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Required'**
  String get emailRequiredTitle;

  /// No description provided for @pleaseEnterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get pleaseEnterEmailAddress;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'OTP Sent'**
  String get otpSent;

  /// No description provided for @verificationCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to {email}'**
  String verificationCodeSentTo(String email);

  /// No description provided for @verifyYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Account'**
  String get verifyYourAccount;

  /// No description provided for @verifyAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a verification code to your email'**
  String get verifyAccountSubtitle;

  /// No description provided for @verifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyYourEmail;

  /// No description provided for @enterCodeSentToEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to your email'**
  String get enterCodeSentToEmail;

  /// No description provided for @sentVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit verification code'**
  String get sentVerificationCode;

  /// No description provided for @sendingCode.
  ///
  /// In en, this message translates to:
  /// **'Sending code...'**
  String get sendingCode;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds}s'**
  String resendCodeIn(int seconds);

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @verifyAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get verifyAndContinue;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid Code'**
  String get invalidCode;

  /// No description provided for @pleaseEnterAllDigits.
  ///
  /// In en, this message translates to:
  /// **'Please enter all 6 digits'**
  String get pleaseEnterAllDigits;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get emailVerified;

  /// No description provided for @completeYourRegistration.
  ///
  /// In en, this message translates to:
  /// **'Please complete your registration'**
  String get completeYourRegistration;

  /// No description provided for @verificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification Failed'**
  String get verificationFailed;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we\'ll send you a reset link'**
  String get forgotPasswordSubtitle;

  /// No description provided for @enterRegisteredEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email'**
  String get enterRegisteredEmail;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Sent!'**
  String get emailSent;

  /// No description provided for @resetLinkSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We have sent a password reset link to your email address. Please check your inbox and follow the instructions.'**
  String get resetLinkSentMessage;

  /// No description provided for @didntReceiveEmail.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the email? '**
  String get didntReceiveEmail;

  /// No description provided for @chooseYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get chooseYourPlan;

  /// No description provided for @selectPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the perfect plan for your clinic'**
  String get selectPlanSubtitle;

  /// No description provided for @noPlansAvailable.
  ///
  /// In en, this message translates to:
  /// **'No plans available'**
  String get noPlansAvailable;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @yearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearly;

  /// No description provided for @savePercent.
  ///
  /// In en, this message translates to:
  /// **'Save 17%'**
  String get savePercent;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get perMonth;

  /// No description provided for @perYear.
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get perYear;

  /// No description provided for @dayFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'{days}-day free trial'**
  String dayFreeTrial(int days);

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'MOST POPULAR'**
  String get mostPopular;

  /// No description provided for @unlimitedPatients.
  ///
  /// In en, this message translates to:
  /// **'Unlimited patients'**
  String get unlimitedPatients;

  /// No description provided for @oneDoctorOneAssistant.
  ///
  /// In en, this message translates to:
  /// **'1 doctor and 1 assistant'**
  String get oneDoctorOneAssistant;

  /// No description provided for @storageAmount.
  ///
  /// In en, this message translates to:
  /// **'{amount} GB storage'**
  String storageAmount(String amount);

  /// No description provided for @allFeaturesIncluded.
  ///
  /// In en, this message translates to:
  /// **'All features included'**
  String get allFeaturesIncluded;

  /// No description provided for @support247.
  ///
  /// In en, this message translates to:
  /// **'24/7 support'**
  String get support247;

  /// No description provided for @upToDoctors.
  ///
  /// In en, this message translates to:
  /// **'Up to {count} doctors'**
  String upToDoctors(int count);

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get prioritySupport;

  /// No description provided for @unlimitedDoctorsAssistants.
  ///
  /// In en, this message translates to:
  /// **'Unlimited doctors & assistants'**
  String get unlimitedDoctorsAssistants;

  /// No description provided for @storagePerAccount.
  ///
  /// In en, this message translates to:
  /// **'{amount} GB storage per account'**
  String storagePerAccount(String amount);

  /// No description provided for @advancedAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Advanced analytics'**
  String get advancedAnalytics;

  /// No description provided for @adminRoleIncluded.
  ///
  /// In en, this message translates to:
  /// **'Admin role included'**
  String get adminRoleIncluded;

  /// No description provided for @fullPatientManagement.
  ///
  /// In en, this message translates to:
  /// **'Full patient management'**
  String get fullPatientManagement;

  /// No description provided for @appointmentScheduling.
  ///
  /// In en, this message translates to:
  /// **'Appointment scheduling'**
  String get appointmentScheduling;

  /// No description provided for @treatmentTracking.
  ///
  /// In en, this message translates to:
  /// **'Treatment tracking'**
  String get treatmentTracking;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @setupClinicDetails.
  ///
  /// In en, this message translates to:
  /// **'Set up your clinic details'**
  String get setupClinicDetails;

  /// No description provided for @clinicDetailsInfo.
  ///
  /// In en, this message translates to:
  /// **'Enter your clinic details to complete registration. You can update these later in settings.'**
  String get clinicDetailsInfo;

  /// No description provided for @clinicNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Clinic Name *'**
  String get clinicNameRequired;

  /// No description provided for @clinicNameHintExample.
  ///
  /// In en, this message translates to:
  /// **'e.g., Bright Smile Dental Clinic'**
  String get clinicNameHintExample;

  /// No description provided for @locationRequired.
  ///
  /// In en, this message translates to:
  /// **'Location *'**
  String get locationRequired;

  /// No description provided for @searchForLocation.
  ///
  /// In en, this message translates to:
  /// **'Search for location...'**
  String get searchForLocation;

  /// No description provided for @noLocationsFound.
  ///
  /// In en, this message translates to:
  /// **'No locations found. Try a different search term.'**
  String get noLocationsFound;

  /// No description provided for @detailedAddress.
  ///
  /// In en, this message translates to:
  /// **'Detailed Address'**
  String get detailedAddress;

  /// No description provided for @detailedAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Street, building number, etc.'**
  String get detailedAddressHint;

  /// No description provided for @completeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get completeRegistration;

  /// No description provided for @pleaseEnterClinicName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your clinic name'**
  String get pleaseEnterClinicName;

  /// No description provided for @clinicNameMinChars.
  ///
  /// In en, this message translates to:
  /// **'Clinic name must be at least 3 characters'**
  String get clinicNameMinChars;

  /// No description provided for @clinicNameMaxChars.
  ///
  /// In en, this message translates to:
  /// **'Clinic name must be less than 100 characters'**
  String get clinicNameMaxChars;

  /// No description provided for @pleaseSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Please select a location'**
  String get pleaseSelectLocation;

  /// No description provided for @pleaseSelectPlan.
  ///
  /// In en, this message translates to:
  /// **'Please select a subscription plan'**
  String get pleaseSelectPlan;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session Expired'**
  String get sessionExpired;

  /// No description provided for @pleaseVerifyEmailAgain.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email again'**
  String get pleaseVerifyEmailAgain;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully'**
  String get accountCreatedSuccessfully;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration Failed'**
  String get registrationFailed;

  /// No description provided for @rememberPassword.
  ///
  /// In en, this message translates to:
  /// **'Remember your password? '**
  String get rememberPassword;

  /// No description provided for @setNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Set New Password'**
  String get setNewPassword;

  /// No description provided for @enterNewPasswordBelow.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password below'**
  String get enterNewPasswordBelow;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Successfully'**
  String get passwordResetSuccess;

  /// No description provided for @passwordResetSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'You can now sign in with your new password'**
  String get passwordResetSuccessMessage;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @caseTitleOptional.
  ///
  /// In en, this message translates to:
  /// **'Case Title (Optional)'**
  String get caseTitleOptional;

  /// No description provided for @caseTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a title for the completed case'**
  String get caseTitleHint;

  /// No description provided for @caseMarkedAsFinished.
  ///
  /// In en, this message translates to:
  /// **'Case marked as finished'**
  String get caseMarkedAsFinished;

  /// No description provided for @paymentAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Payment added successfully'**
  String get paymentAddedSuccessfully;

  /// No description provided for @noPatientsYet.
  ///
  /// In en, this message translates to:
  /// **'No patients yet'**
  String get noPatientsYet;

  /// No description provided for @noPatientsYetDesc.
  ///
  /// In en, this message translates to:
  /// **'Add your first patient to get started'**
  String get noPatientsYetDesc;

  /// No description provided for @noMatchingPatients.
  ///
  /// In en, this message translates to:
  /// **'No matching patients'**
  String get noMatchingPatients;

  /// No description provided for @noMatchingPatientsDesc.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filters'**
  String get noMatchingPatientsDesc;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @nameTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameTooShort;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @pleaseSelectSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Please select your specialization'**
  String get pleaseSelectSpecialty;

  /// No description provided for @workingDaysAndHolidays.
  ///
  /// In en, this message translates to:
  /// **'Working Days & Holidays'**
  String get workingDaysAndHolidays;

  /// No description provided for @myWorkingHours.
  ///
  /// In en, this message translates to:
  /// **'My Working Hours'**
  String get myWorkingHours;

  /// No description provided for @photoPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Photo Permission Required'**
  String get photoPermissionRequired;

  /// No description provided for @photoPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'This app needs access to your photos to set your profile picture. Please grant permission in Settings.'**
  String get photoPermissionMessage;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change Email'**
  String get changeEmail;

  /// No description provided for @newEmail.
  ///
  /// In en, this message translates to:
  /// **'New Email'**
  String get newEmail;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @changeEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your new email and current password to verify your identity.'**
  String get changeEmailDescription;

  /// No description provided for @verifyNewEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify New Email'**
  String get verifyNewEmail;

  /// No description provided for @changeEmailOtpDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your new email address.'**
  String get changeEmailOtpDescription;

  /// No description provided for @confirmChangeEmail.
  ///
  /// In en, this message translates to:
  /// **'Confirm Change'**
  String get confirmChangeEmail;

  /// No description provided for @emailChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Email changed successfully! Please login with your new email.'**
  String get emailChangedSuccess;

  /// No description provided for @pleaseEnterNewEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new email'**
  String get pleaseEnterNewEmail;

  /// No description provided for @pleaseEnterCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your current password'**
  String get pleaseEnterCurrentPassword;

  /// No description provided for @editCosts.
  ///
  /// In en, this message translates to:
  /// **'Edit Costs'**
  String get editCosts;

  /// No description provided for @enterTotalCost.
  ///
  /// In en, this message translates to:
  /// **'Enter total cost'**
  String get enterTotalCost;

  /// No description provided for @enterLabFees.
  ///
  /// In en, this message translates to:
  /// **'Enter lab fees'**
  String get enterLabFees;

  /// No description provided for @completedCase.
  ///
  /// In en, this message translates to:
  /// **'Completed Case'**
  String get completedCase;

  /// No description provided for @caseTitlePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Case title...'**
  String get caseTitlePlaceholder;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get started;

  /// No description provided for @reopenCase.
  ///
  /// In en, this message translates to:
  /// **'Reopen Case'**
  String get reopenCase;

  /// No description provided for @tooth.
  ///
  /// In en, this message translates to:
  /// **'Tooth'**
  String get tooth;

  /// No description provided for @generalTreatment.
  ///
  /// In en, this message translates to:
  /// **'General Treatment'**
  String get generalTreatment;

  /// No description provided for @visitNotes.
  ///
  /// In en, this message translates to:
  /// **'Visit Notes'**
  String get visitNotes;

  /// No description provided for @manageNotes.
  ///
  /// In en, this message translates to:
  /// **'Manage Notes'**
  String get manageNotes;

  /// No description provided for @undoFinished.
  ///
  /// In en, this message translates to:
  /// **'Undo Finished'**
  String get undoFinished;

  /// No description provided for @markFinished.
  ///
  /// In en, this message translates to:
  /// **'Mark Finished'**
  String get markFinished;

  /// No description provided for @addANote.
  ///
  /// In en, this message translates to:
  /// **'Add a note...'**
  String get addANote;

  /// No description provided for @planned.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get planned;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @noNotesYet.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get noNotesYet;

  /// No description provided for @deleteTreatment.
  ///
  /// In en, this message translates to:
  /// **'Delete Treatment'**
  String get deleteTreatment;

  /// No description provided for @confirmDeleteTreatment.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this treatment?'**
  String get confirmDeleteTreatment;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit note...'**
  String get editNote;

  /// No description provided for @writeANote.
  ///
  /// In en, this message translates to:
  /// **'Write a note...'**
  String get writeANote;

  /// No description provided for @costsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Costs updated'**
  String get costsUpdated;

  /// No description provided for @titleUpdated.
  ///
  /// In en, this message translates to:
  /// **'Title updated'**
  String get titleUpdated;

  /// No description provided for @caseReopened.
  ///
  /// In en, this message translates to:
  /// **'Case reopened'**
  String get caseReopened;

  /// No description provided for @treatmentRemoved.
  ///
  /// In en, this message translates to:
  /// **'Treatment removed'**
  String get treatmentRemoved;

  /// No description provided for @notesUpdated.
  ///
  /// In en, this message translates to:
  /// **'Notes updated'**
  String get notesUpdated;

  /// No description provided for @treatmentAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Treatment added successfully'**
  String get treatmentAddedSuccessfully;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @planTreatments.
  ///
  /// In en, this message translates to:
  /// **'Plan Treatments'**
  String get planTreatments;

  /// No description provided for @tapToothToAddTreatments.
  ///
  /// In en, this message translates to:
  /// **'Tap a tooth to add treatments'**
  String get tapToothToAddTreatments;

  /// No description provided for @addedTreatments.
  ///
  /// In en, this message translates to:
  /// **'Added Treatments'**
  String get addedTreatments;

  /// No description provided for @nTreatments.
  ///
  /// In en, this message translates to:
  /// **'{count} treatments'**
  String nTreatments(int count);

  /// No description provided for @addToPlan.
  ///
  /// In en, this message translates to:
  /// **'Add to Plan'**
  String get addToPlan;

  /// No description provided for @hasPlannedTreatment.
  ///
  /// In en, this message translates to:
  /// **'Has planned treatment'**
  String get hasPlannedTreatment;

  /// No description provided for @treatmentPlan.
  ///
  /// In en, this message translates to:
  /// **'Treatment Plan'**
  String get treatmentPlan;

  /// No description provided for @newTreatmentPlan.
  ///
  /// In en, this message translates to:
  /// **'New Treatment Plan'**
  String get newTreatmentPlan;

  /// No description provided for @setCost.
  ///
  /// In en, this message translates to:
  /// **'Set Cost'**
  String get setCost;

  /// No description provided for @savingTreatmentPlan.
  ///
  /// In en, this message translates to:
  /// **'Saving treatment plan...'**
  String get savingTreatmentPlan;

  /// No description provided for @treatmentPlanSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Treatment plan saved successfully'**
  String get treatmentPlanSavedSuccessfully;

  /// No description provided for @noTreatmentsYetAddOne.
  ///
  /// In en, this message translates to:
  /// **'No treatments yet — add one!'**
  String get noTreatmentsYetAddOne;

  /// No description provided for @toothLabel.
  ///
  /// In en, this message translates to:
  /// **'Tooth {number}'**
  String toothLabel(String number);

  /// No description provided for @selectTreatments.
  ///
  /// In en, this message translates to:
  /// **'Select Treatments'**
  String get selectTreatments;

  /// No description provided for @selectATreatment.
  ///
  /// In en, this message translates to:
  /// **'Select a treatment'**
  String get selectATreatment;

  /// No description provided for @addNTreatments.
  ///
  /// In en, this message translates to:
  /// **'Add {count} Treatments'**
  String addNTreatments(int count);

  /// No description provided for @alreadyPlannedForTooth.
  ///
  /// In en, this message translates to:
  /// **'{count} treatment(s) already planned for this tooth'**
  String alreadyPlannedForTooth(int count);

  /// No description provided for @pleaseSelectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Please select a currency'**
  String get pleaseSelectCurrency;

  /// No description provided for @clinicUsers.
  ///
  /// In en, this message translates to:
  /// **'Clinic Users'**
  String get clinicUsers;

  /// No description provided for @addUser.
  ///
  /// In en, this message translates to:
  /// **'Add User'**
  String get addUser;

  /// No description provided for @removeUser.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeUser;

  /// No description provided for @updateRoles.
  ///
  /// In en, this message translates to:
  /// **'Update Roles'**
  String get updateRoles;

  /// No description provided for @userAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'User added successfully'**
  String get userAddedSuccess;

  /// No description provided for @userRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'User removed successfully'**
  String get userRemovedSuccess;

  /// No description provided for @rolesUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Roles updated successfully'**
  String get rolesUpdatedSuccess;

  /// No description provided for @removeUserConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {name} from the clinic?'**
  String removeUserConfirmation(String name);

  /// No description provided for @selectRoles.
  ///
  /// In en, this message translates to:
  /// **'Select Roles'**
  String get selectRoles;

  /// No description provided for @roleSecretary.
  ///
  /// In en, this message translates to:
  /// **'Secretary'**
  String get roleSecretary;

  /// No description provided for @noUsersYet.
  ///
  /// In en, this message translates to:
  /// **'No users yet'**
  String get noUsersYet;

  /// No description provided for @manageRoles.
  ///
  /// In en, this message translates to:
  /// **'Manage Roles'**
  String get manageRoles;

  /// No description provided for @selectSpecialization.
  ///
  /// In en, this message translates to:
  /// **'Select specialization'**
  String get selectSpecialization;

  /// No description provided for @patientInfo.
  ///
  /// In en, this message translates to:
  /// **'Patient Info'**
  String get patientInfo;

  /// No description provided for @caseInfo.
  ///
  /// In en, this message translates to:
  /// **'Case Info'**
  String get caseInfo;

  /// No description provided for @initialVisit.
  ///
  /// In en, this message translates to:
  /// **'Initial Visit'**
  String get initialVisit;

  /// No description provided for @stepOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}: {stepTitle}'**
  String stepOfTotal(int current, int total, String stepTitle);

  /// No description provided for @caseInformationOptional.
  ///
  /// In en, this message translates to:
  /// **'Case Information (Optional)'**
  String get caseInformationOptional;

  /// No description provided for @caseAutoCreateDescription.
  ///
  /// In en, this message translates to:
  /// **'A case will be automatically created for this patient. You can add a title or skip this step.'**
  String get caseAutoCreateDescription;

  /// No description provided for @caseTitle.
  ///
  /// In en, this message translates to:
  /// **'Case Title'**
  String get caseTitle;

  /// No description provided for @caseTitleExampleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Full Mouth Restoration, Orthodontic Treatment'**
  String get caseTitleExampleHint;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'0988026431'**
  String get phoneHint;

  /// No description provided for @accessRestricted.
  ///
  /// In en, this message translates to:
  /// **'Access Restricted'**
  String get accessRestricted;

  /// No description provided for @accessRestrictedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your role doesn\'t have permission to access this feature. Contact your clinic admin for more information.'**
  String get accessRestrictedDescription;

  /// No description provided for @billingAndInvoices.
  ///
  /// In en, this message translates to:
  /// **'Billing & Invoices'**
  String get billingAndInvoices;

  /// No description provided for @billingPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get billingPageTitle;

  /// No description provided for @selectPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a Plan'**
  String get selectPlanTitle;

  /// No description provided for @invoiceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get invoiceDetailsTitle;

  /// No description provided for @submitProofTitle.
  ///
  /// In en, this message translates to:
  /// **'Submit Payment Proof'**
  String get submitProofTitle;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @noActiveSubscription.
  ///
  /// In en, this message translates to:
  /// **'No active subscription'**
  String get noActiveSubscription;

  /// No description provided for @trialDaysRemaining.
  ///
  /// In en, this message translates to:
  /// **'{days} days remaining in trial'**
  String trialDaysRemaining(int days);

  /// No description provided for @daysUntilRenewal.
  ///
  /// In en, this message translates to:
  /// **'{days} days until renewal'**
  String daysUntilRenewal(int days);

  /// No description provided for @buyOrRenewPlan.
  ///
  /// In en, this message translates to:
  /// **'Buy or Renew Plan'**
  String get buyOrRenewPlan;

  /// No description provided for @continueOpenInvoice.
  ///
  /// In en, this message translates to:
  /// **'Continue Open Invoice'**
  String get continueOpenInvoice;

  /// No description provided for @invoicesHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoicesHistoryTitle;

  /// No description provided for @noInvoicesYet.
  ///
  /// In en, this message translates to:
  /// **'No invoices yet'**
  String get noInvoicesYet;

  /// No description provided for @invoiceLineSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get invoiceLineSubscription;

  /// No description provided for @invoiceIssuedOn.
  ///
  /// In en, this message translates to:
  /// **'Issued on'**
  String get invoiceIssuedOn;

  /// No description provided for @invoiceDueOn.
  ///
  /// In en, this message translates to:
  /// **'Due on'**
  String get invoiceDueOn;

  /// No description provided for @activatesUntil.
  ///
  /// In en, this message translates to:
  /// **'Activates until'**
  String get activatesUntil;

  /// No description provided for @invoiceType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get invoiceType;

  /// No description provided for @renewal.
  ///
  /// In en, this message translates to:
  /// **'Renewal'**
  String get renewal;

  /// No description provided for @invoiceStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get invoiceStatusPending;

  /// No description provided for @invoiceStatusUnderReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get invoiceStatusUnderReview;

  /// No description provided for @invoiceStatusPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invoiceStatusPaid;

  /// No description provided for @invoiceStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get invoiceStatusRejected;

  /// No description provided for @invoiceStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get invoiceStatusCancelled;

  /// No description provided for @billingMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billingMonthly;

  /// No description provided for @billingYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get billingYearly;

  /// No description provided for @selectBillingCycle.
  ///
  /// In en, this message translates to:
  /// **'Billing cycle'**
  String get selectBillingCycle;

  /// No description provided for @choosePlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get choosePlan;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @generateInvoice.
  ///
  /// In en, this message translates to:
  /// **'Generate Invoice'**
  String get generateInvoice;

  /// No description provided for @howToPayTitle.
  ///
  /// In en, this message translates to:
  /// **'How to pay'**
  String get howToPayTitle;

  /// No description provided for @howToPaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use any of the channels below, then upload your receipt.'**
  String get howToPaySubtitle;

  /// No description provided for @referenceNumber.
  ///
  /// In en, this message translates to:
  /// **'Reference Number'**
  String get referenceNumber;

  /// No description provided for @payOutsideAppNotice.
  ///
  /// In en, this message translates to:
  /// **'Payments are processed outside the app. After paying, return here and upload your receipt.'**
  String get payOutsideAppNotice;

  /// No description provided for @paymentMethodSyriatelCash.
  ///
  /// In en, this message translates to:
  /// **'Syriatel Cash'**
  String get paymentMethodSyriatelCash;

  /// No description provided for @paymentMethodShamCash.
  ///
  /// In en, this message translates to:
  /// **'Sham Cash'**
  String get paymentMethodShamCash;

  /// No description provided for @uploadPaymentProof.
  ///
  /// In en, this message translates to:
  /// **'Upload Payment Proof'**
  String get uploadPaymentProof;

  /// No description provided for @uploadReceipt.
  ///
  /// In en, this message translates to:
  /// **'Upload receipt'**
  String get uploadReceipt;

  /// No description provided for @uploadReceiptHint.
  ///
  /// In en, this message translates to:
  /// **'JPG, PNG, or PDF'**
  String get uploadReceiptHint;

  /// No description provided for @methodUsed.
  ///
  /// In en, this message translates to:
  /// **'Method used'**
  String get methodUsed;

  /// No description provided for @transactionReferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Transaction / Reference Number'**
  String get transactionReferenceLabel;

  /// No description provided for @transactionReferenceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. last 4 digits of the transfer ID'**
  String get transactionReferenceHint;

  /// No description provided for @transactionRefShort.
  ///
  /// In en, this message translates to:
  /// **'Ref'**
  String get transactionRefShort;

  /// No description provided for @submittedAt.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submittedAt;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Anything we should know about this payment'**
  String get notesHint;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @receiptRequired.
  ///
  /// In en, this message translates to:
  /// **'Please attach a receipt before submitting.'**
  String get receiptRequired;

  /// No description provided for @submitForReview.
  ///
  /// In en, this message translates to:
  /// **'Submit for Review'**
  String get submitForReview;

  /// No description provided for @invoiceNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Invoice {number}'**
  String invoiceNumberLabel(String number);

  /// No description provided for @proofSubmittedTitle.
  ///
  /// In en, this message translates to:
  /// **'Sent for review'**
  String get proofSubmittedTitle;

  /// No description provided for @proofSubmittedMessage.
  ///
  /// In en, this message translates to:
  /// **'Admin will verify your payment shortly.'**
  String get proofSubmittedMessage;

  /// No description provided for @underReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get underReviewTitle;

  /// No description provided for @underReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'Our team is verifying your payment. You will be notified once it is approved.'**
  String get underReviewMessage;

  /// No description provided for @invoicePaidTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Paid'**
  String get invoicePaidTitle;

  /// No description provided for @invoicePaidOn.
  ///
  /// In en, this message translates to:
  /// **'Paid on'**
  String get invoicePaidOn;

  /// No description provided for @invoiceRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Invoice Rejected'**
  String get invoiceRejectedTitle;

  /// No description provided for @subscriptionExpiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Expired'**
  String get subscriptionExpiredTitle;

  /// No description provided for @subscriptionExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Your clinic is in read-only mode. Renew now to keep adding patients, appointments, and expenses.'**
  String get subscriptionExpiredMessage;

  /// No description provided for @subscriptionExpiredBlocksAction.
  ///
  /// In en, this message translates to:
  /// **'Your subscription has expired. Renew to continue using premium features.'**
  String get subscriptionExpiredBlocksAction;

  /// No description provided for @subscriptionExpiresSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Ending Soon'**
  String get subscriptionExpiresSoonTitle;

  /// No description provided for @subscriptionExpiresInDays.
  ///
  /// In en, this message translates to:
  /// **'Renews in {days} days. Generate an invoice now to avoid downtime.'**
  String subscriptionExpiresInDays(int days);

  /// No description provided for @renewNow.
  ///
  /// In en, this message translates to:
  /// **'Renew Now'**
  String get renewNow;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get notNow;

  /// No description provided for @pricingTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get pricingTitle;

  /// No description provided for @pricingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Simple pricing that grows with your practice'**
  String get pricingSubtitle;

  /// No description provided for @pricingPopularBadge.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get pricingPopularBadge;

  /// No description provided for @pricingCurrentBadge.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get pricingCurrentBadge;

  /// No description provided for @pricingCurrentPlanLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get pricingCurrentPlanLabel;

  /// No description provided for @pricingSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get pricingSelectedLabel;

  /// No description provided for @pricingChooseAction.
  ///
  /// In en, this message translates to:
  /// **'Choose {plan}'**
  String pricingChooseAction(String plan);

  /// No description provided for @pricingContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get pricingContactUs;

  /// No description provided for @pricingCustomPricing.
  ///
  /// In en, this message translates to:
  /// **'Custom pricing'**
  String get pricingCustomPricing;

  /// No description provided for @pricingMonthSuffix.
  ///
  /// In en, this message translates to:
  /// **'/month'**
  String get pricingMonthSuffix;

  /// No description provided for @pricingYearSuffix.
  ///
  /// In en, this message translates to:
  /// **'/year'**
  String get pricingYearSuffix;

  /// No description provided for @pricingMoSuffix.
  ///
  /// In en, this message translates to:
  /// **'/mo'**
  String get pricingMoSuffix;

  /// No description provided for @pricingYrSuffix.
  ///
  /// In en, this message translates to:
  /// **'/yr'**
  String get pricingYrSuffix;

  /// No description provided for @pricingSaveAmount.
  ///
  /// In en, this message translates to:
  /// **'Save \${amount}'**
  String pricingSaveAmount(String amount);

  /// No description provided for @pricingSubscribeAction.
  ///
  /// In en, this message translates to:
  /// **'Subscribe to {plan} · {priceText}'**
  String pricingSubscribeAction(String plan, String priceText);

  /// No description provided for @pricingStartFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get pricingStartFreeTrial;

  /// No description provided for @pricingStartShort.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get pricingStartShort;

  /// No description provided for @pricingSubscriptionActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Active'**
  String get pricingSubscriptionActiveTitle;

  /// No description provided for @pricingSubscriptionActiveMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to your new plan!'**
  String get pricingSubscriptionActiveMessage;

  /// No description provided for @pricingTrialStartedTitle.
  ///
  /// In en, this message translates to:
  /// **'Trial Started'**
  String get pricingTrialStartedTitle;

  /// No description provided for @pricingTrialStartedMessage.
  ///
  /// In en, this message translates to:
  /// **'Enjoy 30 days of full access!'**
  String get pricingTrialStartedMessage;

  /// No description provided for @planEverythingInPlus.
  ///
  /// In en, this message translates to:
  /// **'Everything in {plan}, plus:'**
  String planEverythingInPlus(String plan);

  /// No description provided for @planSoloName.
  ///
  /// In en, this message translates to:
  /// **'Solo'**
  String get planSoloName;

  /// No description provided for @planSoloDescription.
  ///
  /// In en, this message translates to:
  /// **'For a single dentist starting out'**
  String get planSoloDescription;

  /// No description provided for @planSoloFeature1.
  ///
  /// In en, this message translates to:
  /// **'1 dentist'**
  String get planSoloFeature1;

  /// No description provided for @planSoloFeature2.
  ///
  /// In en, this message translates to:
  /// **'1 assistant'**
  String get planSoloFeature2;

  /// No description provided for @planSoloFeature3.
  ///
  /// In en, this message translates to:
  /// **'Unlimited patients'**
  String get planSoloFeature3;

  /// No description provided for @planSoloFeature4.
  ///
  /// In en, this message translates to:
  /// **'Appointment scheduling'**
  String get planSoloFeature4;

  /// No description provided for @planSoloFeature5.
  ///
  /// In en, this message translates to:
  /// **'Treatment plans & records'**
  String get planSoloFeature5;

  /// No description provided for @planSoloFeature6.
  ///
  /// In en, this message translates to:
  /// **'Invoice generation'**
  String get planSoloFeature6;

  /// No description provided for @planSoloFeature7.
  ///
  /// In en, this message translates to:
  /// **'X-ray & photo storage'**
  String get planSoloFeature7;

  /// No description provided for @planSoloFeature8.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync & backup'**
  String get planSoloFeature8;

  /// No description provided for @planSoloFeature9.
  ///
  /// In en, this message translates to:
  /// **'Email support'**
  String get planSoloFeature9;

  /// No description provided for @planDuoName.
  ///
  /// In en, this message translates to:
  /// **'Duo'**
  String get planDuoName;

  /// No description provided for @planDuoDescription.
  ///
  /// In en, this message translates to:
  /// **'For two dentists working together'**
  String get planDuoDescription;

  /// No description provided for @planDuoFeature1.
  ///
  /// In en, this message translates to:
  /// **'Up to 2 dentists'**
  String get planDuoFeature1;

  /// No description provided for @planDuoFeature2.
  ///
  /// In en, this message translates to:
  /// **'Up to 2 assistants'**
  String get planDuoFeature2;

  /// No description provided for @planDuoFeature3.
  ///
  /// In en, this message translates to:
  /// **'Statistics & analytics dashboard'**
  String get planDuoFeature3;

  /// No description provided for @planDuoFeature4.
  ///
  /// In en, this message translates to:
  /// **'Email & SMS reminders'**
  String get planDuoFeature4;

  /// No description provided for @planDuoFeature5.
  ///
  /// In en, this message translates to:
  /// **'Priority email support'**
  String get planDuoFeature5;

  /// No description provided for @planClinicName.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get planClinicName;

  /// No description provided for @planClinicDescription.
  ///
  /// In en, this message translates to:
  /// **'For mid-size centers'**
  String get planClinicDescription;

  /// No description provided for @planClinicFeature1.
  ///
  /// In en, this message translates to:
  /// **'Up to 4 dentists'**
  String get planClinicFeature1;

  /// No description provided for @planClinicFeature2.
  ///
  /// In en, this message translates to:
  /// **'Up to 6 staff members'**
  String get planClinicFeature2;

  /// No description provided for @planClinicFeature3.
  ///
  /// In en, this message translates to:
  /// **'1 branch location'**
  String get planClinicFeature3;

  /// No description provided for @planClinicFeature4.
  ///
  /// In en, this message translates to:
  /// **'Statistics & analytics dashboard'**
  String get planClinicFeature4;

  /// No description provided for @planClinicFeature5.
  ///
  /// In en, this message translates to:
  /// **'Advanced reports'**
  String get planClinicFeature5;

  /// No description provided for @planClinicFeature6.
  ///
  /// In en, this message translates to:
  /// **'Unlimited patients'**
  String get planClinicFeature6;

  /// No description provided for @planClinicFeature7.
  ///
  /// In en, this message translates to:
  /// **'Appointment scheduling'**
  String get planClinicFeature7;

  /// No description provided for @planClinicFeature8.
  ///
  /// In en, this message translates to:
  /// **'Treatment plans & records'**
  String get planClinicFeature8;

  /// No description provided for @planClinicFeature9.
  ///
  /// In en, this message translates to:
  /// **'Invoice generation & branding'**
  String get planClinicFeature9;

  /// No description provided for @planClinicFeature10.
  ///
  /// In en, this message translates to:
  /// **'X-ray & photo storage'**
  String get planClinicFeature10;

  /// No description provided for @planClinicFeature11.
  ///
  /// In en, this message translates to:
  /// **'Email & SMS reminders'**
  String get planClinicFeature11;

  /// No description provided for @planClinicFeature12.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync & backup'**
  String get planClinicFeature12;

  /// No description provided for @planClinicFeature13.
  ///
  /// In en, this message translates to:
  /// **'Live chat support'**
  String get planClinicFeature13;

  /// No description provided for @planPracticeName.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get planPracticeName;

  /// No description provided for @planPracticeDescription.
  ///
  /// In en, this message translates to:
  /// **'For big centers and multi-branch practices'**
  String get planPracticeDescription;

  /// No description provided for @planPracticeFeature1.
  ///
  /// In en, this message translates to:
  /// **'Up to 8 dentists'**
  String get planPracticeFeature1;

  /// No description provided for @planPracticeFeature2.
  ///
  /// In en, this message translates to:
  /// **'Unlimited staff members'**
  String get planPracticeFeature2;

  /// No description provided for @planPracticeFeature3.
  ///
  /// In en, this message translates to:
  /// **'Up to 3 branch locations'**
  String get planPracticeFeature3;

  /// No description provided for @planPracticeFeature4.
  ///
  /// In en, this message translates to:
  /// **'Cross-location analytics'**
  String get planPracticeFeature4;

  /// No description provided for @planPracticeFeature5.
  ///
  /// In en, this message translates to:
  /// **'Phone & chat support'**
  String get planPracticeFeature5;

  /// No description provided for @planPracticeFeature6.
  ///
  /// In en, this message translates to:
  /// **'Priority training sessions'**
  String get planPracticeFeature6;

  /// No description provided for @planCustomName.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get planCustomName;

  /// No description provided for @planCustomDescription.
  ///
  /// In en, this message translates to:
  /// **'Tailored to your organization'**
  String get planCustomDescription;

  /// No description provided for @planCustomFeature1.
  ///
  /// In en, this message translates to:
  /// **'10+ dentists'**
  String get planCustomFeature1;

  /// No description provided for @planCustomFeature2.
  ///
  /// In en, this message translates to:
  /// **'Unlimited staff & branches'**
  String get planCustomFeature2;

  /// No description provided for @planCustomFeature3.
  ///
  /// In en, this message translates to:
  /// **'Custom integrations'**
  String get planCustomFeature3;

  /// No description provided for @planCustomFeature4.
  ///
  /// In en, this message translates to:
  /// **'Dedicated account manager'**
  String get planCustomFeature4;

  /// No description provided for @planCustomFeature5.
  ///
  /// In en, this message translates to:
  /// **'On-site training'**
  String get planCustomFeature5;

  /// No description provided for @planCustomFeature6.
  ///
  /// In en, this message translates to:
  /// **'SLA & uptime guarantees'**
  String get planCustomFeature6;

  /// No description provided for @planCustomFeature7.
  ///
  /// In en, this message translates to:
  /// **'Volume discounts'**
  String get planCustomFeature7;

  /// No description provided for @planCustomFeature8.
  ///
  /// In en, this message translates to:
  /// **'Tailored to your needs'**
  String get planCustomFeature8;

  /// No description provided for @editPatient.
  ///
  /// In en, this message translates to:
  /// **'Edit Patient'**
  String get editPatient;

  /// No description provided for @deletePatient.
  ///
  /// In en, this message translates to:
  /// **'Delete Patient'**
  String get deletePatient;

  /// No description provided for @deletePatientConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String deletePatientConfirmation(String name);

  /// No description provided for @patientDeleted.
  ///
  /// In en, this message translates to:
  /// **'Patient deleted'**
  String get patientDeleted;

  /// No description provided for @patientUpdated.
  ///
  /// In en, this message translates to:
  /// **'Patient updated'**
  String get patientUpdated;

  /// No description provided for @updatingPatient.
  ///
  /// In en, this message translates to:
  /// **'Updating patient...'**
  String get updatingPatient;

  /// No description provided for @couldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open the link'**
  String get couldNotOpenLink;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
