# CLEAN-26 ACTION LOG

## Дата
2026-05-06

## Задача
Рисовать fib линии и стрелку из памяти при PRIMARY_BROKEN

## Проблема
При PRIMARY_BROKEN визуализация исчезала, хотя fib уровни сохранялись в памяти (fibMem). Условие `primaryState == PRIMARY_LOCKED` не позволяло отрисовывать линии после слома структуры.

## Исправление
Изменено условие отрисовки PRIMARY визуализации (строка 717):

**БЫЛО:**
```pine
if primaryState == PRIMARY_LOCKED and not na(fib0)
```

**СТАЛО:**
```pine
bool primVisActive = (primaryState == PRIMARY_LOCKED or primaryState == PRIMARY_BROKEN) and not na(drawFib0)

if primVisActive
```

Также заменены все `fib0`, `fib50`, `fib705`, `fib79`, `fib100` на `drawFib0`, `drawFib50`, `drawFib705`, `drawFib79`, `drawFib100` для использования значений из памяти.

## Результат компиляции
✅ SUCCESS — ошибок нет

## Визуализация
Теперь при PRIMARY_BROKEN:
- Fib линии остаются видимыми (из fibMem)
- Синяя стрелка от BASE до TERMINAL видна
- OTE зона подсвечивается
- Метка "СЛОМ 1H" появляется при переходе LOCKED → BROKEN

## Файлы
- BEFORE: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_BEFORE_CLEAN26_2026-05-06.pine
- AFTER: D:\SMC_PROJECT_CLEAN\01_PINE\archive\smc_clean_l0_core_AFTER_CLEAN26_2026-05-06.pine
- CORE: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
- Screenshot: D:\SMC_PROJECT_CLEAN\screenshot_eth2.png
