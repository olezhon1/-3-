@echo off
chcp 65001 > nul

rem Створення текстового файлу у не прихованій папці
echo Текст для файлу > "Не прихована папка\copyhelp.txt"

xcopy /? > "Не прихована папка\copyhelp.txt"

rem Копіювання файлу в приховану папку
xcopy "Не прихована папка\copyhelp.txt" "Прихована папка\copied_copyhelp.txt" /Y
