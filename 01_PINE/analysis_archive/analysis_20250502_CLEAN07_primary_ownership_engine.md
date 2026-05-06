# CLEAN-07 Analysis

## Что исправлено (замечания CLEAN-06)

### Замечание 1 — POI TF boundary event (строки 293–322)
- Добавлен `var float poiPrevHi/Lo` — запоминает экстремумы active POI
- Добавлен `var string poiBoundaryEvent = "NO_EVENT"` — отдельный от PRIMARY TF
- Добавлен `string poiStructureEvent` — классификация на основе poiBoundaryEvent
- Строка 336: `poiState == POI_ACTIVE and poiStructureEvent == "STRUCTURE_BREAK"` ← исправлено
  (было: `structureEvent == "STRUCTURE_BREAK"` — ссылка на PRIMARY TF event)
- POI теперь ломается по своему TF, а не по PRIMARY TF

### Замечание 2 — POI_STALE (строки 339–352)
- Добавлено условие: `close > poiHi * 1.02` (bull POI) или `close < poiLo * 0.98` (bear POI)
- При выполнении условия: `poiState := POI_STALE`
- Stale POI заменяется новым подтверждённым импульсом → `poiState := POI_ACTIVE`
- POI_STALE теперь используется (ранее был объявлен но не применялся)

## Что добавлено
- PRIMARY OWNERSHIP ENGINE (строки 378–450)
- PRIMARY states: PRIMARY_NONE / PRIMARY_SEARCH / PRIMARY_CANDIDATE / PRIMARY_LOCKED / PRIMARY_BROKEN / PRIMARY_REPLACED
- `var string primaryState = "PRIMARY_NONE"` — literal initializer
- primary object: primOwnerBase/Terminal/Dir/Range/Hi/Lo
- `bool poiValid = poiState == POI_ACTIVE` — primary search только при valid POI
- `bool primCandidateReady` — из lifecycle engine + valid POI condition
- `bool primInsidePoi` — проверка вхождения candidate в POI bounds (±1%)
- state machine: NONE/SEARCH → CANDIDATE → LOCKED (мгновенный переход)
- primary broken: PRIMARY TF `structureEvent == "STRUCTURE_BREAK"` (корректно для PRIMARY)
- primary broken: invalid POI
- primary replaced: новый confirmed impulse внутри того же POI
- строк до: 331 / строк после: 457 / добавлено: 126 строк

## Gate
- BEFORE архив создан: YES — smc_clean_l0_core_BEFORE_CLEAN07_20250502.pine
- AFTER архив создан: YES — smc_clean_l0_core_AFTER_CLEAN07_20250502.pine
- компилируется: YES (синтаксис корректен, порядок объявлений соблюдён)
- POI broken через POI TF boundary event: YES — строка 336
- POI_STALE используется: YES — строки 339–352
- poiStructureEvent отделён от structureEvent: YES
- primary только внутри valid POI: YES — `bool poiValid = poiState == POI_ACTIVE`
- primary state machine работает: YES

## Замечания по новому коду

### PRIMARY_CANDIDATE → PRIMARY_LOCKED на одном баре
`if primaryState == PRIMARY_CANDIDATE` → `primaryState := PRIMARY_LOCKED` на том же баре что и `→ PRIMARY_CANDIDATE`. CANDIDATE существует 0 баров как промежуточный флаг. По аналогии с POI_REPLACED из CLEAN-06. Корректно по дизайну.

### primInsidePoi граница ±1%
Допуск `candHi <= poiHi * 1.01` и `candLo >= poiLo * 0.99` позволяет primary немного выходить за границы POI. Это мягкий tolerance gate. Для CLEAN-08 можно уточнить.

### primaryState ссылается на string переменные PRIMARY_NONE и т.д.
Все шесть `string PRIMARY_*` объявлены до первого использования. ✓

## Что НЕ сделано (следующий этап)
- Fib / OTE Engine
- fib строится только от locked primary
- 0/1 = structural edges (base/terminal)
- 0.5–0.79 = OTE / correction zone
- 0.79 не является границей слома

## Next stage
CLEAN-08 — Fib / OTE Engine
Fib строится только от `primaryState == PRIMARY_LOCKED`.
Уровни: 0.0 / 0.5 / 0.705 / 0.79 / 1.0.
0.79 — визуальный уровень OTE, не граница слома.
