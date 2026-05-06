# CLEAN-01 Stage Analysis

## 1. Active clean file verification

- Verified file:
  `D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine`
- Line count:
  `102`
- Single active `.pine` in clean core:
  YES
- CLEAN-00-R baseline markers:
  PASS
- Forbidden logic markers in active clean file:
  absent

## 2. Snapshot path

- `D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_20260504_1725_snapshot_clean_01_donor_extraction.pine`

## 3. Donor files scanned

- Total donor `.pine` scanned:
  `276`
- Relevant donor docs matched in `tasks_archive` and `analysis_archive`:
  `326`

## 4. Donor classification summary

- Working legacy donor family:
  PRE_CORE lifecycle / rearm / promotion / rollback files
- Fixed-MTF partial donor family:
  role-profile-lock and stage 7.1 post-none-rearm files
- Visual-only donor family:
  stage 7.2 RU / trace / fib-visual persistence files
- Degraded current branch family:
  final branch with fixed MTF mixed with 0.79, protected debug and fib memory
- Invalid mixed family:
  chart-timeframe-routed MTF files
- Unknown:
  early v4-v8 / PRE_L0 / PRE_L2 / layer1 families outside clean L0 donor target

## 5. Main donor candidates

1. `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_first_layer_sequential_engine_verification.pine` — `384` lines — previous/current/next lifecycle
2. `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_rearm_next_impulse_architecture.pine` — `515` lines — rearm
3. `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_first_layer_next_to_primary_promotion_fix.pine` — `522` lines — promotion next -> current
4. `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_PRE_CORE_first_layer_mtf_previous_current_break_rollback_architecture.pine` — `701` lines — rollback / break persistence
5. `D:\SMC_PROJECT\01_PINE\archive\smc_core_detector_L0_completion_rule_reachable_20260502_1634_after_stage_7_2p_r_fib_visual_proof_ru_repair.pine` — `965` lines — visual-only later

## 6. Useful algorithms found

- previous impulse memory via explicit snapshot copy from current before promotion
- current active impulse as separate object with start/end/high/low/range/dir
- next impulse search with separate next object and `NEXT SEARCH` / `NEXT CONFIRM`
- rearm as separate state preserving current while resetting next search
- promotion next -> current with deterministic copy order
- rollback as break event -> previous restore -> next clear -> rearm restart
- persistent break visual with stored break price/time/dir
- LAST ONLY visual cleanup through centralized deletion before redraw

## 7. Discarded ideas

- chart-dependent MTF
- auto profile by display TF
- recency-only takeover
- 0.79 as final break
- protected debug line as break authority
- fib memory as owner
- visual labels as logic source
- Candidate / Sweep / OB / Entry legacy carry-over

## 8. Mapping completed

- Donor-to-clean-canon mapping:
  YES
- Clean engine dependency table:
  YES

## 9. Code changed

- NO

## 10. Next allowed stage

- `CLEAN-02 PROFILE ENGINE`
