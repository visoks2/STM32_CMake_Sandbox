cmake_minimum_required(VERSION 3.9)

set(CORE_DIR "${PROJECT_SOURCE_ROOT_DIR}/Core")
set(CORE_INCLUDE_DIRS ${CORE_DIR}/Inc)

set(APPLICATION_DIR "${PROJECT_SOURCE_ROOT_DIR}/application")
set(APPLICATION_INCLUDE_DIR ${APPLICATION_DIR}/inc)
set(APPLICATION_HEADERS ${APPLICATION_INCLUDE_DIR}/application.h)

set(CORE_SOURCES
    ${CORE_DIR}/Src/main.cpp
    ${CORE_DIR}/Src/stm32f1xx_hal_msp.c
    ${CORE_DIR}/Src/stm32f1xx_it.c
    ${CORE_DIR}/Src/system_stm32f1xx.c
)

set(CORE_HEADERS
    ${CORE_DIR}/Inc/main.h
    ${CORE_DIR}/Inc/stm32f1xx_hal_conf.h
    ${CORE_DIR}/Inc/stm32f1xx_it.h
)

add_library(core STATIC ${CORE_HEADERS} ${CORE_SOURCES}) # ${APPLICATION_HEADERS})
target_include_directories(core PUBLIC ${CORE_INCLUDE_DIRS} ${APPLICATION_INCLUDE_DIR})
target_link_libraries(core hal)


embedded_executible(cnc ${CORE_SOURCES})
