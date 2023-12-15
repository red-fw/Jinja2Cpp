update_submodule(nonstd/expected-lite)
add_subdirectory(thirdparty/nonstd/expected-lite EXCLUDE_FROM_ALL)

update_submodule(nonstd/variant-lite)
add_subdirectory(thirdparty/nonstd/variant-lite EXCLUDE_FROM_ALL)
add_library(variant-lite ALIAS variant-lite)

update_submodule(nonstd/optional-lite)
add_subdirectory(thirdparty/nonstd/optional-lite EXCLUDE_FROM_ALL)
add_library(optional-lite ALIAS optional-lite)

update_submodule(nonstd/string-view-lite)
add_subdirectory(thirdparty/nonstd/string-view-lite EXCLUDE_FROM_ALL)
add_library(string-view-lite ALIAS string-view-lite)

update_submodule(fmtlib)
set (FMT_INSTALL ON CACHE BOOL "" FORCE)
add_subdirectory(thirdparty/fmtlib EXCLUDE_FROM_ALL)
add_library(fmt ALIAS fmt-header-only)

update_submodule(json/rapid)
set (RAPIDJSON_BUILD_DOC OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_BUILD_THIRDPARTY_GTEST OFF CACHE BOOL "" FORCE)
set (RAPIDJSON_ENABLE_INSTRUMENTATION_OPT OFF CACHE BOOL "" FORCE)
add_subdirectory(thirdparty/json/rapid EXCLUDE_FROM_ALL)
set (RapidJSON_DIR ${RapidJSON_BINARY_DIR})
find_package(RapidJSON)
add_library(RapidJson INTERFACE)
target_include_directories(RapidJson
    INTERFACE
        $<BUILD_INTERFACE:${RapidJSON_INCLUDE_DIR}>
        $<INSTALL_INTERFACE:include>
    )

if (JINJA2CPP_BUILD_TESTS)
    update_submodule(json/nlohmann)
    set (JSON_BuildTests OFF CACHE BOOL "" FORCE)
    set (JSON_Install OFF CACHE BOOL "" FORCE)
    set (JSON_MultipleHeaders ON CACHE BOOL "" FORCE)
    add_subdirectory(thirdparty/json/nlohmann EXCLUDE_FROM_ALL)
endif()

install (FILES
        thirdparty/nonstd/expected-lite/include/nonstd/expected.hpp
        thirdparty/nonstd/variant-lite/include/nonstd/variant.hpp
        thirdparty/nonstd/optional-lite/include/nonstd/optional.hpp
        thirdparty/nonstd/string-view-lite/include/nonstd/string_view.hpp
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/nonstd)

install (TARGETS RapidJson
    EXPORT InstallTargets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/static
    )
