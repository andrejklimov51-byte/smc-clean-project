# CLEAN-25 ACTION LOG

## Дата
2026-05-06

## Задача
Исправить порядок объявления переменных primPendStartBar и primPendTermBar

## Проблема
Переменные использовались в строках 110-160 ДО их объявления в строке 177-178

## Исправление
Перенесены объявления:
```pine
var int primPendStartBar = na
var int primPendTermBar  = na
```

Из строки 177-178 в строку 98-99 (после primCompletedNow, перед первым использованием)

## Результат компиляции
✅ SUCCESS — ошибок нет

## Файлы
- BEFORE: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_BEFORE_CLEAN25_2026-05-06.pine
- AFTER: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_AFTER_CLEAN25_2026-05-06.pine
- CORE: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
