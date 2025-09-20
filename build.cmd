@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Build Script for Windows
echo ========================================

:: Проверка наличия git
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Git is not installed or not in PATH
    exit /b 1
)

:: Проверка наличия cmake
where cmake >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: CMake is not installed or not in PATH
    exit /b 1
)

:: Обновление из git репозитория
echo.
echo Updating from Git repository...
git pull origin main
if %errorlevel% neq 0 (
    echo Warning: Failed to pull from git repository
    echo Continuing with local version...
)

:: Создание директории для сборки
if not exist build (
    mkdir build
)

:: Переход в директорию сборки
cd build

:: Генерация проекта с помощью CMake
echo.
echo Configuring project with CMake...
cmake .. -G "MinGW Makefiles"
if %errorlevel% neq 0 (
    echo Error: CMake configuration failed
    cd ..
    exit /b 1
)

:: Компиляция проекта
echo.
echo Building project...
cmake --build . --config Debug
if %errorlevel% neq 0 (
    echo Error: Build failed
    cd ..
    exit /b 1
)

:: Возврат в корневую директорию
cd ..

echo.
echo ========================================
echo Build completed successfully!
echo Executable: build\bin\HelloWorld.exe
echo ========================================

:: Запуск программы
echo.
echo Running the program...
echo.
build\bin\HelloWorld.exe

pause