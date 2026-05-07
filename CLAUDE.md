# CLAUDE.md — SMC PROJECT RULES

## ЯЗЫК
Все ответы только на русском. Код и пути — английский.

## АБСОЛЮТНЫЕ ПРАВИЛА
- Никогда не менять код без явного задания
- Никогда не спрашивать подтверждений
- Все файлы только в D:\SMC_PROJECT_CLEAN\
- Без BEFORE архива — код не трогать
- code YES / chart NO = code WRONG

## КАНОН
primary impulse → OTE → candidate → OB → IDM → trade
candidate = sweep candle, lock immediately
no lower layer before upper proven

## АВТОНОМНЫЙ ЦИКЛ (обязателен после каждого CLEAN)
1. pine_smart_compile через MCP
2. Если ошибка → исправить автоматически → повторить
3. Если после 3 попыток ошибка → СТОП → сообщить
4. Прочитать proof label ETH 1H и BTC 1H
5. Скриншот ETH 1H → D:\SMC_PROJECT_CLEAN\latest_screenshot.png
6. Загрузить скрин: curl -s -X POST "https://api.imgur.com/3/image" -H "Authorization: Client-ID 546c25a59c58ad7" -F "image=@D:/SMC_PROJECT_CLEAN/latest_screenshot.png"
7. Загрузить код: bash /d/SMC_PROJECT_CLEAN/push_to_paste.sh
8. git add . && git commit -m "CLEAN описание" && git push origin main
9. Вывести итог:
   ✅ CLEAN-XX завершён
   КОД: [dpaste URL]
   СКРИН: [imgur URL]
   ETH: POI=[state] PRIMARY=[state] OTE=[да/нет]
   BTC: POI=[state] PRIMARY=[state]

## АВТО-ОТКАТ
Если после компиляции proof label показывает ошибку →
автоматически восстановить последний AFTER архив →
записать ROLLBACK в action log →
сообщить причину

## DEFINITION OF DONE — Layer 0+1
Layer 0+1 считается завершённым когда:
- На ETH 1H видны зелёные POI линии (0/0.5/1)
- На ETH 1H видна синяя PRIMARY стрелка BASE→TERMINAL
- На ETH 1H виден зелёный OTE прямоугольник
- Proof label показывает корректные состояния
- Визуализация совпадает с эталонным скрином пользователя

## ПУТИ
core: D:\SMC_PROJECT_CLEAN\01_PINE\core\smc_clean_l0_core.pine
archive: D:\SMC_PROJECT_CLEAN\01_PINE\archive\
tasks: D:\SMC_PROJECT_CLEAN\01_PINE\tasks_archive\
analysis: D:\SMC_PROJECT_CLEAN\01_PINE\analysis_archive\
log: D:\SMC_PROJECT_CLEAN\01_PINE\analysis_archive\codex_actions_log.txt

## АРХИВАЦИЯ
BEFORE и AFTER архив обязателен для каждого CLEAN.
Формат: smc_clean_l0_core_[BEFORE/AFTER]_CLEAN[N]_[ДАТА].pine

## ПРОФИЛИ
Profile A (display 1H/15m): POI=4H PRIMARY=1H CONFIRM=15m
Profile B (display 4H/1D):  POI=1D PRIMARY=4H CONFIRM=1H
