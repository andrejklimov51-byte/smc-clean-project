# CLEAN-01 Donor Logic Extraction

## 1. Active Clean Verification

- Clean active file: `D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine`
- Verification result: PASS
- Active line count: `102`
- Exactly one active `.pine` in clean core: YES
- `PROFILE_A`, `PROFILE_B`, `selectedProfile`, `profilePoiTimeframe`, `profilePrimaryTimeframe`, `profileConfirmTimeframe`, minimal proof label: present
- `request.security`, legacy lifecycle markers, final owner markers, fib/protected/debug markers: absent in active clean baseline

## 2. Inventory Table

### 2.1 Raw donor sweep

| Scope | Count | Notes |
| --- | ---: | --- |
| `D:\SMC_PROJECT\01_PINE\core` | 1 | current degraded L0 branch |
| `D:\SMC_PROJECT\01_PINE\core\то что работает` | 3 | working copies of the same reachable branch family |
| `D:\SMC_PROJECT\01_PINE\archive` | 272 | main donor archive |
| Total scanned `.pine` | 276 | metadata sweep completed |
| Relevant task/analysis docs hit | 326 | `tasks_archive` + `analysis_archive` keyword scan |

### 2.2 Raw inventory asset

- Full per-file metadata sweep for all 276 donor Pine files was captured during this stage.
- Raw inventory file:
  `D:\SMC_PROJECT_CLEAN\01_PINE\donor_analysis\donor_logic_extraction_20260504_1725_inventory_raw.csv`
- Raw columns:
  `Path`, `Name`, `Modified`, `Size`, `LineCount`, `Sha1`, `First5`

## 3. Classification Table

| Class | Meaning | Main donor families found |
| --- | --- | --- |
| `A. WORKING LEGACY DONOR` | legacy lifecycle with separate previous/current/next, rearm, promotion, NEXT SEARCH/NEXT CONFIRM, rollback, break persistence | `smc_core_detector_PRE_CORE_*` sequence, especially sequential / rearm / promotion / rollback files |
| `B. FIXED-MTF PARTIAL DONOR` | fixed role profile / final MTF ownership blocks, but incomplete lifecycle | `smc_core_detector_L0_completion_rule_reachable_20260428_1158_after_role_based_mtf_profile_lock.pine`, `smc_core_detector_L0_completion_rule_reachable_20260429_1456_after_stage_7_1_post_none_rearm.pine` |
| `C. VISUAL-ONLY DONOR` | Russian labels, proof text, trace/debug table, fib visual persistence, transparency | `after_stage_7_2l*`, `after_stage_7_2p*`, `after_stage_7_2p_r*` |
| `D. DEGRADED CURRENT BRANCH` | final-MTF + visual/protected/0.79/fib-memory mixed in one branch, not acceptable as clean base | current `smc_core_detector_L0_completion_rule_reachable.pine` and near-final stage 7.2 after-files |
| `E. INVALID MIXED BRANCH` | chart-timeframe-dependent MTF routing or mixed profile logic | `smc_core_detector_PRE_CORE_fixed_mtf_routing_and_current_primary_refresh_rearm.pine`, `smc_core_detector_PRE_CORE_mtf_current_primary_lifecycle_refresh_and_rollback_rearm.pine`, `smc_core_detector_PRE_L0_current_chart_timeframe_master_rebase*.pine` |
| `F. UNKNOWN` | early experimental v4-v8, PRE_L0, PRE_L2, layer1 families not suitable as direct Global Impulse Graph donors | large remainder of archive |

## 4. Main Donor Candidates

| Role | File | Lines | Why selected | Extract | Do not extract |
| --- | --- | ---: | --- | --- | --- |
| Previous/current/next lifecycle | `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_first_layer_sequential_engine_verification.pine` | 384 | simplest recovered sequential engine; analysis history confirms it was restored as a valid source with `rearmNextImpulse`, `nextImpulseExists`, `NEXT SEARCH`, `NEXT CONFIRM` | state separation between current and next, sequential engine phases, debug labels as proof only | 0.5 retrace confirmation, chart-timeframe anchoring |
| Rearm | `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_rearm_next_impulse_architecture.pine` | 515 | dedicated rearm architecture branch; isolates post-confirm rearm and preserves current structure while scan re-arms | rearm as separate engine, preserve current object while next search rearms | fib/OTE coupling, 0.79 and retrace-based quality filters |
| Promotion next -> current | `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_first_layer_next_to_primary_promotion_fix.pine` | 522 | explicit copy order from current -> previous and next -> current; promotion node is easy to isolate | promotion copy contract, previous snapshot freeze before replacement | promotion by recency only, fib as authority |
| Rollback / break persistence | `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_first_layer_mtf_previous_current_break_rollback_architecture.pine` | 701 | best legacy donor for break event -> rollback path with persistent break object and explicit previous restore | boundary event record, rollback object copy, break visual persistence | full-edge break semantics, 0.5/0.79 fib logic as structural truth |
| Visual-only later | `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_L0_completion_rule_reachable_20260502_1634_after_stage_7_2p_r_fib_visual_proof_ru_repair.pine` | 965 | richest late visual layer donor: RU proof, trace table, protected debug labels, fib visual memory | Russian display helpers, proof formatting, visual persistence ideas, trace/debug text organization | final MTF ownership logic, protected-level/0.79 logic, fib memory as logic source |

## 5. Useful Algorithm Extraction

### 5.1 Previous impulse memory

- Main donor:
  `smc_core_detector_PRE_CORE_first_layer_next_to_primary_promotion_fix.pine`
- Variable block:
  lines `40-51`
  `previousImpulseExists`, `previousImpulseStartBar`, `previousImpulseProvisionalEndBar`, `previousImpulseConfirmedEndBar`, `previousImpulseLow`, `previousImpulseHigh`, `previousImpulseDir`, `previousImpulseRange`, `previousImpulseTimeframe`, `previousImpulseCompletionBar`, `previousImpulseCompletionPrice`
- Copy step:
  lines `405-416`
- Useful:
  previous object is copied from current only at promotion boundary, so previous is an immutable historical snapshot and is not overwritten by live next scanning.
- Reject:
  previous object must not be tied to fib ownership or 0.5 / 0.79 logic in clean rebuild.

### 5.2 Current active impulse

- Main donor:
  `smc_core_detector_PRE_CORE_first_layer_sequential_engine_verification.pine`
- Current-object creation:
  lines `196-244`
- Confirmation / lifecycle transition:
  lines `265-274`
- Useful:
  current object is a standalone state with its own existence, provisional end, confirmed end, range and direction.
  The engine separates build, confirm, rearm, next-search, and next-confirm phases.
- Reject:
  do not reuse 0.5 retrace as canonical impulse-break definition in clean rebuild.

### 5.3 Next impulse search

- Main donor:
  `smc_core_detector_PRE_CORE_first_layer_sequential_engine_verification.pine`
- Next-search ready:
  lines `338-357`
- Next-confirm:
  lines `362-373`
- Visual proof:
  `lblNextSearch`, `lblNextConfirm`, `NEXT SEARCH`, `NEXT CONFIRM`
- Useful:
  next object must remain separate from current owner;
  NEXT SEARCH / NEXT CONFIRM are proof visuals, not logic source.
- Reject:
  chart-bar recency by itself cannot authorize takeover.

### 5.4 Rearm

- Main donor:
  `smc_core_detector_PRE_CORE_rearm_next_impulse_architecture.pine`
- Confirm -> rearm boundary:
  lines `287-340`
- Supporting document:
  `D:\SMC_PROJECT\01_PINE\analysis_archive\post_analysis_L0_rearm_scanner_after_confirmed_master.txt`
- Useful:
  rearm is a separate engine state;
  current confirmed object remains visible while scan-state re-arms;
  only next-search fields are reset.
- Reject:
  rearm must not erase current proof object immediately;
  rearm must not become a hidden owner reassignment rule.

### 5.5 Promotion next -> current

- Main donor:
  `smc_core_detector_PRE_CORE_first_layer_next_to_primary_promotion_fix.pine`
- Next confirm and copy order:
  lines `392-458`
- Supporting document:
  `D:\SMC_PROJECT\01_PINE\analysis_archive\post_analysis_L0_split_selected_master_and_scan_candidate.txt`
- Useful:
  promotion order is explicit:
  1. freeze previous from current
  2. clear old visuals
  3. copy next into current
  4. redraw current proof
- Reject:
  `selectedMaster` / `scanCandidate` naming can change;
  promotion by “newer on chart TF only” must not be reused as clean canon.

### 5.6 Rollback

- Main donor:
  `smc_core_detector_PRE_CORE_first_layer_mtf_previous_current_break_rollback_architecture.pine`
- Break detection and rollback entry:
  lines `378-475`
- Useful:
  rollback is a structural object-copy path:
  current break is recorded,
  previous snapshot is restored into current,
  next object is cleared,
  rearm restarts after rollback.
- Reject:
  legacy break threshold `low < primaryImpulseLow` / `high > primaryImpulseHigh` is not the clean canonical break rule by itself.

### 5.7 Break visual persistence

- Main donor:
  `smc_core_detector_PRE_CORE_first_layer_mtf_previous_current_break_rollback_architecture.pine`
- Persistent break object:
  lines `382-395`
  `primaryBreakLine`, `lblPrimaryBreak`, `lastPrimaryBreakBar`, `lastPrimaryBreakPrice`, `lastPrimaryBreakDir`
- Useful:
  break should be stored as an event object with direction, price and timestamp/bar.
- Reject:
  break line anchored to ad-hoc fib levels, protected lines or visual assumptions.

### 5.8 LAST ONLY

- Main donor:
  `smc_core_detector_PRE_CORE_last_primary_break_rollback_to_previous.pine`
- Cleanup blocks:
  lines `226-257`, `324-329`, `419-431`, `534-536`
- Useful:
  central cleanup before redraw is valid for visual layer;
  only the latest confirmed scenario should remain visible.
- Reject:
  LAST ONLY must delete stale visuals only;
  it must not erase logical memory objects required by lifecycle engines.

## 6. Rejected Wrong Ideas

- chart-dependent MTF routing
- auto profile by display timeframe
- legacy pivot noise as final canon
- recency-only takeover
- 0.79 as structural break
- protected debug line as final break source
- fib memory as owner
- visual labels as logic source
- Candidate / Sweep / OB / Entry logic from legacy branch
- display timeframe as state clock

## 7. Donor -> Clean Canon Mapping

| Legacy donor mechanic | Clean canon target |
| --- | --- |
| `previousImpulse*` | previous impulse reference |
| `primaryImpulse*` / current master | current impulse owner |
| `nextImpulse*` | next impulse candidate |
| `rearmNextImpulse` / `scanStateArmed` | Recovery / Rearm Engine |
| promotion from next to current | Takeover / Promotion Engine |
| rollback to previous after break | Owner / Rearm rollback path |
| persistent break line + label | persistent break visual layer |
| fib lines / fib memory | later Fib / OTE Visual Engine only |
| RU proof labels / trace table | later Russian / Visual Layer only |

## 8. Clean Engine Dependency Table

| Engine | Donor help | Forbidden donor carry-over | Data required | Gate |
| --- | --- | --- | --- | --- |
| 1. Profile Engine | fixed profile lock donors | chart-dependent routing | profile ids, TF labels | A/B only |
| 2. Raw MTF Source Engine | fixed-MTF partial donors | display-TF auto-map | requested TF OHLC/time | display TF must not choose logic |
| 3. Impulse Object Engine | legacy primary/next object fields | fib-derived structure | start/end/high/low/range/dir | object fields complete |
| 4. Impulse Lifecycle Engine | sequential engine donor | hidden recency promotion | current/previous/next states | lifecycle transitions explicit |
| 5. Takeover / Promotion Engine | next->current promotion donor | later-by-time only | candidate vs owner comparison | structural dominance required |
| 6. Boundary Event Engine | rollback/break donor | 0.79 and protected debug lines | edge-taken event record | event removes previous high/low |
| 7. MTF Interpretation Engine | fixed-MTF partial donors | chart timeframe logic | raw MTF objects | logic stable across display TF |
| 8. POI Context Engine | fixed-MTF partial donors | stale visual fallback as logic | senior impulse reference | POI validity explicit |
| 9. Primary Ownership Engine | fixed-MTF owner donors | fib memory as owner | current owner snapshot | owner separate from visuals |
| 10. Confirm Engine | next search / next confirm donor | proof labels as logic source | confirm candidate event | confirm after candidate only |
| 11. Owner / Rearm Engine | rearm + rollback donors | blind fallback | owner state + recovery state | owner NONE not dead-end |
| 12. Recovery Engine | rearmNextImpulse donor | hard full reset of history | preserved current/previous + reset next | next search can restart safely |
| 13. Fib / OTE Engine | fib visual donors | fib as structural truth | impulse high/low/range only | fib is downstream visual layer |
| 14. Visual Layer | LAST ONLY + RU/trace donors | visual source driving state | proof labels, lines, tables | visuals never own logic |

## 9. Recommendation for CLEAN-02

- Allowed next stage:
  `CLEAN-02 PROFILE ENGINE`
- Build order:
  1. keep current clean baseline as the only active core
  2. use donor extraction only as reference
  3. implement Profile Engine in isolation
- Do not import in CLEAN-02:
  `request.security`, lifecycle, POI, primary, break, fib, protected level, owner logic, Candidate/Liquidity/Sweep/OB/Entry
