# Denta — Pricing & Packaging Discussion Prompt

> Paste everything below the line into ChatGPT / Claude / any web AI to give it full
> context on the product, roles, seat limits, plans and billing before discussing pricing.

---

You are acting as a **SaaS pricing & packaging strategist** for a dental-clinic management
product. Read the full context below, then help me design the pricing and packaging.
Do not invent features that are not listed. Where the context is contradictory or missing,
call it out explicitly and ask me before assuming.

## 1. Product

**Denta** — a mobile-first dental clinic management app (Flutter, Android + iOS).
Bilingual English / Arabic with full RTL support, light + dark theme.
Sold B2B to dental clinics; the buyer is the clinic owner (a dentist).

Primary market: **Syria** (and nearby MENA). Prices are quoted in **USD**, but payment
happens **off-app** through local rails — there is no card gateway yet.

## 2. Account model

- A **user** signs up with email + OTP verification, then either creates a clinic or is
  invited to one.
- A user can belong to **multiple clinics** ("My Clinics"); they switch the active clinic
  inside the app. Everything (patients, appointments, expenses, stats, billing) is scoped
  to the currently selected clinic.
- The **subscription belongs to the clinic account**, not to the individual user.
- Staff join a clinic through an **invitation flow** (send invitation → invitee accepts /
  rejects; there are "sent" and "received" invitation lists).

## 3. Roles (this is the core of the seat model)

Roles that exist in the domain model: `ADMIN`, `DENTIST`, `SECRETARY`, plus a legacy
`RECEPTIONIST`. The invite UI currently offers only **ADMIN, DENTIST, SECRETARY**.
A member can hold **multiple roles at once** (roles are a list, e.g. ADMIN + DENTIST —
which is the normal case for a solo owner-dentist).

Permission matrix as implemented today:

| Capability | Admin | Dentist | Secretary / Receptionist |
|---|---|---|---|
| Manage staff (invite / remove / change roles) | yes | no | no |
| View / edit clinic settings & clinic info | yes | no | no |
| Approve requests (e.g. patient-deletion requests) | yes | no | no |
| View clinic statistics / reports | yes | no | no |
| View patients | yes | yes | yes |
| Add / edit patients | yes | yes | yes |
| Delete a patient directly | yes | no — must request approval | no — must request approval |
| View / create / cancel appointments | yes | yes | yes |
| Leave the clinic | no (owner must transfer) | yes | yes |

The clinic **owner** flag is separate: owners cannot be removed by other admins.

## 4. Seat limits — how plans actually constrain the product

Every plan carries hard caps:

- `max_dentists` — how many DENTIST seats
- `max_assistants` / secretaries — how many SECRETARY seats
- `max_branches` — how many branch locations
- `max_storage_mb` — media storage (x-rays, intra-oral photos, case attachments)

**Enforcement in the app today:**

- The "Add clinic user" screen loads live usage and **greys out the DENTIST role chip when
  the dentist limit is reached**, and the **SECRETARY chip when the secretary limit is
  reached**. If both are maxed, the whole invite entry point is blocked with an
  "upgrade your plan" note.
- So, concretely: on a 1-dentist plan you **cannot have a second dentist in the account**.
  You can still add secretaries up to their own cap.
- ADMIN is *not* seat-limited today (an admin who is not also a dentist consumes no seat).
- Storage is displayed as a usage bar but is **not hard-blocked** anywhere in the UI yet.
- Branch caps exist in the plan data but **nothing in the app enforces or even shows them**.
- **Feature flags are not enforced.** Marketing bullets like "Statistics & analytics
  dashboard" or "SMS reminders" are copy only — the app gates statistics on the *admin
  role*, not on the plan tier. Only **seat caps** and **subscription expiry** are enforced.

## 5. Current plan catalog (hardcoded in the app UI today)

Yearly price = monthly × 10, i.e. **2 months free (~17% off)**.

| Plan | Monthly | Yearly | Dentists | Assistants/Secretaries | Branches | Notes |
|---|---|---|---|---|---|---|
| **Solo** | $7 | $70 | 1 | 1 | 1 | "For a single dentist starting out" |
| **Duo** | $12 | $120 | 2 | 2 | 1 | Adds statistics dashboard, email + SMS reminders, priority email support |
| **Clinic** | $24 | $240 | 4 | 6 | 1 | Marked **Most popular**; advanced reports, invoice branding, live chat support |
| **Practice** | $49 | $490 | 8 | unlimited (999) | 3 | Cross-location analytics, phone support, priority training |
| **Custom** | contact sales | — | unlimited | unlimited | unlimited | 10+ dentists, custom integrations, dedicated AM, SLA, on-site training |

Feature bullets currently advertised (cumulative up the ladder):
unlimited patients · appointment scheduling · treatment plans & records · invoice
generation · x-ray & photo storage · cloud sync & backup · email support · statistics &
analytics dashboard · email & SMS reminders · advanced reports · invoice branding ·
live chat support · cross-location analytics · phone support · training.

**Free trial:** 30 days, granted at **Clinic-tier** capability. Trial does not require a
card (there is no card flow at all).

## 6. Backend API contracts (what the server actually returns)

There are **two parallel plan representations** in the codebase — a known inconsistency
worth resolving as part of the pricing decision:

**(a) `GET /plans`** — used by the signup "Choose plan" screen. Real API. Shape:

```
id, version_id, name, description,
price_monthly: [{ amount, currency, display }, ...],   // multi-currency array
price_yearly:  [{ amount, currency, display }, ...],
supports_trial: bool, trial_period_days: int, grace_period_days: int,
clinic_type: string, type: string, sort_order: int
```

Note: **no seat limits in this payload** — no max_dentists / max_secretaries / storage.
Trial length and grace-period length are **per plan**, server-driven.

**(b) hardcoded plan constants in the app** — used by the billing "Select plan" screen and
the invoice flow. This is where the prices and seat caps in §5 live. A
`GET /subscription/plans` endpoint exists, but its data source is still **mocked** and just
returns these hardcoded constants.

**`GET /subscriptions/status`**:

```
status: "ACTIVE" | "TRIALING" | ..., plan: { name },
is_expired, is_in_grace_period, remaining_days,
starts_at, subscription_ends, grace_ends_at, billing_period
```

Lifecycle states the app renders: **trial → active → grace period → expired**
(plus past-due / cancelled / none in the domain model).

**`GET /subscriptions/usage`** — flat `max_*` / `current_*` pairs, `-1` (or null) means
unlimited:

```
{ "max_dentists": 1, "current_dentists": 1,
  "max_secretaries": 1, "current_secretaries": 0,
  "max_storage_mb": 1024, "current_storage_mb": 0, ... }
```

The app reads the keys **`dentists`**, **`secretaries`**, **`storage`** (from
`*_storage_mb`). Note the naming mismatch: plans say *assistants*, usage says *secretaries*.

Other subscription endpoints defined: `/subscription/subscribe`, `/subscription/cancel`,
`/subscription/{userId}`.

## 7. Billing & payment flow (manual, no gateway)

1. Clinic admin picks a plan + billing cycle (monthly / yearly) → **an invoice is generated**.
2. They pay **outside the app** via one of: **Cash, Syriatel Cash, Sham Cash, Bank transfer.**
3. They upload a **receipt screenshot + reference number** as payment proof.
4. Our admin **manually verifies** it and approves or rejects.
5. On approval the subscription activates / extends.

Invoice lifecycle: `pending → under_review → paid | rejected | cancelled`.
Provider is `manual` only; Stripe is a placeholder for later.
The invoice model already anticipates non-subscription charges (SMS top-ups, branded
reports) via an invoice-kind field, but only `subscription` exists today.
The "Custom" plan CTA currently routes to the generic "Report an issue" form — there is
no real contact-sales flow.

## 8. Expiry behaviour

A process-wide **subscription guard** decides whether write actions are allowed. When the
subscription is expired the app flips to **read-only**: write actions raise a
"subscription expired" dialog with a "Renew now" CTA into billing. Near-expiry (7 days or
less) and grace-period banners appear on the home screen and the billing screen.

## 9. Full feature inventory (what a clinic actually gets)

**Patients:** patient list & search, add / edit patient, patient details, detach patient,
delete with admin-approval workflow.

**Clinical:** full teeth chart (server-driven teeth catalog), core-treatments catalog,
treatment planning (plan → add treatments → view plan), case completion, per-case
**attachments** (x-ray / photo upload, listed and managed as a sub-resource).

**Payments:** per-patient payment recording and payment history.

**Appointments:** appointment list, create appointment, **available-slot lookup**,
per-doctor booking, appointment status updates.

**Expenses:** clinic expense tracking with categories, monthly view.

**Statistics:** server-driven metric catalog — the backend defines which metrics exist and
how each renders. Supported chart types: KPI card, KPI + list, donut, pie, bar, horizontal
bar, area, dual-line, heatmap, **dental-chart heatmap**, demographics breakdown; with date
and numeric filters per metric. Admin-only today.

**Clinic management:** create clinic, multi-clinic switching, staff roster, invitations
(send / receive / respond), role updates, member removal, pending-approvals queue, clinic
info editing.

**Notifications:** in-app notification centre (list, unseen, mark seen, unread count,
read-all), **FCM push** with server-owned topics, per-category notification settings.

**Account:** email OTP signup & verification, login, password reset, change email, profile
editing, report an issue.

**Platform:** Arabic / English with RTL, dark mode, cloud sync.

## 10. Known gaps & open questions (please factor these in)

1. Two conflicting plan sources (`GET /plans` vs hardcoded constants) — which becomes the
   source of truth, and do seat caps move into the API payload?
2. `Practice` is documented as "up to 10 dentists" but coded as **8**; `Custom` advertises
   "10+ dentists". The ladder has a hole between 8 and Custom.
3. Assistants vs secretaries naming mismatch between plans and the usage API.
4. Branch caps are sold but never enforced or displayed.
5. Feature bullets (statistics, SMS reminders, advanced reports, invoice branding) are
   **not gated by plan** — do we build real feature flags, or drop them from the pricing
   page and price purely on seats + storage?
6. Storage caps are shown but not enforced. X-ray / photo storage is the most obvious
   variable cost — should it be a paid add-on or an overage charge?
7. ADMIN seats are free and unlimited — is that exploitable (e.g. someone who treats
   patients but is only ever marked ADMIN)?
8. No card gateway: every upgrade is a manual invoice + human verification. That caps how
   granular / self-serve pricing can be, and makes monthly churn expensive to administer.
9. Trial is 30 days at Clinic tier with no card — generous. The server supports per-plan
   trial and grace-period lengths.

## 11. What I want from you

Discuss and pressure-test the pricing with me:

- Is the **seat-based** model (dentist seats as the primary meter) the right value metric
  for this product and this market, or should it be patients / appointments / storage?
- Are the **price points** ($7 / $12 / $24 / $49) and the gaps between tiers right for the
  Syrian / MENA market, given manual off-app payment and USD quoting?
- Is the **tier count** (4 + custom) right, or should it collapse to 2–3?
- Which capabilities genuinely justify **gating by tier** versus being included everywhere?
- How should the **secretary / assistant** cap relate to the dentist cap — fixed ratio,
  free and unlimited, or separately priced?
- Should there be **per-seat add-ons** ("+1 dentist for $X/mo") instead of, or alongside,
  fixed tiers?
- How to handle **branches / multi-location**, and whether that is a tier or an add-on.
- **Yearly discount**: is 2 months free right, given manual collection makes annual
  strongly preferable operationally?
- Trial length and grace-period policy.
- A concrete migration / comms plan if we change prices for existing clinics.

Start by summarising back what you understand the product and the current model to be,
flag anything in the context that looks internally inconsistent, then ask me the 3–5
questions you most need answered before recommending a price structure.
