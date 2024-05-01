@echo off
chcp 65001 > nul

:input_directories
rem Запитуємо в користувача шляхи до каталогів
set /p "directories=Введіть шляхи до каталогів (розділені пробілами): "

rem Перевірка, чи введені шляхи не порожні
if "%directories%"=="" (
    echo Потрібно вказати шляхи до каталогів.
    goto input_directories
)

rem Поділ введених шляхів на окремі параметри
for %%d in (%directories%) do (
    call :process_directory %%d
)

pause
exit /b 0

:process_directory
rem Перевірка, чи існує вказаний каталог
if not exist "%1" (
    echo Каталог "%1" не існує.
    exit /b 1
)

rem Запитуємо в користувача ім'я підкаталога
set /p "subdirectory=Введіть ім'я підкаталога для каталогу %1: "

rem Перевірка, чи введене ім'я підкаталога не порожнє
if "%subdirectory%"=="" (
    echo Потрібно вказати ім'я підкаталога.
    goto process_directory
)

rem Перевірка, чи існує підкаталог з вказаним ім'ям
if not exist "%1\%subdirectory%" (
    echo Підкаталог з ім'ям "%subdirectory%" не знайдено у каталозі "%1".
    goto process_directory
)

rem Перевірка атрибутів каталогу
for /f "tokens=2 delims= " %%A in ('attrib "%1\%subdirectory%" ^| findstr /i "H"') do (
    set attribs=%%A
)

echo -----------------------------
echo Каталог: %1\%subdirectory%

rem Перевірка, чи має каталог атрибут "прихований"
if "%attribs%"=="" (
    echo Каталог не є прихованим.
) else (
    echo Каталог є прихованим.
)

rem Перевірка, чи має каталог атрибут "тільки читання"
echo %attribs% | findstr /i "R" >nul
if errorlevel 1 (
    echo Каталог не має атрибуту "тільки читання".
) else (
    echo Каталог має атрибут "тільки читання".
)

rem Перевірка, чи має каталог атрибут "архівний"
echo %attribs% | findstr /i "A" >nul
if errorlevel 1 (
    echo Каталог не є архівним.
) else (
    echo Каталог є архівним.
)

exit /b 0




