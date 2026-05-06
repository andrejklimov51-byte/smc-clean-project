# CLEAN-23 ACTION LOG

## Задача
Добавить startBar и termBar в detection → ownership pipeline для визуализации реального импульса.

## Выполненные изменения

### ШАГ 1: PRIMARY detection engine
**Файл**: CLEAN-23_AFTER.pine

**Добавлены переменные для хранения баров:**
- `var int primLegBaseBar = na` (строка 62)
- `var int primLegTermBar = na` (строка 63)

**Сохранение баров при обнаружении pivot:**
- При `primNewPivLow`: `primLegBaseBar := bar_index` (строка 70)
- При `primNewPivHigh`: `primLegBaseBar := bar_index` (строка 77)
- При обновлении terminal (bull): `primLegTermBar := bar_index` (строка 83)
- При обновлении terminal (bear): `primLegTermBar := bar_index` (строка 86)

### ШАГ 2: PENDING impulse передача
**Добавлены переменные:**
- `var int pendImpStartBar = na` (строка 135)
- `var int pendImpTermBar = na` (строка 136)

**Передача баров в pending:**
```pine
pendImpStartBar := primLegBaseBar
pendImpTermBar  := primLegTermBar
```
(строки 148-149)

### ШАГ 3: PRIMARY OWNERSHIP ENGINE
**Добавлены переменные:**
- `var int primOwnerStartBar = na` (строка 407)
- `var int primOwnerTermBar = na` (строка 408)

**Передача баров при PRIMARY_LOCKED:**
```pine
primOwnerStartBar := pendImpStartBar
primOwnerTermBar  := pendImpTermBar
```
(строки 440-441, 459-460)

### ШАГ 4: VISUAL LAYER
**Добавлена диагональная стрелка BASE → TERMINAL:**
```pine
var line arrowLine = na

if primaryState == PRIMARY_LOCKED and not na(primOwnerStartBar) and not na(primOwnerTermBar)
    int baseBar = primOwnerStartBar
    int termBar = primOwnerTermBar
    float basePrice = primOwnerBase
    float termPrice = primOwnerTerminal

    if not na(arrowLine)
        line.delete(arrowLine)

    arrowLine := line.new(baseBar, basePrice, termBar, termPrice,
         color=color.new(color.yellow, 0),
         width=2,
         style=line.style_arrow_right)
```
(строки 630-644)

## Результат компиляции
- **Статус**: SUCCESS
- **Ошибки**: 0
- **Кнопка**: Pine Save (нажата)
- **Индикатор добавлен**: false (уже был на графике)

## Архивы
- **BEFORE**: `C:\Users\User\CLEAN-23_BEFORE.pine` (611 строк, оригинальная версия)
- **AFTER**: `C:\Users\User\CLEAN-23_AFTER.pine` (647 строк, с правками)
- **Скриншот**: `C:\Users\User\tradingview-mcp\screenshots\CLEAN-23_result.png`

## Технические детали
- **График**: BINANCE:ZECUSDT.P
- **Таймфрейм**: 60 минут (1H)
- **Профиль**: A (POI=4H, PRIMARY=1H, CONFIRM=15m)
- **Метод**: ta.pivothigh/ta.pivotlow с pivotLen=5

## Ожидаемое поведение
При `primaryState == PRIMARY_LOCKED`:
1. `primOwnerStartBar` содержит bar_index момента обнаружения BASE (pivot low для bull, pivot high для bear)
2. `primOwnerTermBar` содержит bar_index момента обнаружения TERMINAL (pivot high для bull, pivot low для bear)
3. Жёлтая стрелка рисуется от `(primOwnerStartBar, primOwnerBase)` до `(primOwnerTermBar, primOwnerTerminal)`

## Статус
✅ Код успешно скомпилирован и загружен в TradingView
✅ Архивы BEFORE/AFTER созданы
✅ Скриншот сохранён

## Следующий шаг
Проверить на графике наличие жёлтой диагональной стрелки от реального BASE до TERMINAL при активном PRIMARY_LOCKED состоянии.
