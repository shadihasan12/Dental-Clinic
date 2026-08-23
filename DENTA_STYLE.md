
You are working on **Denta**, a Flutter/Material dental clinic management app.
Mobile-first (375–430dp), also runs on Windows desktop. Fully bilingual
English/Arabic with true RTL mirroring. Light and dark themes.

The **Patient Details** screen has been redesigned and is the new reference for
the whole app. Your job is to convert the remaining screens to match it. Do not
invent a new visual language — extract it from the reference and apply it
consistently. When the reference does not cover a case, extend it by the
principles below rather than importing patterns from elsewhere.

## The design language

**Type.** Geist for LTR, Cairo for Arabic. Only these two. Sizes actually used:
26px/700 for a hero number, 20px/700 for a secondary number, 15px/600 screen
title, 13px/600 section heading, 12.5px/600 card title, 11.5px/400 body,
11px/400 secondary, 10px/500 pill text, 9.5px/500 uppercase micro-label with
0.4px letter-spacing. Never below 10px. Letter-spacing goes slightly negative
(-0.3 to -0.8px) on large numbers only.

**Colour.** USE Primary ramp light blue: `#62B4DA` fills, `#3DA2D1`, `#2D90BE` for
primary text on white, `#8BC8E4`, `#A8D6EB`. Semantic: success `#16A34A`,
warning `#EA580C`, error `#DC2626`, info `#2563EB`, destructive `#D4183D`.
Neutrals `#F9FAFB` `#F3F4F6` `#E5E7EB` `#D1D5DB` `#9CA3AF` `#6B7280` `#4B5563`
`#374151` `#111827`. Tinted surfaces are the 50-level of their hue only:
`#E0F2FB` blue, `#DCFCE7` green, `#FFF7ED`/`#FFEDD5` orange, `#FEF2F2` red,
`#FFFBEB` amber. Page background `#F9FAFB`, cards `#fff`, hairlines `#E5E7EB`.
Never a gradient except a deliberate dark hero surface.

**Shape.** Cards 16px radius, inner cards 13–14px, buttons and inputs 11–13px,
icon tiles 10–11px, pills and chips 5–6px for labels and 20px for switchable
chips, avatars circular. Borders are 1px `#E5E7EB`; a focused or primary-bordered
element is 1.5px in its own hue. Elevation is borders, not shadows — shadows only
on the device frame and modal sheets.

**Spacing.** 14px screen gutters, 12–14px card padding, 8px between stacked
cards, 6–9px inside a card between rows. Sibling groups are laid out with
flex/grid and `gap`, never margins on children.

**Status is carried by a 3px left border** on a list card, plus a tinted icon
tile in the same hue: blue = planned, orange = in progress, green = done.
Completed items get grey `#9CA3AF` struck-through titles.

## Structural rules to carry across the app

1. **One screen, not tabs.** Where the old app used a TabBar to split one
   subject, replace it with a single scroll: a sticky header holding the 2–3
   numbers the user actually came for, then a horizontal anchor rail whose chips
   scroll to sections. Tabs are only acceptable for genuinely parallel lists.
2. **The answer goes in the header.** Every screen names the one or two values
   that must never require scrolling and puts them in the sticky header as
   labelled number tiles (uppercase micro-label above, large bold value below,
   tinted card if the value is a problem).
3. **Safety-critical data is never collapsed.** Allergies and medical history
   render as persistent alert strips: red when present, amber when unconfirmed,
   quiet grey line when confirmed absent. Never display an assumed "None".
4. **Primary actions dock to the bottom** in a blurred white bar in the thumb
   arc — filled `#62B4DA` for the main action, white with a 1.5px `#62B4DA`
   border for the secondary. Never more than two.
5. **One tap to record state.** A 44dp tappable check circle on a list row
   commits the common state change in place. Expanding a row is only for reading
   and adding notes, never required to complete a task.
6. **Sheet vs dialog vs page:**
   - **Bottom sheet** for anything with a keyboard or a choice list — the
     context stays visible behind it. Rounded 22px top corners, 40×4px grab
     handle, title row with an × on the trailing side.
   - **Centre dialog** only for destructive or irreversible confirmations, and
     it must state the consequence in a tinted warning box.
   - **Full page** only when the user is leaving the subject entirely (a
     read-only archived record, a full-screen media viewer).
7. **Money.** Always show the currency the amount is in. When a value is
   entered in a currency other than the record's currency, require an exchange
   rate manually — never prefill it — and show a live converted preview plus the
   resulting balance before the save button enables. Financial records are never
   edited; they are voided with a reversing entry and the original stays visible.
8. **Every list needs three states**, designed, not improvised: a skeleton that
   preserves the final layout's slots so nothing jumps; a dashed-border empty
   state with one sentence and the action that fills it; an error card that says
   what failed, what was not changed, and offers Retry plus a cached fallback.
   Uploads additionally need progress, failure-with-retry, and an offline queued
   state.
9. **RTL is a mirror, not a translation.** `direction: rtl` flips the whole
   layout: chevrons reverse, the status left-border becomes a right-border,
   number tiles reverse order, icons stay on the trailing side. Arabic-Indic
   numerals in Arabic locale. Cairo needs slightly more line-height than Geist.
10. **Desktop (≥1280) is the same content in three columns**, not a stretched
    phone: a reference rail on the leading side (identity, history), the primary
    working column in the middle, and a persistent tool panel on the trailing
    side holding what was a sheet on mobile. The sticky header becomes a single
    top bar with the key numbers right-aligned before the primary action.

## Tone of copy

Plain, factual, short. Label what a thing is, not how the user should feel. State
consequences literally ("$1,050 is still outstanding and 3 treatments are not
done"). No exclamation marks, no emoji, no encouragement.

## How to work

Convert one screen at a time. For each screen, before writing code, state in two
or three sentences: what the user came to that screen to know, what the sticky
header will therefore hold, and which of the old surfaces you are collapsing or
promoting. Then build it, and deliver light + dark, mobile + desktop-wide, and
one RTL proof per screen. Flag anything where following the rules above would
lose a capability the old screen had — do not silently drop features.
