# CLEAN-31 ACTION LOG

## Дата
2026-05-07

## Задача
Исправить runtime ошибку "Bar index value too far" в PRIMARY стрелке

## Проблема
После CLEAN-30 появилась runtime ошибка на баре 10087:
```
Error on bar 10087: Bar index value of the `x1` argument (86) in `line.new()` is too far from the current bar index.
at #main():739
```

Причина: primOwnerStartBar и primOwnerTermBar это var переменные которые сохраняют значения с начала истории (bar 86). На баре 10087 разница ~10000 баров превышает лимит Pine Script (~500 баров).

## Исправление
Изменены координаты PRIMARY стрелки (строки 737-739):

**БЫЛО:**
```pine
int baseBar = na(primOwnerStartBar) ? bar_index - 50 : primOwnerStartBar
int termBar = na(primOwnerTermBar)  ? bar_index - 10 : primOwnerTermBar
primArrow   := line.new(baseBar, drawFib0, termBar, drawFib100, ...)
```

**СТАЛО:**
```pine
int baseBar = bar_index - 50
int termBar = bar_index - 10
primArrow   := line.new(baseBar, drawFib0, termBar, drawFib100, ...)
```

Теперь стрелка рисуется от фиксированных смещений (50 и 10 баров назад) вместо использования исторических var значений.

## Результат компиляции
✅ SUCCESS — ошибок нет

## Примечание
Индикатор не удалось добавить на график через UI после компиляции. Код скомпилирован и сохранён (version 26.0), но требуется ручное добавление через меню индикаторов или перезапуск TradingView.

## Файлы
- BEFORE: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_BEFORE_CLEAN31_2026-05-07.pine
- AFTER: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_AFTER_CLEAN31_2026-05-07.pine
- CORE: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
