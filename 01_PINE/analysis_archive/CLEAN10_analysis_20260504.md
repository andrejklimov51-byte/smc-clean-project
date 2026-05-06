# CLEAN-10 Analysis — 2026-05-04

## Проблема
POI_BROKEN срабатывал немедленно после POI_ACTIVE на том же или следующем баре.
Причина: отсутствие временного буфера между активацией и возможностью слома.

## Правки

### 1. var int poiActivatedBar = na
Добавлена переменная-счётчик после блока объявления POI объекта (после `var float poiLo`).

### 2. poiActivatedBar := bar_index при переходе в POI_ACTIVE
Присвоение добавлено в **трёх** местах:
- NONE/SEARCH → ACTIVE (первичная активация)
- STALE → ACTIVE (замена устаревшего POI)
- REPLACED → ACTIVE (после замены сломанного POI)

### 3. BROKEN condition — guard 5 баров
```pine
if poiState == POI_ACTIVE and poiStructureEvent == "STRUCTURE_BREAK"
    if not na(poiActivatedBar) and (bar_index - poiActivatedBar) >= 5
        poiState := POI_BROKEN
```
Слом невозможен раньше 5 баров после активации.

### 4. Proof label — строка "POI баров"
Добавлена после строки POI state для визуальной диагностики возраста POI.

## Замечания
- `poiActivatedBar` сбрасывается при каждом новом переходе в ACTIVE, включая REPLACED→ACTIVE.
  Это корректно: каждый новый POI отсчитывает собственные 5 баров.
- Условие `not na(poiActivatedBar)` защищает от ложного срабатывания при na на старте.
