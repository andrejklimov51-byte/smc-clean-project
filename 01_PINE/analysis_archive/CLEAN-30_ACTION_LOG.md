# CLEAN-30 ACTION LOG

## Дата
2026-05-07

## Задача
Исправить визуализацию POI линий — рисовать от poiActivatedBar вместо bar_index-1

## Проблема
POI линии рисовались только на последних 2 барах (bar_index-1 до bar_index), поэтому были невидимы при прокрутке графика влево. Значения poiHi/poiLo были корректными, но линии не отображались.

## Исправление
Изменены координаты POI линий (строки 663-680):

**БЫЛО:**
```pine
poiLine0   := line.new(bar_index-1, poi0,   bar_index, poi0,   extend=extend.right, ...)
poiLine50  := line.new(bar_index-1, poi50,  bar_index, poi50,  extend=extend.right, ...)
poiLine100 := line.new(bar_index-1, poi100, bar_index, poi100, extend=extend.right, ...)
poiArrow   := line.new(bar_index-10, poi0, bar_index, poi100, ...)
```

**СТАЛО:**
```pine
int poiFromBar = na(poiActivatedBar) ? bar_index - 100 : poiActivatedBar
poiLine0   := line.new(poiFromBar, poi0,   bar_index, poi0,   extend=extend.right, ...)
poiLine50  := line.new(poiFromBar, poi50,  bar_index, poi50,  extend=extend.right, ...)
poiLine100 := line.new(poiFromBar, poi100, bar_index, poi100, extend=extend.right, ...)
poiArrow   := line.new(poiFromBar, poi0, bar_index, poi100, ...)
```

## Результат компиляции
✅ SUCCESS — ошибок нет

## Визуализация
Теперь на ETH 1H видны:
- Зелёные пунктирные POI линии на уровнях 2332.49 (верх) и 2060.80 (низ)
- Зелёная стрелка от момента активации POI до текущего бара
- Линии рисуются от poiActivatedBar, поэтому видны на всём протяжении POI_ACTIVE состояния

## Файлы
- BEFORE: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_BEFORE_CLEAN30_2026-05-07.pine
- AFTER: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_AFTER_CLEAN30_2026-05-07.pine
- CORE: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
- Screenshot: D:\SMC_PROJECT_CLEAN\eth_1h_clean30_poi_lines.png
