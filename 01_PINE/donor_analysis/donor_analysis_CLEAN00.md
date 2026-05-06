# DONOR ANALYSIS — CLEAN-00
Donor: C:\SMC_PROJECT\01_PINE\core\smc_core_detector_L0_completion_rule_reachable.pine
Line count: 966 | Pine: v6 | Actual state per Stage 0 audit: STATE G

NOTE: Task description assumed STATE E. Stage 0 audit (2026-05-02) confirmed STATE G.
The clean rebuild decision is independent of state — it is a structural architecture choice.

---

## SECTION A — WHAT WORKS IN DONOR (keep ideas)

### Pivot + leg detection
- `ta.pivotlow` / `ta.pivothigh` with configurable length input
- Pivot time recorded at `time[_pivotLen]` — correct confirmed-bar offset
- Bull/bear base-terminal pairs tracked independently
- Cross-assignment: new pivot low updates bear terminal if lower; new pivot high updates bull terminal if higher

### ATR freeze filter
- `ta.atr(_freezeAtrLen) * _freezeAtrFactor` = minimum pullback threshold
- `_bullHasSmallPullback` / `_bearHasSmallBounce` gate prevents noise freezes

### Sequence freeze
- Opposite-direction bar counter (`_bullBearishSeq` / `_bearBullishSeq`)
- Configurable length (1–5 bars); resets on base reassignment
- Combined with pullback gate for dual-condition freeze

### Higher-low / lower-high freeze triggers
- `_bearHigherLowFreeze`: new pivot low above bear terminal → bear leg complete
- `_bullLowerHighFreeze`: new pivot high below bull terminal → bull leg complete
- Guard: leg range > syminfo.mintick before publishing

### 50% correction confirmation
- Threshold at birth: `range * 0.5` from terminal
- If correction already reached at birth → confirm immediately
- Ongoing tracking each bar: `_bullConfirmedNow` / `_bearConfirmedNow`

### request.security architecture
- Two calls: anchor TF (4H POI) + structural TF (1H PRIMARY)
- `request.security_lower_tf` for confirm TF sub-bar OHLC arrays
- `gaps=barmerge.gaps_off, lookahead=barmerge.lookahead_off` — non-lookahead correct
- Single reusable function `f_latest_confirmed_impulse` for both calls

### Role-based profile lock
- `profilePoiTimeframe="240"`, `profilePrimaryTimeframe="60"`, `profileConfirmTimeframe="15"`
- All visual text derived from role labels — no hardcoded TF strings in display
- `anchorTimeframe = profilePoiTimeframe`, `structuralTimeframe = profilePrimaryTimeframe`

### Stable takeover contract (currentPrimaryTakeoverAllowed)
- Gate: anchor exists + structurally valid + correction valid + distinct from tracked + dominates + not micro leg
- `currentPrimaryNeedsRefresh = currentPrimaryTakeoverAllowed` — exact alias (contractual)

### Dominance check
- `currentPrimaryMinRangeOk`: raw range >= tracked * 0.35
- `currentPrimaryTerminalExpansionOk`: terminal extends beyond tracked by 0.25 of tracked range
- `currentPrimaryRangeDominanceOk`: raw range >= tracked * 1.25
- `currentPrimaryIsInternalMicroLeg`: fully inside tracked + not range-dominant → reject

### finalFibLine* (5-level fib)
- Lines 0 / 50 / 70.5 / 79 / 1 with direction-aware calculation
- Width 2 for live owner, 1 for memory mode
- Delete-before-redraw pattern

### FIB visual memory
- Persists last valid fib when no active owner
- `fibVisualMemoryActive` = no live owner but memory valid
- Fib stays on screen during rearm wait states

### Owner states
- CURRENT / PREVIOUS_AFTER_ROLLBACK / PREVIOUS / NONE
- `activeOwnerStateFinal` string + `fibOwnerStateFinal` string

### Rollback architecture
- `mtfRollbackToPreviousAnchor` flag; set on break, cleared on anchor change or new takeover
- Break: confirm TF array loop, wick through FIB 79%
- Break clears active, sets broken + rollback flags

### Rearm state machine
- REARM_LOCKED_CURRENT / WAIT_PRIMARY_IN_POI / WAIT_NEW_POI / REARM_NONE_OFF
- Reason strings for each state

### Protected level (15m swing in 1H range)
- Latest 15m swing low (bull) or swing high (bear) within primary time and price range
- Held level persists when current swing unavailable

### Anchor change reset
- `mtfAnchorChanged` triggers full primary state reset
- Prevents stale primary after POI rotation

### Proof label + visual labels
- All state fields in one label (profile, TFs, owner, fib, lock, POI state, next confirm, rearm, break)
- Role-keyed visual labels: "4H POI БАЗА", "1H ОСН. БАЗА", "15m ПОДТВ. СЛОМ" etc.

---

## SECTION B — WHAT IS INCOMPLETE (gaps for clean rebuild)

| Gap | Description |
|---|---|
| No impPend* lifecycle | No explicit pending/candidate slot — current either locks or doesn't |
| No explicit ownerIsNone bool | NONE is a string match, not a tracked boolean |
| Single profile only | Hardcoded 4H/1H/15m — no PROFILE_B |
| READY_FOR_PRIMARY_TAKEOVER missing | Transition state from WAIT_PRIMARY_IN_POI not explicit |
| traceTimingEnabled hardcoded false | Debug table always disabled |

---

## SECTION C — MISSING vs CANON (what clean rebuild adds)

| Canon requirement | Donor | Clean rebuild |
|---|---|---|
| Role-based profile | PRESENT (STATE G) | PRESENT + PROFILE_A / PROFILE_B |
| Stable takeover contract | PRESENT | Carry forward |
| impPend* (pending impulse slot) | ABSENT | Add explicitly |
| ownerIsNone bool | Implicit only | Add explicitly |
| READY_FOR_PRIMARY_TAKEOVER state | ABSENT | Add to rearm machine |
| OWNER NONE recovery lifecycle | Design pending (Stage 7.0) | Future stage |
| Boundary event engine | ABSENT | Future stage |

---

## SUMMARY

Donor is STATE G — mature, clean, fully role-based. Clean rebuild chosen for:
1. Multi-profile architecture (PROFILE_A / PROFILE_B) from the start
2. Explicit impPend* slot and ownerIsNone bool designed in from zero
3. Easier to audit a 40-line base than extend a 966-line file

Logic to port verbatim from donor:
- f_latest_confirmed_impulse (pivot + leg + correction engine)
- Full stable takeover contract conditions
- Dominance check logic
- Break detection via confirm TF array
- FIB visual memory pattern
- Anchor change reset pattern
