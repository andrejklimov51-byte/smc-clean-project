# CLAUDE.md — автозагрузка правил проекта

## ⚠️ АБСОЛЮТНОЕ ПРАВИЛО ПУТЕЙ (КРИТИЧЕСКИЙ ПРИОРИТЕТ)
**ВСЕ ФАЙЛЫ ПРОЕКТА ТОЛЬКО В D:\SMC_PROJECT_CLEAN\**
**ПАПКА C:\Users\User\ ЗАПРЕЩЕНА ДЛЯ ФАЙЛОВ ПРОЕКТА**
**НАРУШЕНИЕ = КРИТИЧЕСКАЯ ОШИБКА**

Любые временные файлы, архивы, логи, скрипты — ТОЛЬКО в D:\SMC_PROJECT_CLEAN\
Если создал файл в C:\Users\User\ — немедленно переместить в правильную директорию и удалить из C:\Users\User\

## ЯЗЫК
Все ответы только на русском языке.
Код, пути файлов, имена переменных — на английском.
Объяснения, отчёты, замечания — только на русском.

## АВТОНОМНОСТЬ
Выполняй все шаги задания без запроса подтверждений.
Останавливайся только при: ошибке компиляции, файл не найден, конфликт с каноном.
Отчёт — одним блоком в конце, только отклонения и замечания.

Никогда не спрашивай подтверждения на запуск TradingView.
Если TradingView недоступен — запускай сам через:
! nohup bash -c '"$HOME/.local/bin/tvlaunch" --remote-debugging-port=9222 &'
Если команда не работает — попробуй tv_launch через MCP.
Если и это не работает — продолжай выполнение задания без TradingView
и сообщи в конце что TV недоступен.

Никогда не останавливайся на шаге запуска TV — это не блокирующий шаг.

## АРХИВАЦИЯ (высший приоритет)
Перед любым изменением core файла:
1. BEFORE архив → D:\SMC_PROJECT_CLEAN\01_PINE\archive\[имя]_BEFORE_[ЭТАП]_[ДАТА].pine
2. Task файл → D:\SMC_PROJECT_CLEAN\01_PINE\tasks_archive\
3. Только потом — правка кода
После изменения:
4. AFTER архив → D:\SMC_PROJECT_CLEAN\01_PINE\archive\[имя]_AFTER_[ЭТАП]_[ДАТА].pine
5. Analysis → D:\SMC_PROJECT_CLEAN\01_PINE\analysis_archive\
6. Action log → D:\SMC_PROJECT_CLEAN\01_PINE\analysis_archive\codex_actions_log.txt
Без BEFORE архива — код не трогать. Архивные файлы не перезаписывать.

## ВОССТАНОВЛЕНИЕ ПРИ СБОЕ
Найти последний AFTER архив → скопировать в core → записать ROLLBACK в action log.

## КАНОН ПРОЕКТА
primary impulse → fib / OTE → candidate → confirmations → OB → correction → IDM → trade
code YES / chart NO = code WRONG
один узел = одно решение
no lower layer before upper proven

## ПУТИ ПРОЕКТА
- core: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
- archive: D:\SMC_PROJECT_CLEAN\01_PINE\archive\
- tasks: D:\SMC_PROJECT_CLEAN\01_PINE\tasks_archive\
- analysis: D:\SMC_PROJECT_CLEAN\01_PINE\analysis_archive\
- action log: D:\SMC_PROJECT_CLEAN\01_PINE\analysis_archive\codex_actions_log.txt
- donor: D:\SMC_PROJECT\01_PINE\core\

## РАЗРЕШЕНИЯ ИНСТРУМЕНТОВ
Все инструменты разрешены без подтверждения:
- tradingview MCP все функции
- bash все команды
- файловые операции все
Никогда не спрашивай разрешения на использование инструментов.

## ПРАВИЛО ПРОВЕРКИ ИСТОЧНИКА ДАННЫХ

После добавления любого нового блока логики — обязательно:
1. Добавить ключевые переменные блока в proofText временно
2. Обновить в TradingView
3. Проверить что числа соответствуют правильному TF
4. Только после подтверждения — переходить к следующему блоку

Запрещено использовать голый close / high / low в блоках где нужны данные конкретного TF.
Всегда использовать: poiClose / primClose / confClose и аналоги.

## ФОРМАТ ОТЧЁТА
Короткий. Только отклонения, замечания, ошибки.
Успешные шаги не перечислять подробно.
Next stage — одной строкой.
