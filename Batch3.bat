@echo off
chcp 65001 > nul
rem Запитуємо в користувача шлях до каталогу
set /p directory=Введіть шлях до каталогу: 

rem Перевірка, чи введений шлях не порожній
if "%directory%"=="" (
    echo Потрібно вказати шлях до каталогу.
    exit /b 1
)

rem Запитуємо в користувача ім'я підкаталога
set /p subdirectory=Введіть ім'я підкаталога: 

rem Перевірка, чи введене ім'я підкаталога не порожнє
if "%subdirectory%"=="" (
    echo Потрібно вказати ім'я підкаталога.
    exit /b 1
)

rem Перевірка, чи існує вказаний каталог
if not exist "%directory%" (
    echo Вказаний каталог не існує.
    exit /b 1
)

rem Перевірка, чи існує підкаталог з вказаним ім'ям
if not exist "%directory%\%subdirectory%" (
    echo Підкаталог з ім'ям "%subdirectory%" не знайдено у каталозі "%directory%".
    exit /b 1
)

rem Перевірка атрибутів файлу
for %%A in ("%directory%\%subdirectory%") do (
    set attribs=%%~aA
)

rem Перевірка, чи має підкаталог атрибут "прихований"
echo %attribs% | findstr /i "h" >nul
if errorlevel 1 (
    echo Підкаталог не є прихованим.
) else (
    echo Підкаталог є прихованим.
)

rem Перевірка, чи має підкаталог атрибут "тільки читання"
echo %attribs% | findstr /i "r" >nul
if errorlevel 1 (
    echo Підкаталог не має атрибуту "тільки читання".
) else (
    echo Підкаталог має атрибут "тільки читання".
)

rem Перевірка, чи має підкаталог атрибут "архівний"
echo %attribs% | findstr /i "a" >nul
if errorlevel 1 (
    echo Підкаталог не є архівним.
) else (
    echo Підкаталог є архівним.
)

pause
exit /b 0
