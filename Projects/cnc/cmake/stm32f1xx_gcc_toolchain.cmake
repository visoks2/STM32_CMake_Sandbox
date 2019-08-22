cmake_minimum_required(VERSION 3.9)

set(MCU "-mthumb -mcpu=cortex-m3 -mfloat-abi=soft")
set(COMMON_FLAGS
"-ffunction-sections -fdata-sections -Wall -Wdouble-promotion \
-fsingle-precision-constant -fstack-usage")

set(MCU_LINKER_FLAGS 
"${MCU} -specs=nano.specs -specs=nosys.specs -static \
-Wl,--gc-sections -lc -lm -lnosys -lstdc++ -lsupc++")

include("${CMAKE_CURRENT_LIST_DIR}/arm_gcc_toolchain.cmake")
