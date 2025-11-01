#!/bin/bash

echo "========================================"
echo "СКРИПТ_ДЛЯ_ЛИНУКСОВ.sh"
echo "========================================"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if ! command -v git &> /dev/null; then
    echo -e "${RED}Git ис нот инстолд${NC}"
    exit 1
fi

if ! command -v cmake &> /dev/null; then
    echo -e "${RED}CMake ис нот инстолд${NC}"
    exit 1
fi

if ! command -v g++ &> /dev/null; then
    echo -e "${RED}g++ ис нот инстолд${NC}"
    exit 1
fi

echo
echo "git pull origin main..."
git pull origin main
if [ $? -ne 0 ]; then
    echo -e "${YELLOW}Нет интернета...${NC}"
    echo "Продолжаем без пула..."
fi

if [ ! -d "build" ]; then
    mkdir build
fi

cd build

echo
echo "Конфьигуринг проджект виз CMake..."
cmake ..
if [ $? -ne 0 ]; then
    echo -e "${RED}Эррор: CMake конфигурэйшн фэилд${NC}"
    cd ..
    exit 1
fi

echo
echo "Билдинг зе проджект..."
make -j$(nproc)
if [ $? -ne 0 ]; then
    echo -e "${RED}Эррор: Билд фэилд${NC}"
    cd ..
    exit 1
fi

cd ..

echo
echo -e "${GREEN}========================================"
echo "Билд комплитед саксесфули!"
echo "Экзекьютабл: build/bin/lab1"
echo -e "========================================${NC}"
echo
echo "Раннинг зе программ..."
echo
./build/bin/lab1