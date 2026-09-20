# API Endpoints

Every HTTP endpoint the Denta client calls, grouped by module.

Extracted from the `*Endpoints` classes under `lib/features/*/data/endpoints/`
and `lib/services/`, cross-referenced against the actual `ApiConsumer` call
sites so each row shows the verb the app really sends.

- **Base URL** — `AppConfig.baseUrl`, read from `BASE_URL` in `.env`
  (production: `https://denta-backend.runbit.tech/api`).
- **Paths below are relative to that base**, so `/auth/login` is
  `…/api/auth/login`.
- **Total:** 98 distinct call sites across 15 endpoint classes.

## Headers on every request

Attached automatically by `AuthInterceptor` — no call site passes them by hand.

| Header | Value | Notes |
|---|---|---|
| `Authorization` | `Bearer <access token>` | Omitted when signed out. |
| `Accept-Language` | `ar` / `en` | Server returns translated labels and messages. |
| `X-Selected-Clinic-id` | active clinic uuid | Required by clinic-scoped routes, ignored elsewhere. |
| `X-Refresh-Token` | — | Response header, read during token refresh. |

A `401` triggers a single token refresh via `POST /auth/refresh` and a replay of
the original request. A `403` is passed straight through to the caller.

---

## Auth

| Method | Path | Purpose |
|---|---|---|
| POST | `/auth/login` | Sign in with email or mobile. |
| POST | `/auth/register` | Register user + clinic. |
| POST | `/auth/register/request-otp` | Request / resend registration OTP. |
| POST | `/auth/verify-otp` | Verify OTP, return session token. |
| POST | `/auth/refresh` | Exchange refresh token (called by the interceptor, not a data source). |
| POST | `/auth/logout` | End session, unregister device. Body: `{ token }` (optional FCM token). |
| POST | `/auth/reset-password/request-otp` | Request password-reset OTP. |
| POST | `/auth/reset-password` | Reset password with session id. |
| POST | `/auth/verify-email/request-otp` | Request email-verification OTP (authed). |
| POST | `/auth/verify-email` | Verify email with OTP (authed). |
| POST | `/auth/change-email/request-otp` | Request email-change OTP. |
| POST | `/auth/change-email` | Confirm email change with session id. |
| POST | `/auth/device-token` | Register push token. Body: `{ token, platform: ANDROID\|IOS }`. |
| GET | `/auth/account/deletion-preview` | What account deletion will remove, plus reason list. |
| POST | `/auth/account/delete` | Delete own account. POST not DELETE — the password travels in the body. |

### Reference data used by auth

| Method | Path | Purpose |
|---|---|---|
| GET | `/specialties` | Dental specialties. |
| GET | `/plans` | Subscription plans shown during signup. |
| GET | `/locations/search` | Location lookup. Query: `query`, `country_code`. |

---

## Patients

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/patients` | List patients (paged). |
| POST | `/clinics/patients` | Create patient. |
| GET | `/clinics/patients/{patientId}` | Patient details. |
| PUT | `/clinics/patients/{patientId}` | Update patient. |
| DELETE | `/clinics/patients/{patientId}/detach` | Detach patient from clinic. |
| GET | `/teeth` | Tooth reference set for the chart. |
| GET | `/core-treatments` | Treatment catalogue. |

### Cases

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/patients/{patientId}/cases` | List cases. |
| POST | `/clinics/patients/{patientId}/cases` | Create case. |
| PUT | `/clinics/patients/{patientId}/cases/{caseId}` | Update case. |
| PATCH | `/clinics/patients/{patientId}/cases/{caseId}/complete` | Mark case complete. |
| PATCH | `/clinics/patients/{patientId}/cases/{caseId}/reactivate` | Reopen a completed case. |
| PUT | `/clinics/patients/{patientId}/cases/{caseId}/costs` | Update total cost / lab fees. |

### Treatment plan items

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/patients/{patientId}/cases/{caseId}/treatment-plan-items` | List plan items. |
| POST | `/clinics/patients/{patientId}/cases/{caseId}/treatment-plan-items` | Add plan item. |
| PUT | `/clinics/patients/{patientId}/cases/{caseId}/treatment-plan-items/{itemId}` | Replace plan item. |
| PATCH | `/clinics/patients/{patientId}/cases/{caseId}/treatment-plan-items/{itemId}` | Toggle status. |
| DELETE | `/clinics/patients/{patientId}/cases/{caseId}/treatment-plan-items/{itemId}` | Remove plan item. |

### Payments

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/patients/{patientId}/cases/{caseId}/payments` | Payment history. |
| POST | `/clinics/patients/{patientId}/cases/{caseId}/payments` | Record payment. Body carries `currency_id`, `case_currency_id`, `amount_in_case_currency`, `exchange_rate`. |

### Case attachments

The parent case route rejects `PATCH` (405), so attachments are never written
through the case update.

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/patients/{patientId}/cases/{caseId}/attachments` | List attachments. |
| POST | `/clinics/patients/{patientId}/cases/{caseId}/attachments` | Attach uploaded media ids. |
| DELETE | `/clinics/patients/{patientId}/cases/{caseId}/attachments/{attachmentId}` | Detach one. |

---

## Appointments

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/appointments` | List appointments for a day or week. |
| POST | `/clinics/appointments` | Create appointment. |
| PATCH | `/clinics/appointments/{id}/status` | Change status (also used for cancellation). |
| GET | `/clinics/appointment-available-slots` | Free slots for a doctor / date / duration. |
| GET | `/clinics/clinic-doctors` | Doctors bookable in this clinic. |

---

## Expenses

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/expenses` | List expenses for a month. |
| POST | `/clinics/expenses` | Create expense. |
| PUT | `/clinics/expenses/{id}` | Update expense. |
| DELETE | `/clinics/expenses/{id}` | Delete expense. |
| GET | `/clinics/expenses/categories` | Expense categories. |

---

## Clinic (members & invitations)

| Method | Path | Purpose |
|---|---|---|
| GET | `/users/clinics` | Clinics the signed-in user belongs to. |
| GET | `/clinics/users` | Members of the active clinic. |
| POST | `/clinics/users` | Add a member. |
| DELETE | `/clinics/users/{userId}` | Remove a member. |
| POST | `/clinics/users/{userId}/roles` | Set a member's roles. |
| GET | `/clinics/users/invitations/received` | Invitations received. |
| GET | `/clinics/users/invitations/sent` | Invitations sent. |
| POST | `/clinics/users/invitations/send` | Send an invitation. |
| PUT | `/clinics/users/invitations/{id}/accept` | Accept an invitation. |
| PUT | `/clinics/users/invitations/{id}/decline` | Decline an invitation. |

---

## Clinic info & working hours

| Method | Path | Purpose |
|---|---|---|
| PUT | `/clinics` | Update clinic profile. |
| GET | `/clinics/working-days` | Clinic working days. |
| POST | `/clinics/working-days/upsert` | Replace working days. |
| GET | `/clinics/holidays` | Clinic holidays. |
| POST | `/clinics/holidays/upsert` | Replace holidays. |
| GET | `/clinics/users/my-hours` | Current user's hours (derived from token + clinic header). |
| GET | `/clinics/users/{userId}/hours` | A member's hours. |
| POST | `/clinics/users/{userId}/hours` | Set a member's hours. |

---

## Profile

| Method | Path | Purpose |
|---|---|---|
| GET | `/auth/profile` | Signed-in user's profile. |
| POST | `/auth/update-profile` | Update profile. |
| GET | `/specialties` | Specialties for the profile form. |
| POST | `/users/update-current-language` | Persist the user's language choice. |

---

## Notifications

| Method | Path | Purpose |
|---|---|---|
| GET | `/notifications` | Inbox, cursor-paged via `?limit=&before=`. |
| GET | `/notifications/unread-count` | Badge count. |
| POST | `/notifications/{id}/read` | Mark read (implicitly seen). No body. |
| POST | `/notifications/{id}/unread` | Mark unread again; stays seen. No body. |
| POST | `/notifications/read-all` | Mark everything read. No body. |
| GET | `/notifications/unseen` | **Windows only** — never-announced notifications, for the polling path. |
| POST | `/notifications/seen` | **Windows only** — acknowledge shown ones. Body: `{ ids: [...] }` (1–200). |

Device-token registration lives on the auth API — see `POST /auth/device-token`.

---

## Notification settings

| Method | Path | Purpose |
|---|---|---|
| GET | `/notification-settings` | Keys, labels, descriptions, order, broadcast `audience` topic. |
| PATCH | `/notification-settings` | One switch. Body: `{ category, enabled }`. Validation errors return **400**, not 422. |

---

## Statistics

| Method | Path | Purpose |
|---|---|---|
| GET | `/clinics/statistics` | Catalogue of available metrics + filter specs. |
| GET | `/clinics/statistics/fetch` | Metric data. Query: `metrics=key1,key2&start_date=…`. |

---

## Subscription

| Method | Path | Purpose |
|---|---|---|
| GET | `/subscriptions/status` | Current plan, trial / grace flags, expiry. |
| GET | `/subscriptions/usage` | Per-resource usage against plan limits. |

---

## Support tickets (Report an Issue)

| Method | Path | Purpose |
|---|---|---|
| GET | `/tickets` | Caller's own reports, paged, `updated_at` descending. |
| POST | `/tickets` | File a report. Requires `X-Selected-Clinic-id`. |
| GET | `/tickets/categories` | `{value, label}` pairs, pre-translated. |
| GET | `/tickets/statuses` | `{value, label}` pairs, pre-translated. |

---

## Media

| Method | Path | Purpose |
|---|---|---|
| POST | `/media-items` | Upload a file, returns a media id. |
| PUT | `/media-items/{id}/update-filename` | Rename an uploaded file. |

---

## Shared services

| Method | Path | Purpose |
|---|---|---|
| GET | `/currencies` | Currency list for pricing and payments. |
| GET | `/features/clinic-permissions` | Permission slugs granted in the active clinic. |
| GET | `/app/version-check` | Startup version gate. Query: `platform`, `version`. Deliberately public — a forced update must work with an expired token. |

---

## Defined but never called

These constants exist in the endpoint classes and are not referenced by any
call site. Either the feature was dropped or the route moved — worth confirming
against the backend before relying on them.

| Constant | Path | Note |
|---|---|---|
| `ClinicInfoEndpoints.clinicInfo` | `/clinic-info` | Clinic info is read from `/users/clinics` instead. |
| `EditProfileEndpoints.profile` | `/profile` | Superseded — the data source calls `/auth/profile` inline. |
| `EditProfileEndpoints.updateProfile` | `/profile` | Superseded by `/auth/update-profile`. |
| `SubscriptionEndpoints.plans` | `/subscription/plans` | Signup uses `/plans`; billing has no API layer yet. |
| `SubscriptionEndpoints.subscribe` | `/subscription/subscribe` | Unused. |
| `SubscriptionEndpoints.cancel` | `/subscription/cancel` | Unused. |
| `SubscriptionEndpoints.subscription` | `/subscription/{userId}` | Unused. |
| `PatientEndpoints.activeCase` | `/patients/{patientId}/cases/active` | Call site is commented out; note it lacks the `/clinics` prefix the other case routes use. |

### Inconsistencies worth a look

- **Profile routes bypass their endpoint class.** `edit_profile_remote_data_source.dart`
  hardcodes `/auth/profile` and `/auth/update-profile` while
  `EditProfileEndpoints` still declares `/profile`. One of the two is wrong.
- **Subscription paths are split** between `/subscription/*` (all unused) and
  `/subscriptions/*` (the two that are live). Singular vs plural is not a typo
  in the live calls, but the dead constants suggest the API changed under them.
- **Billing has no data layer.** `lib/features/billing/` renders plan selection,
  invoices and payment-proof screens with no `ApiConsumer` calls behind them, so
  those screens are not yet wired to the backend.
