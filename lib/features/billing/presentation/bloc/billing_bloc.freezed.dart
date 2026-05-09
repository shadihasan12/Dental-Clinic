// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BillingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillingEventCopyWith<$Res> {
  factory $BillingEventCopyWith(
    BillingEvent value,
    $Res Function(BillingEvent) then,
  ) = _$BillingEventCopyWithImpl<$Res, BillingEvent>;
}

/// @nodoc
class _$BillingEventCopyWithImpl<$Res, $Val extends BillingEvent>
    implements $BillingEventCopyWith<$Res> {
  _$BillingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadInvoicesImplCopyWith<$Res> {
  factory _$$LoadInvoicesImplCopyWith(
    _$LoadInvoicesImpl value,
    $Res Function(_$LoadInvoicesImpl) then,
  ) = __$$LoadInvoicesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String clinicId});
}

/// @nodoc
class __$$LoadInvoicesImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$LoadInvoicesImpl>
    implements _$$LoadInvoicesImplCopyWith<$Res> {
  __$$LoadInvoicesImplCopyWithImpl(
    _$LoadInvoicesImpl _value,
    $Res Function(_$LoadInvoicesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? clinicId = null}) {
    return _then(
      _$LoadInvoicesImpl(
        null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadInvoicesImpl implements _LoadInvoices {
  const _$LoadInvoicesImpl(this.clinicId);

  @override
  final String clinicId;

  @override
  String toString() {
    return 'BillingEvent.loadInvoices(clinicId: $clinicId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadInvoicesImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clinicId);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadInvoicesImplCopyWith<_$LoadInvoicesImpl> get copyWith =>
      __$$LoadInvoicesImplCopyWithImpl<_$LoadInvoicesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return loadInvoices(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return loadInvoices?.call(clinicId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (loadInvoices != null) {
      return loadInvoices(clinicId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return loadInvoices(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return loadInvoices?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (loadInvoices != null) {
      return loadInvoices(this);
    }
    return orElse();
  }
}

abstract class _LoadInvoices implements BillingEvent {
  const factory _LoadInvoices(final String clinicId) = _$LoadInvoicesImpl;

  String get clinicId;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadInvoicesImplCopyWith<_$LoadInvoicesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateInvoiceImplCopyWith<$Res> {
  factory _$$CreateInvoiceImplCopyWith(
    _$CreateInvoiceImpl value,
    $Res Function(_$CreateInvoiceImpl) then,
  ) = __$$CreateInvoiceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String clinicId,
    SubscriptionPlanEntity plan,
    BillingCycle cycle,
    bool isRenewal,
  });

  $SubscriptionPlanEntityCopyWith<$Res> get plan;
}

/// @nodoc
class __$$CreateInvoiceImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$CreateInvoiceImpl>
    implements _$$CreateInvoiceImplCopyWith<$Res> {
  __$$CreateInvoiceImplCopyWithImpl(
    _$CreateInvoiceImpl _value,
    $Res Function(_$CreateInvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clinicId = null,
    Object? plan = null,
    Object? cycle = null,
    Object? isRenewal = null,
  }) {
    return _then(
      _$CreateInvoiceImpl(
        clinicId: null == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String,
        plan: null == plan
            ? _value.plan
            : plan // ignore: cast_nullable_to_non_nullable
                  as SubscriptionPlanEntity,
        cycle: null == cycle
            ? _value.cycle
            : cycle // ignore: cast_nullable_to_non_nullable
                  as BillingCycle,
        isRenewal: null == isRenewal
            ? _value.isRenewal
            : isRenewal // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPlanEntityCopyWith<$Res> get plan {
    return $SubscriptionPlanEntityCopyWith<$Res>(_value.plan, (value) {
      return _then(_value.copyWith(plan: value));
    });
  }
}

/// @nodoc

class _$CreateInvoiceImpl implements _CreateInvoice {
  const _$CreateInvoiceImpl({
    required this.clinicId,
    required this.plan,
    required this.cycle,
    this.isRenewal = false,
  });

  @override
  final String clinicId;
  @override
  final SubscriptionPlanEntity plan;
  @override
  final BillingCycle cycle;
  @override
  @JsonKey()
  final bool isRenewal;

  @override
  String toString() {
    return 'BillingEvent.createInvoice(clinicId: $clinicId, plan: $plan, cycle: $cycle, isRenewal: $isRenewal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateInvoiceImpl &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.plan, plan) || other.plan == plan) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
            (identical(other.isRenewal, isRenewal) ||
                other.isRenewal == isRenewal));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, clinicId, plan, cycle, isRenewal);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateInvoiceImplCopyWith<_$CreateInvoiceImpl> get copyWith =>
      __$$CreateInvoiceImplCopyWithImpl<_$CreateInvoiceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return createInvoice(clinicId, plan, cycle, isRenewal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return createInvoice?.call(clinicId, plan, cycle, isRenewal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (createInvoice != null) {
      return createInvoice(clinicId, plan, cycle, isRenewal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return createInvoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return createInvoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (createInvoice != null) {
      return createInvoice(this);
    }
    return orElse();
  }
}

abstract class _CreateInvoice implements BillingEvent {
  const factory _CreateInvoice({
    required final String clinicId,
    required final SubscriptionPlanEntity plan,
    required final BillingCycle cycle,
    final bool isRenewal,
  }) = _$CreateInvoiceImpl;

  String get clinicId;
  SubscriptionPlanEntity get plan;
  BillingCycle get cycle;
  bool get isRenewal;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateInvoiceImplCopyWith<_$CreateInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectInvoiceImplCopyWith<$Res> {
  factory _$$SelectInvoiceImplCopyWith(
    _$SelectInvoiceImpl value,
    $Res Function(_$SelectInvoiceImpl) then,
  ) = __$$SelectInvoiceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvoiceEntity invoice});

  $InvoiceEntityCopyWith<$Res> get invoice;
}

/// @nodoc
class __$$SelectInvoiceImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$SelectInvoiceImpl>
    implements _$$SelectInvoiceImplCopyWith<$Res> {
  __$$SelectInvoiceImplCopyWithImpl(
    _$SelectInvoiceImpl _value,
    $Res Function(_$SelectInvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invoice = null}) {
    return _then(
      _$SelectInvoiceImpl(
        null == invoice
            ? _value.invoice
            : invoice // ignore: cast_nullable_to_non_nullable
                  as InvoiceEntity,
      ),
    );
  }

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvoiceEntityCopyWith<$Res> get invoice {
    return $InvoiceEntityCopyWith<$Res>(_value.invoice, (value) {
      return _then(_value.copyWith(invoice: value));
    });
  }
}

/// @nodoc

class _$SelectInvoiceImpl implements _SelectInvoice {
  const _$SelectInvoiceImpl(this.invoice);

  @override
  final InvoiceEntity invoice;

  @override
  String toString() {
    return 'BillingEvent.selectInvoice(invoice: $invoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectInvoiceImpl &&
            (identical(other.invoice, invoice) || other.invoice == invoice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invoice);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectInvoiceImplCopyWith<_$SelectInvoiceImpl> get copyWith =>
      __$$SelectInvoiceImplCopyWithImpl<_$SelectInvoiceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return selectInvoice(invoice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return selectInvoice?.call(invoice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (selectInvoice != null) {
      return selectInvoice(invoice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return selectInvoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return selectInvoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (selectInvoice != null) {
      return selectInvoice(this);
    }
    return orElse();
  }
}

abstract class _SelectInvoice implements BillingEvent {
  const factory _SelectInvoice(final InvoiceEntity invoice) =
      _$SelectInvoiceImpl;

  InvoiceEntity get invoice;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectInvoiceImplCopyWith<_$SelectInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitProofImplCopyWith<$Res> {
  factory _$$SubmitProofImplCopyWith(
    _$SubmitProofImpl value,
    $Res Function(_$SubmitProofImpl) then,
  ) = __$$SubmitProofImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String invoiceId,
    File receipt,
    String referenceNumber,
    ManualPaymentMethod method,
    String? notes,
  });
}

/// @nodoc
class __$$SubmitProofImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$SubmitProofImpl>
    implements _$$SubmitProofImplCopyWith<$Res> {
  __$$SubmitProofImplCopyWithImpl(
    _$SubmitProofImpl _value,
    $Res Function(_$SubmitProofImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? invoiceId = null,
    Object? receipt = null,
    Object? referenceNumber = null,
    Object? method = null,
    Object? notes = freezed,
  }) {
    return _then(
      _$SubmitProofImpl(
        invoiceId: null == invoiceId
            ? _value.invoiceId
            : invoiceId // ignore: cast_nullable_to_non_nullable
                  as String,
        receipt: null == receipt
            ? _value.receipt
            : receipt // ignore: cast_nullable_to_non_nullable
                  as File,
        referenceNumber: null == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        method: null == method
            ? _value.method
            : method // ignore: cast_nullable_to_non_nullable
                  as ManualPaymentMethod,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SubmitProofImpl implements _SubmitProof {
  const _$SubmitProofImpl({
    required this.invoiceId,
    required this.receipt,
    required this.referenceNumber,
    required this.method,
    this.notes,
  });

  @override
  final String invoiceId;
  @override
  final File receipt;
  @override
  final String referenceNumber;
  @override
  final ManualPaymentMethod method;
  @override
  final String? notes;

  @override
  String toString() {
    return 'BillingEvent.submitProof(invoiceId: $invoiceId, receipt: $receipt, referenceNumber: $referenceNumber, method: $method, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitProofImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.receipt, receipt) || other.receipt == receipt) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    invoiceId,
    receipt,
    referenceNumber,
    method,
    notes,
  );

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitProofImplCopyWith<_$SubmitProofImpl> get copyWith =>
      __$$SubmitProofImplCopyWithImpl<_$SubmitProofImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return submitProof(invoiceId, receipt, referenceNumber, method, notes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return submitProof?.call(
      invoiceId,
      receipt,
      referenceNumber,
      method,
      notes,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (submitProof != null) {
      return submitProof(invoiceId, receipt, referenceNumber, method, notes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return submitProof(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return submitProof?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (submitProof != null) {
      return submitProof(this);
    }
    return orElse();
  }
}

abstract class _SubmitProof implements BillingEvent {
  const factory _SubmitProof({
    required final String invoiceId,
    required final File receipt,
    required final String referenceNumber,
    required final ManualPaymentMethod method,
    final String? notes,
  }) = _$SubmitProofImpl;

  String get invoiceId;
  File get receipt;
  String get referenceNumber;
  ManualPaymentMethod get method;
  String? get notes;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitProofImplCopyWith<_$SubmitProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearFlagsImplCopyWith<$Res> {
  factory _$$ClearFlagsImplCopyWith(
    _$ClearFlagsImpl value,
    $Res Function(_$ClearFlagsImpl) then,
  ) = __$$ClearFlagsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearFlagsImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$ClearFlagsImpl>
    implements _$$ClearFlagsImplCopyWith<$Res> {
  __$$ClearFlagsImplCopyWithImpl(
    _$ClearFlagsImpl _value,
    $Res Function(_$ClearFlagsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearFlagsImpl implements _ClearFlags {
  const _$ClearFlagsImpl();

  @override
  String toString() {
    return 'BillingEvent.clearFlags()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearFlagsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return clearFlags();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return clearFlags?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (clearFlags != null) {
      return clearFlags();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return clearFlags(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return clearFlags?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (clearFlags != null) {
      return clearFlags(this);
    }
    return orElse();
  }
}

abstract class _ClearFlags implements BillingEvent {
  const factory _ClearFlags() = _$ClearFlagsImpl;
}

/// @nodoc
abstract class _$$AdminApproveInvoiceImplCopyWith<$Res> {
  factory _$$AdminApproveInvoiceImplCopyWith(
    _$AdminApproveInvoiceImpl value,
    $Res Function(_$AdminApproveInvoiceImpl) then,
  ) = __$$AdminApproveInvoiceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String invoiceId});
}

/// @nodoc
class __$$AdminApproveInvoiceImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$AdminApproveInvoiceImpl>
    implements _$$AdminApproveInvoiceImplCopyWith<$Res> {
  __$$AdminApproveInvoiceImplCopyWithImpl(
    _$AdminApproveInvoiceImpl _value,
    $Res Function(_$AdminApproveInvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invoiceId = null}) {
    return _then(
      _$AdminApproveInvoiceImpl(
        null == invoiceId
            ? _value.invoiceId
            : invoiceId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminApproveInvoiceImpl implements _AdminApproveInvoice {
  const _$AdminApproveInvoiceImpl(this.invoiceId);

  @override
  final String invoiceId;

  @override
  String toString() {
    return 'BillingEvent.adminApproveInvoice(invoiceId: $invoiceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminApproveInvoiceImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invoiceId);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminApproveInvoiceImplCopyWith<_$AdminApproveInvoiceImpl> get copyWith =>
      __$$AdminApproveInvoiceImplCopyWithImpl<_$AdminApproveInvoiceImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return adminApproveInvoice(invoiceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return adminApproveInvoice?.call(invoiceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (adminApproveInvoice != null) {
      return adminApproveInvoice(invoiceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return adminApproveInvoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return adminApproveInvoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (adminApproveInvoice != null) {
      return adminApproveInvoice(this);
    }
    return orElse();
  }
}

abstract class _AdminApproveInvoice implements BillingEvent {
  const factory _AdminApproveInvoice(final String invoiceId) =
      _$AdminApproveInvoiceImpl;

  String get invoiceId;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminApproveInvoiceImplCopyWith<_$AdminApproveInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminRejectInvoiceImplCopyWith<$Res> {
  factory _$$AdminRejectInvoiceImplCopyWith(
    _$AdminRejectInvoiceImpl value,
    $Res Function(_$AdminRejectInvoiceImpl) then,
  ) = __$$AdminRejectInvoiceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String invoiceId, String? reason});
}

/// @nodoc
class __$$AdminRejectInvoiceImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$AdminRejectInvoiceImpl>
    implements _$$AdminRejectInvoiceImplCopyWith<$Res> {
  __$$AdminRejectInvoiceImplCopyWithImpl(
    _$AdminRejectInvoiceImpl _value,
    $Res Function(_$AdminRejectInvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invoiceId = null, Object? reason = freezed}) {
    return _then(
      _$AdminRejectInvoiceImpl(
        invoiceId: null == invoiceId
            ? _value.invoiceId
            : invoiceId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AdminRejectInvoiceImpl implements _AdminRejectInvoice {
  const _$AdminRejectInvoiceImpl({required this.invoiceId, this.reason});

  @override
  final String invoiceId;
  @override
  final String? reason;

  @override
  String toString() {
    return 'BillingEvent.adminRejectInvoice(invoiceId: $invoiceId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminRejectInvoiceImpl &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invoiceId, reason);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminRejectInvoiceImplCopyWith<_$AdminRejectInvoiceImpl> get copyWith =>
      __$$AdminRejectInvoiceImplCopyWithImpl<_$AdminRejectInvoiceImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return adminRejectInvoice(invoiceId, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return adminRejectInvoice?.call(invoiceId, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (adminRejectInvoice != null) {
      return adminRejectInvoice(invoiceId, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return adminRejectInvoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return adminRejectInvoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (adminRejectInvoice != null) {
      return adminRejectInvoice(this);
    }
    return orElse();
  }
}

abstract class _AdminRejectInvoice implements BillingEvent {
  const factory _AdminRejectInvoice({
    required final String invoiceId,
    final String? reason,
  }) = _$AdminRejectInvoiceImpl;

  String get invoiceId;
  String? get reason;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminRejectInvoiceImplCopyWith<_$AdminRejectInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvoiceMutatedImplCopyWith<$Res> {
  factory _$$InvoiceMutatedImplCopyWith(
    _$InvoiceMutatedImpl value,
    $Res Function(_$InvoiceMutatedImpl) then,
  ) = __$$InvoiceMutatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvoiceEntity invoice});

  $InvoiceEntityCopyWith<$Res> get invoice;
}

/// @nodoc
class __$$InvoiceMutatedImplCopyWithImpl<$Res>
    extends _$BillingEventCopyWithImpl<$Res, _$InvoiceMutatedImpl>
    implements _$$InvoiceMutatedImplCopyWith<$Res> {
  __$$InvoiceMutatedImplCopyWithImpl(
    _$InvoiceMutatedImpl _value,
    $Res Function(_$InvoiceMutatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invoice = null}) {
    return _then(
      _$InvoiceMutatedImpl(
        null == invoice
            ? _value.invoice
            : invoice // ignore: cast_nullable_to_non_nullable
                  as InvoiceEntity,
      ),
    );
  }

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvoiceEntityCopyWith<$Res> get invoice {
    return $InvoiceEntityCopyWith<$Res>(_value.invoice, (value) {
      return _then(_value.copyWith(invoice: value));
    });
  }
}

/// @nodoc

class _$InvoiceMutatedImpl implements _InvoiceMutated {
  const _$InvoiceMutatedImpl(this.invoice);

  @override
  final InvoiceEntity invoice;

  @override
  String toString() {
    return 'BillingEvent.invoiceMutated(invoice: $invoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvoiceMutatedImpl &&
            (identical(other.invoice, invoice) || other.invoice == invoice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invoice);

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvoiceMutatedImplCopyWith<_$InvoiceMutatedImpl> get copyWith =>
      __$$InvoiceMutatedImplCopyWithImpl<_$InvoiceMutatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String clinicId) loadInvoices,
    required TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )
    createInvoice,
    required TResult Function(InvoiceEntity invoice) selectInvoice,
    required TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )
    submitProof,
    required TResult Function() clearFlags,
    required TResult Function(String invoiceId) adminApproveInvoice,
    required TResult Function(String invoiceId, String? reason)
    adminRejectInvoice,
    required TResult Function(InvoiceEntity invoice) invoiceMutated,
  }) {
    return invoiceMutated(invoice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String clinicId)? loadInvoices,
    TResult? Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult? Function(InvoiceEntity invoice)? selectInvoice,
    TResult? Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult? Function()? clearFlags,
    TResult? Function(String invoiceId)? adminApproveInvoice,
    TResult? Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult? Function(InvoiceEntity invoice)? invoiceMutated,
  }) {
    return invoiceMutated?.call(invoice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String clinicId)? loadInvoices,
    TResult Function(
      String clinicId,
      SubscriptionPlanEntity plan,
      BillingCycle cycle,
      bool isRenewal,
    )?
    createInvoice,
    TResult Function(InvoiceEntity invoice)? selectInvoice,
    TResult Function(
      String invoiceId,
      File receipt,
      String referenceNumber,
      ManualPaymentMethod method,
      String? notes,
    )?
    submitProof,
    TResult Function()? clearFlags,
    TResult Function(String invoiceId)? adminApproveInvoice,
    TResult Function(String invoiceId, String? reason)? adminRejectInvoice,
    TResult Function(InvoiceEntity invoice)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (invoiceMutated != null) {
      return invoiceMutated(invoice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadInvoices value) loadInvoices,
    required TResult Function(_CreateInvoice value) createInvoice,
    required TResult Function(_SelectInvoice value) selectInvoice,
    required TResult Function(_SubmitProof value) submitProof,
    required TResult Function(_ClearFlags value) clearFlags,
    required TResult Function(_AdminApproveInvoice value) adminApproveInvoice,
    required TResult Function(_AdminRejectInvoice value) adminRejectInvoice,
    required TResult Function(_InvoiceMutated value) invoiceMutated,
  }) {
    return invoiceMutated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadInvoices value)? loadInvoices,
    TResult? Function(_CreateInvoice value)? createInvoice,
    TResult? Function(_SelectInvoice value)? selectInvoice,
    TResult? Function(_SubmitProof value)? submitProof,
    TResult? Function(_ClearFlags value)? clearFlags,
    TResult? Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult? Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult? Function(_InvoiceMutated value)? invoiceMutated,
  }) {
    return invoiceMutated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadInvoices value)? loadInvoices,
    TResult Function(_CreateInvoice value)? createInvoice,
    TResult Function(_SelectInvoice value)? selectInvoice,
    TResult Function(_SubmitProof value)? submitProof,
    TResult Function(_ClearFlags value)? clearFlags,
    TResult Function(_AdminApproveInvoice value)? adminApproveInvoice,
    TResult Function(_AdminRejectInvoice value)? adminRejectInvoice,
    TResult Function(_InvoiceMutated value)? invoiceMutated,
    required TResult orElse(),
  }) {
    if (invoiceMutated != null) {
      return invoiceMutated(this);
    }
    return orElse();
  }
}

abstract class _InvoiceMutated implements BillingEvent {
  const factory _InvoiceMutated(final InvoiceEntity invoice) =
      _$InvoiceMutatedImpl;

  InvoiceEntity get invoice;

  /// Create a copy of BillingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvoiceMutatedImplCopyWith<_$InvoiceMutatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BillingState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  List<InvoiceEntity> get invoices => throw _privateConstructorUsedError;
  String? get clinicId => throw _privateConstructorUsedError;
  InvoiceEntity? get activeInvoice => throw _privateConstructorUsedError;
  PaymentInstructions? get activeInstructions =>
      throw _privateConstructorUsedError;
  String? get error =>
      throw _privateConstructorUsedError; // One-shot flags consumed by the UI in BlocListener.
  InvoiceEntity? get createdInvoice => throw _privateConstructorUsedError;
  bool get proofSubmitted => throw _privateConstructorUsedError;

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BillingStateCopyWith<BillingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillingStateCopyWith<$Res> {
  factory $BillingStateCopyWith(
    BillingState value,
    $Res Function(BillingState) then,
  ) = _$BillingStateCopyWithImpl<$Res, BillingState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isProcessing,
    List<InvoiceEntity> invoices,
    String? clinicId,
    InvoiceEntity? activeInvoice,
    PaymentInstructions? activeInstructions,
    String? error,
    InvoiceEntity? createdInvoice,
    bool proofSubmitted,
  });

  $InvoiceEntityCopyWith<$Res>? get activeInvoice;
  $InvoiceEntityCopyWith<$Res>? get createdInvoice;
}

/// @nodoc
class _$BillingStateCopyWithImpl<$Res, $Val extends BillingState>
    implements $BillingStateCopyWith<$Res> {
  _$BillingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessing = null,
    Object? invoices = null,
    Object? clinicId = freezed,
    Object? activeInvoice = freezed,
    Object? activeInstructions = freezed,
    Object? error = freezed,
    Object? createdInvoice = freezed,
    Object? proofSubmitted = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isProcessing: null == isProcessing
                ? _value.isProcessing
                : isProcessing // ignore: cast_nullable_to_non_nullable
                      as bool,
            invoices: null == invoices
                ? _value.invoices
                : invoices // ignore: cast_nullable_to_non_nullable
                      as List<InvoiceEntity>,
            clinicId: freezed == clinicId
                ? _value.clinicId
                : clinicId // ignore: cast_nullable_to_non_nullable
                      as String?,
            activeInvoice: freezed == activeInvoice
                ? _value.activeInvoice
                : activeInvoice // ignore: cast_nullable_to_non_nullable
                      as InvoiceEntity?,
            activeInstructions: freezed == activeInstructions
                ? _value.activeInstructions
                : activeInstructions // ignore: cast_nullable_to_non_nullable
                      as PaymentInstructions?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdInvoice: freezed == createdInvoice
                ? _value.createdInvoice
                : createdInvoice // ignore: cast_nullable_to_non_nullable
                      as InvoiceEntity?,
            proofSubmitted: null == proofSubmitted
                ? _value.proofSubmitted
                : proofSubmitted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvoiceEntityCopyWith<$Res>? get activeInvoice {
    if (_value.activeInvoice == null) {
      return null;
    }

    return $InvoiceEntityCopyWith<$Res>(_value.activeInvoice!, (value) {
      return _then(_value.copyWith(activeInvoice: value) as $Val);
    });
  }

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InvoiceEntityCopyWith<$Res>? get createdInvoice {
    if (_value.createdInvoice == null) {
      return null;
    }

    return $InvoiceEntityCopyWith<$Res>(_value.createdInvoice!, (value) {
      return _then(_value.copyWith(createdInvoice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BillingStateImplCopyWith<$Res>
    implements $BillingStateCopyWith<$Res> {
  factory _$$BillingStateImplCopyWith(
    _$BillingStateImpl value,
    $Res Function(_$BillingStateImpl) then,
  ) = __$$BillingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isProcessing,
    List<InvoiceEntity> invoices,
    String? clinicId,
    InvoiceEntity? activeInvoice,
    PaymentInstructions? activeInstructions,
    String? error,
    InvoiceEntity? createdInvoice,
    bool proofSubmitted,
  });

  @override
  $InvoiceEntityCopyWith<$Res>? get activeInvoice;
  @override
  $InvoiceEntityCopyWith<$Res>? get createdInvoice;
}

/// @nodoc
class __$$BillingStateImplCopyWithImpl<$Res>
    extends _$BillingStateCopyWithImpl<$Res, _$BillingStateImpl>
    implements _$$BillingStateImplCopyWith<$Res> {
  __$$BillingStateImplCopyWithImpl(
    _$BillingStateImpl _value,
    $Res Function(_$BillingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isProcessing = null,
    Object? invoices = null,
    Object? clinicId = freezed,
    Object? activeInvoice = freezed,
    Object? activeInstructions = freezed,
    Object? error = freezed,
    Object? createdInvoice = freezed,
    Object? proofSubmitted = null,
  }) {
    return _then(
      _$BillingStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isProcessing: null == isProcessing
            ? _value.isProcessing
            : isProcessing // ignore: cast_nullable_to_non_nullable
                  as bool,
        invoices: null == invoices
            ? _value._invoices
            : invoices // ignore: cast_nullable_to_non_nullable
                  as List<InvoiceEntity>,
        clinicId: freezed == clinicId
            ? _value.clinicId
            : clinicId // ignore: cast_nullable_to_non_nullable
                  as String?,
        activeInvoice: freezed == activeInvoice
            ? _value.activeInvoice
            : activeInvoice // ignore: cast_nullable_to_non_nullable
                  as InvoiceEntity?,
        activeInstructions: freezed == activeInstructions
            ? _value.activeInstructions
            : activeInstructions // ignore: cast_nullable_to_non_nullable
                  as PaymentInstructions?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdInvoice: freezed == createdInvoice
            ? _value.createdInvoice
            : createdInvoice // ignore: cast_nullable_to_non_nullable
                  as InvoiceEntity?,
        proofSubmitted: null == proofSubmitted
            ? _value.proofSubmitted
            : proofSubmitted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$BillingStateImpl extends _BillingState {
  const _$BillingStateImpl({
    this.isLoading = false,
    this.isProcessing = false,
    final List<InvoiceEntity> invoices = const [],
    this.clinicId,
    this.activeInvoice,
    this.activeInstructions,
    this.error,
    this.createdInvoice,
    this.proofSubmitted = false,
  }) : _invoices = invoices,
       super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isProcessing;
  final List<InvoiceEntity> _invoices;
  @override
  @JsonKey()
  List<InvoiceEntity> get invoices {
    if (_invoices is EqualUnmodifiableListView) return _invoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_invoices);
  }

  @override
  final String? clinicId;
  @override
  final InvoiceEntity? activeInvoice;
  @override
  final PaymentInstructions? activeInstructions;
  @override
  final String? error;
  // One-shot flags consumed by the UI in BlocListener.
  @override
  final InvoiceEntity? createdInvoice;
  @override
  @JsonKey()
  final bool proofSubmitted;

  @override
  String toString() {
    return 'BillingState(isLoading: $isLoading, isProcessing: $isProcessing, invoices: $invoices, clinicId: $clinicId, activeInvoice: $activeInvoice, activeInstructions: $activeInstructions, error: $error, createdInvoice: $createdInvoice, proofSubmitted: $proofSubmitted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isProcessing, isProcessing) ||
                other.isProcessing == isProcessing) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices) &&
            (identical(other.clinicId, clinicId) ||
                other.clinicId == clinicId) &&
            (identical(other.activeInvoice, activeInvoice) ||
                other.activeInvoice == activeInvoice) &&
            (identical(other.activeInstructions, activeInstructions) ||
                other.activeInstructions == activeInstructions) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.createdInvoice, createdInvoice) ||
                other.createdInvoice == createdInvoice) &&
            (identical(other.proofSubmitted, proofSubmitted) ||
                other.proofSubmitted == proofSubmitted));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isProcessing,
    const DeepCollectionEquality().hash(_invoices),
    clinicId,
    activeInvoice,
    activeInstructions,
    error,
    createdInvoice,
    proofSubmitted,
  );

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BillingStateImplCopyWith<_$BillingStateImpl> get copyWith =>
      __$$BillingStateImplCopyWithImpl<_$BillingStateImpl>(this, _$identity);
}

abstract class _BillingState extends BillingState {
  const factory _BillingState({
    final bool isLoading,
    final bool isProcessing,
    final List<InvoiceEntity> invoices,
    final String? clinicId,
    final InvoiceEntity? activeInvoice,
    final PaymentInstructions? activeInstructions,
    final String? error,
    final InvoiceEntity? createdInvoice,
    final bool proofSubmitted,
  }) = _$BillingStateImpl;
  const _BillingState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isProcessing;
  @override
  List<InvoiceEntity> get invoices;
  @override
  String? get clinicId;
  @override
  InvoiceEntity? get activeInvoice;
  @override
  PaymentInstructions? get activeInstructions;
  @override
  String? get error; // One-shot flags consumed by the UI in BlocListener.
  @override
  InvoiceEntity? get createdInvoice;
  @override
  bool get proofSubmitted;

  /// Create a copy of BillingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BillingStateImplCopyWith<_$BillingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
