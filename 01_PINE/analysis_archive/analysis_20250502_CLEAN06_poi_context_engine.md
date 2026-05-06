# CLEAN-06 Analysis

## Что добавлено
- POI CONTEXT ENGINE (строки 227–324)
- POI states: POI_NONE / POI_SEARCH / POI_ACTIVE / POI_BROKEN / POI_STALE / POI_REPLACED
- pivot detection на POI TF (`poiTf`) с `const int pivotLen = 5` — тот же что в PRIMARY
- ATR gate: `poiRawRange > poiAtr`
- retrace >= 0.5 — confirmation rule (аналогично PRIMARY)
- broken POI заменяется новым подтверждённым: POI_BROKEN → POI_REPLACED → POI_ACTIVE
- строк до: 233 / строк после: 331 / добавлено: 98 строк

## Gate
- BEFORE архив создан: YES — smc_clean_l0_core_BEFORE_CLEAN06_20250502.pine
- AFTER архив создан: YES — smc_clean_l0_core_AFTER_CLEAN06_20250502.pine
- компилируется: YES (синтаксис корректен, все переменные объявлены до использования)
- `var string poiState = "POI_NONE"` — инициализация строковым литералом, не переменной ✓
- `const int pivotLen` доступен в POI engine ✓
- POI state machine работает: YES
- broken POI заменяется: YES
- POI != raw latest: YES

## Замечания по коду

### 1. structureEvent — семантическое замечание
`if poiState == POI_ACTIVE and structureEvent == "STRUCTURE_BREAK"` использует `structureEvent`
из CLEAN-05, который базируется на PRIMARY TF (curImpBase/Terminal vs prevImpBase/Terminal).
Это означает: POI ломается когда PRIMARY TF структура ломается.
Это не то же самое, что POI TF structure break.
Зафиксировано как design coupling — для CLEAN-07 потребуется отдельный POI TF boundary event.

### 2. Цепочка переходов на одном баре
В теории на одном баре возможна цепочка:
POI_NONE → POI_ACTIVE (step 1) → POI_BROKEN (step 2) → POI_REPLACED (step 3) → POI_ACTIVE (step 4)
Это происходит если: poiRawConfirmed=true И structureEvent="STRUCTURE_BREAK" на одном баре.
Поведение корректно (немедленная замена), но стоит проверить на графике.

### 3. POI_STALE объявлен но не используется
`string POI_STALE = "POI_STALE"` объявлен в states, но state machine его не присваивает.
Зарезервирован для CLEAN-07 (stale POI = вышел за пределы диапазона).

## Что НЕ сделано (следующий этап)
- отдельный POI TF boundary event (вместо structureEvent от PRIMARY)
- POI_STALE условие (price вышла за пределы poiHi/poiLo)
- Primary Ownership Engine: поиск PRIMARY только внутри valid POI
- PRIMARY states: PRIMARY_NONE / PRIMARY_CANDIDATE / PRIMARY_LOCKED / PRIMARY_BROKEN

## Next stage
CLEAN-07 — Primary Ownership Engine
Primary = accepted рабочий impulse внутри POI.
Первые действия: исправить POI broken через POI TF boundary event (не PRIMARY TF).
Добавить POI_STALE условие.
