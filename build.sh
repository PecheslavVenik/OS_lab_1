#!/bin/bash

echo "========================================"
echo "Build Script for Linux"
echo "========================================"

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Проверка наличия git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed${NC}"
    exit 1
fi

# Проверка наличия cmake
if ! command -v cmake &> /dev/null; then
    echo -e "${RED}Error: CMake is not installed${NC}"
    exit 1
fi

# Проверка наличия g++
if ! command -v g++ &> /dev/null; then
    echo -e "${RED}Error: g++ is not installed${NC}"
    exit 1
fi

# Обновление из git репозитория
echo
echo "Updating from Git repository..."
git pull origin main
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}Warning: Failed to pull from git repository${NC}"
    echo "Continuing with local version..."
fi

# Создание директории для сборки
if [ ! -d "build" ]; then
    mkdir build
fi

# Переход в директорию сборки
cd build

# Генерация проекта с помощью CMake
echo
echo "Configuring project with CMake..."
cmake ..
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: CMake configuration failed${NC}"
    cd ..
    exit 1
fi

# Компиляция проекта
echo
echo "Building project..."
make -j$(nproc)
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Build failed${NC}"
    cd ..
    exit 1
fi

# Возврат в корневую директорию
cd ..

echo
echo -e "${GREEN}========================================"
echo "Build completed successfully!"
echo "Executable: build/bin/HelloWorld"
echo -e "========================================${NC}"

# Запуск программы
echo
echo "Running the program..."
echo
./build/bin/HelloWorld