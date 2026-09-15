# Backend contract — three endpoints the app now calls

Written for the backend team. The Flutter client for all three is already
merged and calls these routes today; until they exist the app degrades on
purpose (see **Behaviour before the route exists** under each one), so this can
ship in any order.

Conventions follow the rest of the API: JSON envelope
`{ "result": "success" | "error", "message": "...", "data": {...} }`, bearer
token in `Authorization`, `error_list` for field errors. Every clinic-scoped
aggregate must be scoped to the caller's **active clinic membership** and never
to a clinic id sent by the client.

---

## 1. `GET /clinics/home-summary`

Feeds the three-card carousel at the top of Home (patient count, revenue in
USD, revenue in SYP). Replaces the two-request dance the screen used to do
against `/clinics/statistics` + `/clinics/statistics/fetch`.

**Auth.** Required.

**Query params**

| Param | Type | Required | Notes |
|---|---|---|---|
| `start_date` | `YYYY-MM-DD` | yes | Inclusive. The app sends the first of the current month. |
| `end_date` | `YYYY-MM-DD` | yes | Inclusive. The app sends today. |

**Response 200**

```json
{
  "result": "success",
  "data": {
    "patients": {
      "total": 248,
      "new_in_period": 12,
      "change_percentage": 6.5,
      "recent_daily": [1, 0, 3, 2, 5, 4, 2]
    },
    "revenues": [
      {
        "currency_code": "USD",
        "total": 4180.50,
        "change_percentage": 14.2,
        "recent_daily": [120, 0, 340, 275, 500, 410, 260]
      },
      {
        "currency_code": "SYP",
        "total": 12500000,
        "change_percentage": -3.1,
        "recent_daily": [1200000, 0, 3400000, 2750000, 0, 4100000, 1050000]
      }
    ]
  }
}
```

**Field rules**

| Field | Rule |
|---|---|
| `patients.total` | All patients at the clinic, not only those added in the period. This is the headline number on the card. |
| `patients.new_in_period` | Patients added between `start_date` and `end_date`. Optional — omit it and the card shows the total alone. |
| `patients.recent_daily` | New patients per day for the **last 7 days ending on `end_date`**, oldest first. Always 7 entries, zeros included; a missing day is not the same as a zero day and the bars are drawn per day. |
| `revenues[]` | **One entry per currency the clinic actually bills in.** Do not merge currencies and do not convert between them — the app deliberately never adds these together. Order matters: the app renders the cards in the order sent, so put the currency the clinic prices in first. |
| `revenues[].total` | Money **collected** in the period, in that currency. Not invoiced, not outstanding — the app's own copy calls this "Total revenue · this month" and outstanding balances would read as income. |
| `revenues[].recent_daily` | Same rule as `patients.recent_daily`, in that currency. |
| `change_percentage` | Movement against the immediately preceding period of the same length. Optional. |

Numbers may be sent as JSON numbers or as decimal strings; the client parses
both. `recent_daily` may be omitted or `[]`, and the trend bars then render
flat rather than inventing a shape.

**Permissions.** A role that may not see clinic money (secretary) gets the
same 200 with `revenues` **omitted or empty** — not a 403. The app renders
whatever cards are in the response, so an omitted `revenues` naturally
produces a patients-only carousel. Returning 403 for the whole route would
also remove the patient count, which that role *is* allowed to see.

**Empty clinic.** A clinic with no patients and no takings still answers 200
with zeros. Zero is a fact about the month; a missing card reads to the owner
as a broken app.

**Behaviour before the route exists.** A `404` (or `501`) makes the client fall
back to the old statistics-catalog lookup and show a single revenue card, as
Home did before. Any other status shows no carousel at all. So please answer
404 rather than 200-with-an-error-body while this is unbuilt.

---

## 2. `DELETE /auth/account`

In-app account deletion. Required by **Apple guideline 5.1.1(v)** and **Google
Play's Data deletion policy** — a link to the web form is no longer sufficient
for either store, which is why this is a real call.

**Auth.** Required. The account deleted is always the token's own; there is no
id in the request, so there is nothing for a client to get wrong or to tamper
with.

**Body.** None. The client's confirmation (typing `DELETE`) is a UI gate, not a
credential — do not require it in the payload.

**Semantics — 30-day soft delete.**

1. Mark the user deleted **now**: sessions revoked, tokens invalidated, push
   device tokens unregistered, the account excluded from every listing,
   search, invitation and clinic-member view.
2. Schedule the hard purge for `now + 30 days` and return that timestamp.
3. **Signing in during the window cancels the deletion** and fully restores the
   account. This is the whole reason the client's confirmation is only a typed
   word: the recovery window, not the confirmation, is what protects a user
   whose phone was picked up by someone else.
4. After the window, purge for good: the user, the clinics they solely own,
   and those clinics' patients, appointments, treatments, invoices, payments
   and uploaded files.

**Response 200**

```json
{
  "result": "success",
  "message": "Account scheduled for deletion",
  "data": {
    "deletion_scheduled_at": "2026-09-09T12:00:00Z",
    "purge_at": "2026-10-09T12:00:00Z",
    "recovery_days": 30
  }
}
```

`purge_at` and `recovery_days` are both optional — the client falls back to
generic wording without them — but `purge_at` is what lets the confirmation
name the exact date the user has until, so please send it.

**Response 409 — the one refusal the client renders verbatim**

When the caller is the **only owner of a clinic that still has other members**,
refuse. Deleting them would strand a working clinic with no one who can
administer it.

```json
{
  "result": "error",
  "code": "sole_clinic_owner",
  "message": "You are the only owner of Smile Clinic. Transfer ownership to another member before deleting your account."
}
```

The client shows `message` **as written**, in place, above the confirm button.
So the sentence must name the clinic and say what to do about it — a generic
"conflict" leaves the user with no way forward. (The app's `NetworkExceptions`
was changed in this same branch to carry the 409 message for exactly this.)

A sole owner of a clinic with **no other members** is not blocked: they and
their clinic go together.

**Other statuses.** `401` if the token is dead — the client treats that as a
normal forced sign-out.

**Behaviour before the route exists.** The screen is reachable and the button
shows the failure returned; there is no fallback path, so this one is the
blocker for the store submission.

---

## 3. `GET /app/version`

The startup version check. Drives both the dismissible "update available"
sheet and the non-dismissible force-update screen.

**Auth.** **Public — no bearer token.** A forced update has to be able to stop
a user sitting on the login page with an expired token, which a route behind
auth could not do.

**Query params**

| Param | Type | Required | Notes |
|---|---|---|---|
| `platform` | `android` \| `ios` | yes | The client sends nothing on other platforms — it does not call the route at all. |
| `version` | string | yes | The running build's version name, e.g. `1.0.1`. |
| `build` | string | yes | The running build number, e.g. `1`. Sent as a string; it is not numeric on every platform. |

**Response 200**

```json
{
  "result": "success",
  "data": {
    "update": "none",
    "latest_version": "1.2.0",
    "latest_build": 14,
    "store_url": "https://play.google.com/store/apps/details?id=tech.runbit.denta",
    "release_notes": "Faster patient search, Arabic date fixes."
  }
}
```

**`update` is the whole contract.** The server decides; the client does no
version comparison of its own. That is the point — it lets you force an update
against a build whose bug you did not know about when you shipped it, without
shipping another one.

| Value | Client behaviour |
|---|---|
| `none` | Nothing shown. |
| `optional` | Dismissible bottom sheet. Declining it (button, drag or barrier) records `latest_version` on the device and never prompts for *that* version again; a newer `latest_version` prompts again. |
| `forced` | Full-screen, non-dismissible. The router is removed from the widget tree — there is no screen behind it and no back gesture out. |

Anything unrecognised is treated as `none`. Fail in that direction on purpose:
a config typo that read as `forced` would lock every user out of the app at
once.

**`store_url` is mandatory whenever `update` is not `none`.** Send the listing
for the requested `platform`. A prompt with no URL is a dead end and a *forced*
prompt with no URL would brick the app, so the client discards any decision
without one and behaves as if the answer were `none`. Do not expect the client
to build the URL from a bundle id — it deliberately does not, so that a bundle
id change cannot break the one build users can no longer update past.

`latest_version` should be the store version string, since it is also the key
the "don't ask me again" memory is stored under. `release_notes` is free text,
optional, shown under a "What's new" heading; it is scrollable but keep it
short. It is **not** localised by the client — send it in the caller's language
if you localise it at all.

**Behaviour before the route exists.** Any failure — 404, timeout, no network —
is treated as `none` and the app starts normally. Nothing about this check can
prevent the app from opening.

---

## Suggested build order

1. `DELETE /auth/account` — the store submission is blocked on it.
2. `GET /app/version` — cheap, and it is the switch you will want the first
   time a build goes out with a bad bug.
3. `GET /clinics/home-summary` — the app keeps working without it, on the
   older and slower path.
