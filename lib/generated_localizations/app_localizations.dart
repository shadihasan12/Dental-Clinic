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

  /// No description provided for @workingHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get workingHours;

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
