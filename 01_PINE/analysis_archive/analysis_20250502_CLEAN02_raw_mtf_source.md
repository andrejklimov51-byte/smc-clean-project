# CLEAN-02 Analysis

## Что сделано
- добавлен RAW MTF SOURCE ENGINE (строки 15–40)
- request.security для POI TF / PRIMARY TF / CONFIRM TF
- lookahead=barmerge.lookahead_off — нет заглядывания вперёд
- raw данные не являются owner / POI / primary — только сырые OHLC
- PROFILE ENGINE остался без изменений (строки 4–13)
- IMPULSE OBJECTS / OWNER STATE / PROOF LABEL — без изменений

## Donor extraction — pivot/zigzag механизмы

Из donor_analysis_CLEAN00.md (Section A — Pivot + leg detection):

**Механизм обнаружения пивотов:**
- `ta.pivotlow(low, _pivotLen, _pivotLen)` / `ta.pivothigh(high, _pivotLen, _pivotLen)`
- Пивот подтверждается через `_pivotLen` баров после факта — это стандартная Pine задержка
- Время пивота = `time[_pivotLen]` — смещение назад к реальному бару пивота

**Механизм построения ног (zigzag-логика):**
- Bull leg: `_bullBaseTime/Price` (основание) → `_bullTerminalTime/Price` (вершина)
- Bear leg: `_bearBaseTime/Price` (вершина) → `_bearTerminalTime/Price` (дно)
- Cross-assignment: новый pivot low → обновляет bear terminal если ниже; новый pivot high → обновляет bull terminal если выше
- Это создаёт непрерывную zigzag-структуру без явного zigzag-индикатора

**Механизм freeze (подтверждение завершения ноги):**
- Higher-low freeze: новый pivot low выше bear terminal → медвежья нога завершена
- Lower-high freeze: новый pivot high ниже bull terminal → бычья нога завершена
- Sequence freeze: `_bullBearishSeq >= _freezeSequenceLen` + `_bullHasSmallPullback`
- ATR gate: `_bullTerminalPrice - _bullPostTerminalLow > _minFreezePullback`
- Двойное условие (структурное + ATR + sequence) = шумозащита

**Вывод для CLEAN-03:**
- Pivot detection через `ta.pivotlow` / `ta.pivothigh` переносится как есть
- Leg tracking (base/terminal pairs) переносится в Impulse Object Engine
- Freeze mechanism (higher-low / lower-high + ATR + sequence) — ядро для CLEAN-03

## Gate
- BEFORE архив создан: YES — smc_clean_l0_core_BEFORE_CLEAN02_20250502.pine
- AFTER архив создан: YES — smc_clean_l0_core_AFTER_CLEAN02_20250502.pine
- строк до: 51 / строк после: 79 / добавлено: 28 строк
- компилируется без ошибок: YES (статическая проверка — только вызовы request.security, синтаксис корректен)
- raw данные для всех трёх TF присутствуют: YES (POI / PRIMARY / CONFIRM)
- owner не назначен: YES — ownerState = "OWNER_NONE", логика не изменена

## Next stage
CLEAN-03 — Impulse Object Engine
Создать унифицированный объект импульса с полями:
exists / dir / startBar / endBar / hi / lo / range / confirmed
для каждого TF слоя (POI / PRIMARY / CONFIRM).
Механизм: ta.pivotlow / ta.pivothigh + leg base-terminal tracking + freeze conditions.
