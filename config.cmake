set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
if(POLICY CMP0063) # visibility. since 3.3
  cmake_policy(SET CMP0063 NEW)
endif()
 
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_C_VISIBILITY_PRESET hidden)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
 
if(WIN32 AND NOT WINDOWS_STORE)
    set(WINDOWS_DESKTOP 1)
else()
    set(WINDOWS_DESKTOP 0)
endif()

if(UNIX AND NOT APPLE)
    set(LINUX 1)
else()
    set(LINUX 0)
endif()

if(MSVC)
    if(CMAKE_CXX_SIMULATE_ID MATCHES MSVC)
        add_compile_options(-GR-)
    endif()
else()
    add_compile_options(-fno-rtti -fno-exceptions -fPIC)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang" AND NOT MSVC)
    add_compile_options(-flto=thin) # lld-link: error: lto.tmp: undefined symbol: ldexpf
endif()

if(APPLE)
    set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -dead_strip")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -dead_strip")
endif()
