# CLEAN-00 Analysis

## Active file state
- file: smc_core_detector_L0_completion_rule_reachable.pine
- state per task prescription: STATE E (legacy engine present, no role profile, no finalFibLine*)
- CORRECTION: Stage 0 fresh audit (2026-05-02) confirmed actual state = STATE G
  (role-based profile locked, all finalFibLine* present, dominance contract present, legacy ABSENT)
- See full audit: C:\SMC_PROJECT\01_PINE\analysis_archive\analysis_STAGE0_full_state_audit.md
- legacy present: NONE (all legacy markers absent in actual file)
- role profile: PRESENT in actual file
- dominance contract: PRESENT in actual file

## Decision
- do NOT repair old file
- start clean rebuild in C:\SMC_PROJECT_CLEAN
- reason: fresh multi-profile architecture from zero is cleaner than extending a 966-line file
- donor ideas extracted to donor_analysis_CLEAN00.md

## Next stage
CLEAN-02 — Raw MTF Source Engine
Add request.security for POI / PRIMARY / CONFIRM timeframes from profile.
Gate: raw impulse data visible per TF, no owner assigned yet.
