#include <iostream>
#include <string>

#ifdef _WIN32
    #define OS_NAME "Windows"
#elif __linux__
    #define OS_NAME "Linux"
#elif __APPLE__
    #define OS_NAME "macOS"
#else
    #define OS_NAME "Unknown OS"
#endif

int main() {
    std::cout << "Hello World!" << std::endl;
    std::cout << "Operating System: " << OS_NAME << std::endl;

    return 0;
}