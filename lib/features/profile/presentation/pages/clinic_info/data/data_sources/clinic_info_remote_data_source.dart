import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/clinic_info/data/models/clinic_info_model.dart';
import 'package:injectable/injectable.dart';

abstract class ClinicInfoRemoteDataSource {
  Future<ClinicInfoModel> getClinicInfo();
  Future<ClinicInfoModel> updateClinicInfo(ClinicInfoModel clinicInfo);
}

@Injectable(as: ClinicInfoRemoteDataSource)
class ClinicInfoRemoteDataSourceImpl implements ClinicInfoRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  ClinicInfoRemoteDataSourceImpl(this._apiConsumer);

  ClinicInfoModel? _cachedClinicInfo;

  ClinicInfoModel _getMockClinicInfo() {
    if (_cachedClinicInfo != null) return _cachedClinicInfo!;

    _cachedClinicInfo = ClinicInfoModel(
      id: 'clinic_1',
      name: 'Bright Smile Dental',
      workingDays: [
        const WorkingDayModel(
          key: 'mon',
          labelEn: 'Monday',
          labelAr: 'الإثنين',
          enabled: true,
          shifts: [ShiftModel(from: '09:00', to: '17:00')],
        ),
        const WorkingDayModel(
          key: 'tue',
          labelEn: 'Tuesday',
          labelAr: 'الثلاثاء',
          enabled: true,
          shifts: [ShiftModel(from: '09:00', to: '17:00')],
        ),
        const WorkingDayModel(
          key: 'wed',
          labelEn: 'Wednesday',
          labelAr: 'الأربعاء',
          enabled: true,
          shifts: [ShiftModel(from: '09:00', to: '17:00')],
        ),
        const WorkingDayModel(
          key: 'thu',
          labelEn: 'Thursday',
          labelAr: 'الخميس',
          enabled: true,
          shifts: [ShiftModel(from: '09:00', to: '17:00')],
        ),
        const WorkingDayModel(
          key: 'fri',
          labelEn: 'Friday',
          labelAr: 'الجمعة',
          enabled: false,
          shifts: [ShiftModel(from: '09:00', to: '17:00')],
        ),
        const WorkingDayModel(
          key: 'sat',
          labelEn: 'Saturday',
          labelAr: 'السبت',
          enabled: true,
          shifts: [ShiftModel(from: '10:00', to: '14:00')],
        ),
        const WorkingDayModel(
          key: 'sun',
          labelEn: 'Sunday',
          labelAr: 'الأحد',
          enabled: false,
          shifts: [ShiftModel(from: '09:00', to: '17:00')],
        ),
      ],
      holidays: [
        HolidayModel(
          id: 'h1',
          name: 'Eid Al-Fitr',
          date: DateTime(2026, 3, 20).toIso8601String(),
          recurring: true,
        ),
        HolidayModel(
          id: 'h2',
          name: 'New Year',
          date: DateTime(2026, 1, 1).toIso8601String(),
          recurring: true,
        ),
      ],
    );
    return _cachedClinicInfo!;
  }

  @override
  Future<ClinicInfoModel> getClinicInfo() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.get(ClinicInfoEndpoints.clinicInfo);
    // return ClinicInfoModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockClinicInfo();
  }

  @override
  Future<ClinicInfoModel> updateClinicInfo(ClinicInfoModel clinicInfo) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await _apiConsumer.put(
    //   ClinicInfoEndpoints.updateClinicInfo,
    //   body: clinicInfo.toJson(),
    // );
    // return ClinicInfoModel.fromJson(response as Map<String, dynamic>);

    await Future.delayed(const Duration(milliseconds: 600));
    _cachedClinicInfo = clinicInfo;
    return clinicInfo;
  }
}
