# Billing & subscription — backend API contract

This is the contract the Flutter app expects from the backend. Routes are
grouped by surface and tagged with the dentist-app code path that calls
them, so the backend team can match request/response shapes to the
existing models without re-deriving them.

> **Auth model.** All routes assume the dentist's bearer token is sent in
> the `Authorization` header. Admin routes additionally require an admin
> role claim — the dentist app **never** calls the admin routes; they
> are listed here so the admin tool / backoffice has a target.

> **App Store note.** Per Apple/Google policy we do not initiate digital
> payments from the app for IAP-eligible content. The dentist app only
> *displays* invoice info and uploads proof — money movement happens
> outside the app, and admin verification flips the invoice to paid.

---

## 1. Subscription plans

### `GET /subscription-plans`

List the plans available to a clinic. Maps to
`SubscriptionRepository.getPlans()` → `SubscriptionPlanEntity`.

**Response 200**

```json
{
  "data": [
    {
      "id": "solo",
      "tier": "solo",
      "name": "Solo",
      "description": "For a single dentist starting out",
      "monthly_price": 7,
      "yearly_price": 70,
      "max_dentists": 1,
      "max_assistants": 1,
      "max_branches": 1,
      "features": ["1 dentist", "1 assistant", "..."],
      "limitations": [],
      "is_popular": false,
      "is_active": true
    }
  ]
}
```

`tier` is the canonical enum: `trial | solo | duo | clinic | practice |
custom`. The Custom plan should return `monthly_price: 0`,
`yearly_price: 0`; the app branches on that.

---

## 2. Current subscription

### `GET /clinics/{clinicId}/subscription`

Returns the clinic's current subscription record.

**Response 200**

```json
{
  "data": {
    "id": "sub_...",
    "user_id": "clinic_...",
    "plan_tier": "clinic",
    "status": "active",
    "billing_cycle": "monthly",
    "start_date": "2026-04-01T00:00:00Z",
    "current_period_end": "2026-05-01T00:00:00Z",
    "trial_end_date": null,
    "cancelled_at": null,
    "auto_renew": false,
    "payment_method_id": null,
    "last_payment_id": "inv_...",
    "last_payment_date": "2026-04-01T00:00:00Z",
    "last_payment_amount": 24,
    "current_dentist_count": 2,
    "current_assistant_count": 3,
    "current_branch_count": 1,
    "current_patient_count": 312
  }
}
```

`status` enum: `trial | active | pastDue | cancelled | expired | none`.

### `POST /clinics/{clinicId}/subscription/start-trial`

Starts a 30-day trial. Body empty. Returns the new subscription as
above.

### `POST /clinics/{clinicId}/subscription/cancel`

Marks the subscription `cancelled` (still active until period end).

### `POST /clinics/{clinicId}/subscription/reactivate`

Reverses a cancellation if still inside the period.

---

## 3. Invoices (dentist-side)

### `GET /clinics/{clinicId}/invoices`

List invoices for the clinic, newest first. Powers the billing list
page.

**Response 200**

```json
{
  "data": [
    {
      "id": "inv_...",
      "number": "INV-202605-A1B2C3",
      "clinic_id": "clinic_...",
      "kind": "subscription",
      "status": "pending",
      "provider": "manual",
      "amount": 24,
      "currency": "USD",
      "issued_at": "2026-05-09T19:00:00Z",
      "due_at": "2026-05-16T19:00:00Z",
      "plan_tier": "clinic",
      "billing_cycle": "monthly",
      "proof": null,
      "rejection": null,
      "paid_at": null,
      "activates_until": "2026-06-08T19:00:00Z",
      "is_renewal": false,
      "notes": null
    }
  ]
}
```

Status enum: `pending | underReview | paid | rejected | cancelled`.
Provider enum: `manual` (more values land when Stripe etc. are added —
the app already has the `PaymentProviderKind` enum to receive them).

### `POST /clinics/{clinicId}/invoices`

Create a new pending invoice. Backend mints `number`, `issued_at`,
`due_at`, computes `amount` from `plan_tier × billing_cycle`, and sets
`activates_until`.

**Request**

```json
{
  "plan_tier": "clinic",
  "billing_cycle": "monthly",
  "is_renewal": false
}
```

**Response 201** — the full invoice object (same shape as list).

### `GET /invoices/{invoiceId}`

Single invoice. Same shape.

### `GET /invoices/{invoiceId}/payment-instructions`

Returns the channel list the dentist should use to pay. Maps to
`PaymentInstructions`.

```json
{
  "data": {
    "provider_kind": "manual",
    "reference_number": "INV-202605-A1B2C3",
    "amount": 24,
    "currency": "USD",
    "channels": [
      {
        "method": "syriatelCash",
        "account": "0987 654 321",
        "holder_name": "Dental Clinic App",
        "note": null
      }
    ]
  }
}
```

`method` enum: `cash | syriatelCash | shamCash | bankTransfer`.

> The channel data should come from a remote config / admin-managed
> settings table so account numbers and wallet IDs can be rotated
> without a client release.

### `POST /invoices/{invoiceId}/proof`

Submit payment proof. Multipart body:

| field              | type      | required | notes                              |
|--------------------|-----------|----------|------------------------------------|
| `receipt`          | file      | yes      | image (jpg/png/heic) or pdf        |
| `reference_number` | string    | yes      | dentist-entered txn / wire ref     |
| `method`           | enum      | yes      | one of the manual methods above    |
| `notes`            | string    | no       | freeform                           |

Backend behavior:

- Validates the invoice exists and belongs to the clinic.
- Rejects unless current status is `pending`.
- Stores the receipt in the media service and links it.
- Flips status to `underReview`.
- Pushes the new state on the realtime channel (see §5).

**Response 200** — updated invoice object.

### `POST /invoices/{invoiceId}/cancel`

Dentist-initiated cancel of a `pending` invoice. Not exposed in the
current UI but the route is reserved.

---

## 4. Admin verification

> **Admin only.** The dentist app does not call these. They exist for
> the admin web/back-office tool; the dentist learns about the result
> via the realtime channel.

### `POST /admin/invoices/{invoiceId}/approve`

Body empty. Backend:

- Asserts current status is `underReview` (or, with admin override,
  `pending`).
- Sets `status = paid`, `paid_at = now`.
- Activates / extends the clinic subscription using the invoice's
  `plan_tier`, `billing_cycle`, and `activates_until`. If the clinic
  already has an active subscription, *extend* `current_period_end`
  rather than overwriting.
- Pushes the new state on both the invoice and subscription channels.

### `POST /admin/invoices/{invoiceId}/reject`

```json
{ "reason": "Receipt amount does not match the invoice." }
```

`reason` is optional. Backend flips to `status = rejected`,
`rejection.reason = ...`, pushes update.

---

## 5. Realtime updates

The dentist app already listens on a stream that emits invoice mutations
(`BillingRepository.watchChanges()`). Backend should provide one of:

- **Firestore listener** *(recommended for fastest path)* — model
  `clinics/{clinicId}/invoices/{id}` documents and let the SDK push
  updates. Status flips on the server (admin actions, payment webhooks)
  show up on the dentist's screen with no polling.
- **WebSocket / SSE** — a per-clinic channel that emits
  `{ type: "invoice.updated", invoice: { ... } }` events.
- **Polling fallback** — if neither of the above is available, the
  client can fall back to a 30s `GET /clinics/{clinicId}/invoices`
  refresh. We'll only do this if you need to ship without realtime
  infra.

The same channel should also push subscription state changes
(`subscription.updated`) so the read-only-mode banner flips off the
moment an admin approves an invoice.

---

## 6. Notifications (out of scope here, but related)

When an invoice transitions, fire push notifications:

| event                    | recipient        | message (en)                                              |
|--------------------------|------------------|-----------------------------------------------------------|
| invoice created          | dentist          | "Invoice {number} ready — pay and upload your receipt."   |
| invoice under review     | admin            | "{clinic} submitted a receipt for {number}."              |
| invoice approved         | dentist          | "Invoice {number} approved. Subscription extended."       |
| invoice rejected         | dentist          | "Invoice {number} was rejected. Reason: {reason}."        |
| renewal approaching      | dentist          | "Your plan ends in {days} days. Generate a renewal now."  |

Renewal reminders should fire at T-7 and T-1 days before
`current_period_end`.

---

## 7. Field-level mapping cheat sheet

| Dart entity field                               | JSON key             |
|------------------------------------------------|----------------------|
| `InvoiceEntity.id`                             | `id`                 |
| `InvoiceEntity.number`                         | `number`             |
| `InvoiceEntity.clinicId`                       | `clinic_id`          |
| `InvoiceEntity.kind`                           | `kind`               |
| `InvoiceEntity.status`                         | `status`             |
| `InvoiceEntity.provider`                       | `provider`           |
| `InvoiceEntity.amount`                         | `amount`             |
| `InvoiceEntity.currency`                       | `currency`           |
| `InvoiceEntity.issuedAt`                       | `issued_at`          |
| `InvoiceEntity.dueAt`                          | `due_at`             |
| `InvoiceEntity.planTier`                       | `plan_tier`          |
| `InvoiceEntity.billingCycle`                   | `billing_cycle`      |
| `InvoiceEntity.proof.receiptPath`              | `proof.receipt_url`  |
| `InvoiceEntity.proof.referenceNumber`          | `proof.reference_number` |
| `InvoiceEntity.proof.methodUsed`               | `proof.method`       |
| `InvoiceEntity.proof.submittedAt`              | `proof.submitted_at` |
| `InvoiceEntity.proof.notes`                    | `proof.notes`        |
| `InvoiceEntity.rejection.rejectedAt`           | `rejection.rejected_at` |
| `InvoiceEntity.rejection.reason`               | `rejection.reason`   |
| `InvoiceEntity.paidAt`                         | `paid_at`            |
| `InvoiceEntity.activatesUntil`                 | `activates_until`    |
| `InvoiceEntity.isRenewal`                      | `is_renewal`         |

The repository layer already has `InvoiceModel.toEntity()`; once the
backend lands, swap `BillingLocalDataSource` for a remote
implementation that calls these endpoints and emits updates from the
realtime channel — nothing in the bloc/UI layer changes.
