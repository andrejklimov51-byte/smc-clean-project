# CLEAN-29 ACTION LOG

## Дата
2026-05-07

## Задача
Диагностика POI линий — добавить poiBase и poiTerminal в proof label

## Исправление
Добавлены строки в proofText (строки 760-761):
```pine
"poiBase: " + str.tostring(poiBase, "#.##") + "\n" +
"poiTerm: " + str.tostring(poiTerminal, "#.##") + "\n" +
```

## Результат компиляции
✅ SUCCESS — ошибок нет

## Диагностика
Proof label на ETH 1H показывает:
- poiState: POI_ACTIVE
- poiHi: 2332.49
- poiLo: 2060.80
- poiBase: 2060.80
- poiTerm: 2332.49

**Проблема:** POI линии не видны на графике, хотя значения корректные (не na).

**Гипотеза:** Условие отрисовки POI линий (строка 663) `if poiState == POI_ACTIVE and not na(poiHi) and not na(poiLo)` выполняется, но линии не рисуются. Возможные причины:
1. Линии рисуются за пределами видимой области графика
2. Линии перекрываются другими объектами
3. Проблема с bar_index в координатах линий

## Файлы
- BEFORE: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_BEFORE_CLEAN29_2026-05-07.pine
- AFTER: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_AFTER_CLEAN29_2026-05-07.pine
- CORE: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
- Screenshot: D:\SMC_PROJECT_CLEAN\eth_1h_clean29_proof.png
