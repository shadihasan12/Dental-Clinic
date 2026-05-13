# Statistics — backend API contract

This is the contract the Flutter app expects from the backend for the
**Statistics** screen (entry point: *More → Statistics*). The screen makes
exactly **one** request per period change and renders every card from
the returned snapshot.

> **Auth.** All routes require the dentist's bearer token in the
> `Authorization` header. The backend must scope every aggregate to the
> caller's clinic membership.

> **Mock note.** Until this contract is implemented the app reads from
> `MockStatisticsDataSource` (see
> [lib/features/statistics/data/data_sources/mock_statistics_data_source.dart](data/data_sources/mock_statistics_data_source.dart)).
> Swapping it for the real data source is a one-line change in
> [statistics_injection.dart](statistics_injection.dart).

---

## 1. Get statistics snapshot

### `GET /clinics/{clinicId}/statistics`

Returns a full snapshot for the requested period. Every chart and KPI on
the page is rendered from this single response — the backend does the
bucketing and percentage math so the client stays dumb.

**Path params**

| Param | Type | Notes |
|---|---|---|
| `clinicId` | string | The currently selected clinic. |

**Query params**

| Param | Type | Required | Notes |
|---|---|---|---|
| `period` | enum | yes | `week` &#124; `month` &#124; `year`. See *Bucketing* below. |
| `timezone` | string | recommended | IANA tz (e.g. `Europe/Berlin`) — pin bucket boundaries to the clinic's local day. |

**Response 200**

```json
{
  "period": "month",
  "range_start": "2026-04-13T00:00:00Z",
  "range_end":   "2026-05-12T23:59:59Z",
  "currency": "USD",

  "overview": {
    "total_revenue":               41980.00,
    "revenue_trend_percent":       14.2,
    "total_patients":              248,
    "patients_trend_percent":       6.5,
    "total_appointments":          192,
    "appointments_trend_percent":   4.8,
    "new_patients":                 34,
    "new_patients_trend_percent":  22.1
  },

  "revenue_trend": [
    { "label": "W1", "value":  8120.00 },
    { "label": "W2", "value":  9450.00 },
    { "label": "W3", "value": 11280.00 },
    { "label": "W4", "value": 13130.00 }
  ],

  "appointment_volume": [
    { "label": "W1", "count": 42 },
    { "label": "W2", "count": 48 },
    { "label": "W3", "count": 51 },
    { "label": "W4", "count": 51 }
  ],

  "appointment_breakdown": {
    "completed": 158,
    "cancelled":  14,
    "no_show":     9,
    "upcoming":   11
  },

  "treatment_distribution": [
    {
      "name": "Cleaning",
      "count": 76,
      "revenue": 4560.00,
      "percentage": 36.5
    }
  ],

  "top_treatments": [
    {
      "name": "Crown",
      "count": 15,
      "revenue": 9750.00
    }
  ]
}
```

**Errors**

| Status | Meaning |
|---|---|
| `401` | Token missing/invalid. |
| `403` | Caller is not a member of `clinicId`. |
| `404` | Clinic does not exist. |
| `422` | `period` outside the allowed enum. |

---

## 2. Field reference

### 2.1 `overview`

Top KPI cards. Each `*_trend_percent` is the **signed** relative change
vs. the previous comparable window (week-over-week, month-over-month,
year-over-year). Send a percentage (e.g. `14.2`, not `0.142`). Send `0`
when there is no prior data — the UI will render a neutral chip.

### 2.2 `revenue_trend` (line chart)

Pre-bucketed series; the client just draws it.

- `label` — short axis tick the client renders verbatim. Backend owns
  locale-aware formatting; the client does no date math here.
- `value` — bucket total in `currency`.

### 2.3 `appointment_volume` (bar chart)

Same bucketing as `revenue_trend`. `count` is appointments scheduled in
the bucket (any status).

### 2.4 `appointment_breakdown`

Aggregate across the **entire** range, not per bucket.

- `completed` — finalized visits.
- `cancelled` — cancelled by patient or clinic.
- `no_show` — patient missed without cancelling.
- `upcoming` — scheduled and still in the future at request time.

The four numbers should sum to total appointments in range (any double-
counting will surface as the progress bars not summing to 100%).

### 2.5 `treatment_distribution` (donut chart)

One entry per treatment category. `percentage` is `count / Σ count *
100` already computed — the donut and legend rely on it summing to ~100.
Cap the list at **8** categories; group the long tail under `"Other"`.

### 2.6 `top_treatments`

Top **5** treatments by revenue, descending. Independent of the donut —
ranked by revenue, not procedure count, so a low-volume / high-margin
treatment can land here.

---

## 3. Bucketing rules

| `period` | Range | Bucket size | Bucket count | Label example |
|---|---|---|---|---|
| `week`  | last 7 days, ending today    | 1 day   | 7  | `Mon`, `Tue`, … |
| `month` | last 30 days, ending today   | 1 week  | 4  | `W1`, `W2`, …   |
| `year`  | last 12 months, ending today | 1 month | 12 | `Jan`, `Feb`, … |

- Days/weeks/months are aligned to the **clinic's local timezone**
  (`timezone` query param).
- The "trend percent" reference window is the period **immediately
  before** the returned range — e.g. for `period=month` the comparison
  window is the 30 days before `range_start`.

---

## 4. Caching & invalidation

- Snapshots are inherently cacheable per `(clinicId, period, day)`.
  Recommend `Cache-Control: private, max-age=900` (15 min) on the
  response.
- Bust the cache when: a new appointment is created/finalized, an
  invoice is paid, or a patient is added. The dentist app does a pull-
  to-refresh, so eventual consistency within ~minutes is acceptable.

---

## 5. Future endpoints (not yet wired)

These are placeholders so the backend team can plan ahead — the
Flutter side does **not** call them yet.

- `GET /clinics/{clinicId}/statistics/export?period=month&format=pdf`
  — generate a PDF report for the same range.
- `GET /clinics/{clinicId}/statistics/by-doctor?period=month` — per-
  doctor breakdown for clinics with multiple dentists.
- `GET /clinics/{clinicId}/statistics/cashflow?period=year` — income vs.
  expenses (depends on the expenses feature shipping).
