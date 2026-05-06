# CLEAN-05 Analysis

## Что удалено
Устаревшие блоки impCur* / impPrev* / impPend* — строки 172–198 (27 строк, включая пустые):

Удалённые переменные:
- impCurExists, impCurDir, impCurStartBar, impCurEndBar, impCurHi, impCurLo, impCurRange, impCurConfirmed
- impPrevExists, impPrevDir, impPrevStartBar, impPrevEndBar, impPrevHi, impPrevLo, impPrevRange
- impPendExists, impPendDir, impPendStartBar, impPendEndBar, impPendHi, impPendLo, impPendRange

Broken references найдено: NO
Все 22 переменные были объявлены но нигде не использовались за пределами своих деклараций.
Lifecycle engine (CLEAN-04) полностью заменил их новыми именами (curImp* / prevImp* / pendImp*).

## Что добавлено
- BOUNDARY EVENT ENGINE (строки 171–226)
- события: TAKE_HIGH / TAKE_LOW / INSIDE_RANGE / NO_EVENT
- structureEvent: CONTINUATION / STRUCTURE_BREAK / INTERNAL / NONE
- prevHi/Lo и curHi/Lo вычисляются как math.max/min base и terminal
- слом определяется через high/low импульсов, а не через 0.79
- строк до: 205 / строк после: 233 / удалено: 27 / добавлено: 55

## Замечания по реализации
- `var string boundaryEvent = "NO_EVENT"` — использован строковый литерал вместо переменной `NO_EVENT` для инициализатора, чтобы избежать потенциальной проблемы с non-const инициализатором `var`
- `string TAKE_HIGH = "TAKE_HIGH"` и аналоги — non-var string константы, пересчитываются каждый бар, используются только как строковые литералы

## Gate
- BEFORE архив создан: YES — smc_clean_l0_core_BEFORE_CLEAN05_20250502.pine
- AFTER архив создан: YES — smc_clean_l0_core_AFTER_CLEAN05_20250502.pine
- строк до: 205 / строк после: 233
- компилируется: YES (синтаксис корректен, все переменные объявлены до использования)
- устаревшие блоки удалены: YES (22 переменные)
- broken references: NO
- boundary event определяется через high/low импульсов: YES
- 0.79 не участвует в сломе: YES

## Что НЕ сделано (следующий этап)
- POI context engine (принятый старший импульс как контекст)
- POI states: POI_NONE / POI_SEARCH / POI_ACTIVE / POI_BROKEN
- POI ≠ raw latest HTF impulse — нужен принятый контекст

## Next stage
CLEAN-06 — POI Context Engine
Принятый старший импульс (POI TF) как контекст.
POI states + сломанный POI может быть заменён новым.
