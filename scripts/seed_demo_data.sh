#!/bin/zsh
# Seeds the App Review demo clinic with realistic patients, cases, payments and
# expenses so the app doesn't open onto empty states during Apple review.
#
# Credentials come from .env.seed (gitignored):
#   SEED_EMAIL=...
#   SEED_PASSWORD=...
#
# Safe to re-run: it appends. It never deletes.

set -e
cd "$(dirname "$0")/.."

API="${BASE_URL:-https://denta-backend.runbit.tech/api}"
WORK="${SEED_WORK_DIR:-$(mktemp -d)}"
mkdir -p "$WORK"

[[ -f .env.seed ]] || { echo "missing .env.seed"; exit 1; }
set -a; . ./.env.seed; set +a

# ---------- auth ----------
jq -n --arg e "$SEED_EMAIL" --arg p "$SEED_PASSWORD" \
  '{email_or_mobile_number:$e,password:$p}' > "$WORK/login.json"

curl -s -D "$WORK/h.txt" -o "$WORK/login.json.out" --max-time 30 \
  -X POST "$API/auth/login" -H "Content-Type: application/json" \
  -H "Accept: application/json" --data @"$WORK/login.json" >/dev/null

TOKEN=$(grep -i '^authorization:' "$WORK/h.txt" | sed 's/^[Aa]uthorization: //' | tr -d '\r')
CLINIC=$(jq -r '.data.clinics[0].clinic.id' "$WORK/login.json.out")
[[ -n "$TOKEN" && "$CLINIC" != "null" ]] || { echo "login failed"; exit 1; }
echo "authenticated · clinic $CLINIC"

api() {  # api METHOD PATH [curl args...] — JSON
  local m=$1 p=$2; shift 2
  curl -s --max-time 30 -X "$m" "$API$p" \
    -H "Authorization: Bearer $TOKEN" \
    -H "X-Selected-Clinic-id: $CLINIC" \
    -H "Content-Type: application/json" -H "Accept: application/json" \
    -H "Accept-Language: en" "$@"
}

# Multipart. Deliberately does NOT set Content-Type — curl has to generate the
# boundary itself, and an explicit header silently produces an unparseable body.
api_form() {  # api_form PATH [-F ...]
  local p=$1; shift
  curl -s --max-time 30 -X POST "$API$p" \
    -H "Authorization: Bearer $TOKEN" \
    -H "X-Selected-Clinic-id: $CLINIC" \
    -H "Accept: application/json" -H "Accept-Language: en" "$@"
}

# ---------- reference data ----------
api GET /core-treatments        > "$WORK/treatments.json"
api GET /teeth                  > "$WORK/teeth.json"
api GET /clinics/expenses/categories > "$WORK/expcats.json"
api GET /currencies             > "$WORK/currencies.json"

USD=$(jq -r '.data[]|select(.currency_code=="USD")|.id' "$WORK/currencies.json")
tx()    { jq -r --arg n "$1" '.data[]|select(.name==$n)|.id' "$WORK/treatments.json"; }
tooth() { jq -r --argjson i "$1" '.data[$i % (.data|length)].id' "$WORK/teeth.json"; }
cat_id(){ jq -r --arg n "$1" '.data[]|select(.name==$n)|.id' "$WORK/expcats.json"; }

# ---------- patients ----------
# name|dob|phone|gender|treatment|cost|labfees|paid|plan description
ROWS=(
"Omar Khoury|1986-02-11|0991000101|MALE|Root Canal|520|90|520|Root canal therapy, upper left molar"
"Rana Sayegh|1994-07-23|0991000102|FEMALE|Dental Crown|780|220|500|Porcelain crown fitting after root canal"
"Yousef Nassar|1979-11-05|0991000103|MALE|Dental Implant|1650|480|1650|Single implant with abutment and crown"
"Maya Darwish|2001-03-19|0991000104|FEMALE|Scaling & Polishing|180|0|180|Routine hygiene visit"
"Hadi Mansour|1990-09-30|0991000105|MALE|Tooth Extraction|220|0|220|Surgical extraction of impacted wisdom tooth"
"Nour Sabbagh|1997-05-14|0991000106|FEMALE|Teeth Whitening|340|0|200|In-office whitening, two sessions"
"Ziad Haddad|1983-12-02|0991000107|MALE|Dental Bridge|1250|380|800|Three-unit bridge, lower right"
"Lama Attar|1992-08-08|0991000108|FEMALE|Deep Cleaning|260|0|260|Scaling and root planing, all quadrants"
"Kareem Fares|1975-04-27|0991000109|MALE|Full Denture|1900|620|1200|Upper full denture"
"Salma Rifai|1999-01-16|0991000110|FEMALE|Consultation|90|0|90|New patient consultation and X-ray"
"Tarek Zeidan|1988-06-21|0991000111|MALE|Root Canal|540|95|300|Root canal, lower right premolar"
"Dina Halabi|1995-10-09|0991000112|FEMALE|Dental Crown|760|210|760|Zirconia crown, upper right"
"Fadi Barakat|1981-03-03|0991000113|MALE|Dental Implant|1720|500|900|Implant placement, healing phase"
"Rima Kassab|2003-07-12|0991000114|FEMALE|Fluoride Treatment|120|0|120|Preventive fluoride application"
"Sami Aoun|1972-02-25|0991000115|MALE|Dental Bridge|1180|350|1180|Bridge replacement, upper anterior"
"Hala Murad|1998-11-28|0991000116|FEMALE|Scaling & Polishing|175|0|175|Six-month recall cleaning"
"Bassel Injeela|1985-05-06|0991000117|MALE|Post and Core|430|110|430|Post and core buildup before crown"
"Yara Sleiman|1993-09-17|0991000118|FEMALE|Inlay|610|180|350|Ceramic inlay, lower left molar"
"Nabil Okasha|1968-08-13|0991000119|MALE|Full Denture|2050|680|2050|Lower full denture, second fitting"
"Joud Kanaan|2005-04-01|0991000120|FEMALE|Consultation|85|0|85|Orthodontic assessment"
"Amir Shahin|1991-12-24|0991000121|MALE|Tooth Extraction|240|0|240|Extraction of non-restorable molar"
"Tala Rahal|1996-06-18|0991000122|FEMALE|Teeth Whitening|360|0|360|Whitening plus custom trays"
"Ghassan Wehbe|1977-10-31|0991000123|MALE|Root Canal|560|100|560|Retreatment of failed root canal"
"Sara Deeb|2000-02-07|0991000124|FEMALE|Deep Cleaning|250|0|150|Periodontal maintenance, first of two"
"Marwan Tabbara|1989-07-04|0991000125|MALE|Dental Crown|800|230|800|Crown on implant, upper left"
"Nadia Fakhoury|1984-01-22|0991000126|FEMALE|X-Ray|70|0|70|Panoramic radiograph"
"Rami Halim|1994-03-15|0991000127|MALE|Scaling & Polishing|180|0|180|Routine cleaning and polish"
"Layan Osman|2002-09-09|0991000128|FEMALE|Fluoride Treatment|110|0|110|Preventive visit"
"Firas Sadek|1980-11-11|0991000129|MALE|Dental Implant|1680|490|1680|Implant restoration completed"
"Carine Malki|1987-05-29|0991000130|FEMALE|Inlay|590|170|590|Gold inlay, upper right"
)

# SKIP_PATIENTS=1 leaves the roster alone — for re-runs that only need the
# appointment book filled, which would otherwise duplicate all 30 patients.
if [[ -n "$SKIP_PATIENTS" ]]; then ROWS=(); fi
echo "seeding ${#ROWS[@]} patients…"
: > "$WORK/pids.txt"
i=0; created=0; revenue=0
for row in "${ROWS[@]}"; do
  IFS='|' read -r name dob phone gender treat cost lab paid desc <<< "$row"
  first="${name%% *}"; last="${name#* }"

  pid=$(api_form /clinics/patients \
    -F "first_name=$first" -F "last_name=$last" -F "date_of_birth=$dob" \
    -F "phone_number=$phone" -F "gender=$gender" \
    | jq -r '.data.id // empty')

  [[ -n "$pid" ]] || { echo "  ! patient $name failed"; continue; }
  created=$((created+1))
  echo "$pid" >> "$WORK/pids.txt"

  tid=$(tx "$treat")
  jq -n --arg u "$USD" --arg t "$tid" --arg th "$(tooth $i)" --arg d "$desc" \
        --argjson c "$cost" --argjson l "$lab" \
    '{total_cost:$c,total_cost_currency_id:$u,lab_fees:$l,lab_fees_currency_id:$u,
      treatment_plan_items:[{description:$d,core_treatment_ids:[$t],tooth_ids:[$th]}]}' \
    > "$WORK/case.json"

  cid=$(api POST "/clinics/patients/$pid/cases" --data @"$WORK/case.json" | jq -r '.data.id // empty')
  [[ -n "$cid" ]] || { echo "  ! case for $name failed"; i=$((i+1)); continue; }

  if [[ "$paid" -gt 0 ]]; then
    jq -n --arg u "$USD" --argjson a "$paid" \
      '{amount:$a,currency_id:$u,case_currency_id:$u,amount_in_case_currency:$a,
        exchange_rate:1,notes:"Payment received"}' > "$WORK/pay.json"
    api POST "/clinics/patients/$pid/cases/$cid/payments" --data @"$WORK/pay.json" >/dev/null
    revenue=$((revenue+paid))
  fi

  # Fully-settled cases are closed so the list isn't uniformly "active".
  if [[ "$paid" -eq "$cost" ]]; then
    api POST "/clinics/patients/$pid/cases/$cid/complete" \
      --data "{\"title\":\"$treat\"}" >/dev/null || true
  fi

  echo "  · $name — $treat \$$cost (paid \$$paid)"
  i=$((i+1))
done

# ---------- appointments ----------
# The home screen opens on "Today's Schedule", so an empty appointment book is
# the first thing a reviewer sees. This fills today and the following days.
#
# `doctor_id` is rejected for any user who is not a DENTIST in this clinic, and
# a clinic created through signup has its owner as ADMIN only — so the role is
# granted first. Roles are a set, not a change-log: the request has to carry the
# roles being kept as well, or ADMIN is dropped. Valid values are ADMIN,
# DENTIST and SECRETARY; anything else comes back as "roles.N is invalid".
if [[ -z "$SKIP_APPOINTMENTS" ]]; then
  echo "seeding appointments…"
  DOCTOR=$(jq -r '.data.id' "$WORK/login.json.out")

  if ! api GET /clinics/clinic-doctors | jq -e '.data|length>0' >/dev/null; then
    echo "  · granting DENTIST to the clinic owner"
    api POST "/clinics/users/$DOCTOR/roles" \
      --data '{"roles":["ADMIN","DENTIST"]}' >/dev/null
  fi

  if api GET /clinics/clinic-doctors | jq -e '.data|length>0' >/dev/null; then
    # Times are local clinic hours; the API takes "YYYY-MM-DD HH:MM:SS".
    # Start and end are paired rather than computed — a half-hour of shell
    # arithmetic to save ten characters of table is a bad trade.
    SLOTS=("09:00|09:30" "10:30|11:00" "13:00|13:30" "15:00|15:30" "16:30|17:00")
    appts=0; n=0
    # Falls back to the patients already on the clinic, so appointments can be
    # seeded on their own (SKIP_PATIENTS=1) without duplicating the roster.
    PIDS=("${(@f)$(< "$WORK/pids.txt")}")
    if [[ -z "${PIDS[1]}" ]]; then
      PIDS=("${(@f)$(api GET '/clinics/patients?size=200' | jq -r '.data[].id')}")
    fi
    [[ -n "${PIDS[1]}" ]] || { echo "  ! no patients to book against"; PIDS=(); }

    # Three weeks out, not one: App Review can pick the build up days after
    # this runs, and a book that only covered the next few days would have
    # emptied itself again by the time a reviewer opened the home screen.
    if [[ ${#PIDS[@]} -gt 0 ]]; then
    for day in {0..${APPT_DAYS:-20}}; do
      d=$(date -v+${day}d +%Y-%m-%d 2>/dev/null || date -d "+$day day" +%Y-%m-%d)
      for slot in "${SLOTS[@]}"; do
        s="${slot%%|*}"; end="${slot##*|}"
        # zsh arrays are 1-indexed.
        pid="${PIDS[$(( n % ${#PIDS[@]} + 1 ))]}"
        [[ -n "$pid" ]] || continue
        jq -n --arg p "$pid" --arg doc "$DOCTOR" \
              --arg st "$d $s:00" --arg en "$d $end:00" \
          '{patient_id:$p,doctor_id:$doc,start_time:$st,end_time:$en,
            notes:"Scheduled visit",notify_patient:false}' > "$WORK/appt.json"
        if api POST /clinics/appointments --data @"$WORK/appt.json" \
             | jq -e '.result=="success"' >/dev/null; then
          appts=$((appts+1))
        fi
        n=$((n+1))
      done
      echo "  · $d — $appts booked so far"
    done
    fi
    echo "  $appts appointments created"
  else
    echo "  ! owner is still not a DENTIST — appointments skipped"
  fi
fi

# ---------- expenses ----------
# Backdated across recent months; entry_date is honoured by the API.
# SKIP_EXPENSES=1 re-runs patients without duplicating the expense ledger.
if [[ -n "$SKIP_EXPENSES" ]]; then
  echo "skipping expenses (SKIP_EXPENSES set)"
  echo
  echo "done — $created patients, \$$revenue collected"
  exit 0
fi
echo "seeding expenses…"
EXP=(
"Salaries & Wages|2400|Monthly staff salaries"
"Clinic Rent|1200|Monthly clinic rent"
"Medical Supplies & Materials|780|Composite, anesthetics, disposables"
"Laboratory Fees|940|External lab — crowns and bridges"
"Electricity & Water|210|Utilities"
"Cleaning & Sterilization|180|Autoclave supplies and cleaning service"
"Marketing & Advertising|300|Social media campaign"
"Maintenance & Repairs|260|Dental chair servicing"
"Internet & Communication|85|Clinic internet and phone line"
"Stationery & Printing|60|Patient forms and cards"
)
expenses=0
for m in 0 1 2 3 4; do
  d=$(date -v-${m}m +%Y-%m-15 2>/dev/null || date -d "-$m month" +%Y-%m-15)
  for e in "${EXP[@]}"; do
    IFS='|' read -r cname amt note <<< "$e"
    cid=$(cat_id "$cname")
    [[ -n "$cid" ]] || continue
    jq -n --arg a "$amt" --arg u "$USD" --arg c "$cid" --arg n "$note" --arg d "$d" \
      '{amount:$a,currency_id:$u,expense_category_id:$c,notes:$n,entry_date:$d}' \
      > "$WORK/exp.json"
    api POST /clinics/expenses --data @"$WORK/exp.json" >/dev/null
    expenses=$((expenses+1))
  done
  echo "  · $d — ${#EXP[@]} entries"
done

echo
echo "done — $created patients, \$$revenue collected, $expenses expense entries"
