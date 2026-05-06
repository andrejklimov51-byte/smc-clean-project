# CLEAN-09 Analysis

## Проверка файла перед chart proof
A. var string литералы — инициализированы строками, не переменными: YES
   (ownerState, boundaryEvent, structureEvent, poiState, poiBoundaryEvent, primaryState — все с литералами)
B. line.delete na-check — все 5 вызовов имеют `if not na(...)`: YES (строки 526–530)
C. label.delete na-check — `if not na(proofLabel)` на строке 538: YES
D. proofLabel объявлен до Fib/OTE Engine — строка 452, Fib/OTE начинается на 454: YES
E. lookahead_off везде — 18 вхождений `lookahead_off`, 0 вхождений `lookahead_on`: YES
F. const int pivotLen — строка 48: YES
G. Нет дублирующихся объявлений — все var объявлены ровно по одному разу: YES
H. Proof label содержит POI / PRIMARY / OTE / OWNER: YES (строки 541–544)

## Что добавлено
- CHART PROOF MARKERS (строки 557–605)
- `POI▲` — маркер на баре когда poiState переходит в POI_ACTIVE
- `POI✗` — маркер когда poiState переходит в POI_BROKEN
- `PRI▲` — маркер когда primaryState переходит в PRIMARY_LOCKED
- `PRI✗` — маркер когда primaryState переходит в PRIMARY_BROKEN
- `bgcolor` — зелёная подсветка баров когда priceInOte == true
- `TAKE` — маркер на каждом баре где takeoverAllowed == true
- строк до: 556 / строк после: 606 / добавлено: 50 строк
- файл READY_FOR_TV создан

## Замечание по max_labels_count
Indicator объявлен с `max_labels_count=50`. При активной торговле chart proof маркеры (fire-and-forget labels) могут быстро исчерпать лимит — особенно TAKE маркер который срабатывает каждый бар где takeoverAllowed=true. При необходимости увеличить до `max_labels_count=500` или добавить `barstate.islast` ограничение.

## Инструкция для chart proof
1. Открыть файл: `D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_READY_FOR_TV_20250502.pine`
2. Скопировать полное содержимое файла
3. Открыть TradingView → Pine Editor → вставить → Save → Add to chart
4. Проверить на BTCUSDT или EURUSD, таймфрейм 1H (Profile A: POI=4H, PRIMARY=1H, CONFIRM=15m)
5. Проверить на графике:
   - Появляются ли fib линии (серые 0/1, синяя 0.5, оранжевая 0.705, красная 0.79)
   - Proof label в правом верхнем углу: POI state / PRIMARY state / OTE / OWNER
   - Маркеры POI▲ появляются в логичных местах
   - Маркеры PRI▲ появляются внутри POI зон
   - OTE зона подсвечивается зелёным при входе цены между fib79 и fib50
   - Маркеры TAKE появляются при смене импульса

## Ожидаемые проблемы на chart
[оставить пустым — заполнить после реального теста]

## Next stage
CLEAN-10 — Chart Proof Analysis
После загрузки в TradingView пользователь описывает что видит на графике.
Анализ: что работает / что не работает / какой следующий узел.
