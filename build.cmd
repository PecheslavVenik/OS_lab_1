@echo off
setlocal enabledelayedexpansion

echo ========================================
echo СКРИПТ_ДЛЯ_ШИНДОУС.cmd
echo ========================================

where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Гит не установлен
    exit /b 1
)

where cmake >nul 2>nul
if %errorlevel% neq 0 (
    echo Симейк не установлен
    exit /b 1
)

echo.
echo Пулл из гит репозитория...
git pull origin main
if %errorlevel% neq 0 (
    echo Нет интернета или ошибка гита.
    echo Продолжаем так ладно
)

if not exist build (
    mkdir build
)

cd build

echo.
echo Симейк конфигуринг проджект...
cmake .. -G "MinGW Makefiles"
if %errorlevel% neq 0 (
    echo Симейк конфигуринг провален
    cd ..
    exit /b 1
)

echo.
echo Сборка...
cmake --build . --config Debug
if %errorlevel% neq 0 (
    echo Сборка провалена
    cd ..
    exit /b 1
)

cd ..

echo.
echo ========================================
echo Биллд завершен успешно!
echo Exе: build\lab1.exe
echo ========================================

echo.
echo Раннинг the program...
echo.
build\lab1.exe

pause