cmake_minimum_required(VERSION 3.16)

project(interface VERSION 0.1 LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(appinterface
    main.cpp
)

qt_add_qml_module(appinterface
    URI interface
    QML_FILES
        Main.qml
        SOURCES databasebridge.h databasebridge.cpp
        RESOURCES
            icons/svgs/regular/eye.svg
            icons/svgs/regular/eye-slash.svg

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appinterface PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appinterface
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appinterface
    PRIVATE Qt6::Quick
)

target_include_directories(appinterface PRIVATE
    ../database/include
    ../config/include
    ../connection/include
    ../security/include
)

target_sources(appinterface PRIVATE
    ../database/database.c
    ../database/database_connect.c
    ../config/config.c
    ../connection/helpers/socket_helper.c
    ../security/src/sha256.c
    ../security/src/hmac.c
    ../security/src/pbkdf2.c
    ../security/src/base64.c
    ../security/src/scram.c
    ../security/src/password_input.c
)

install(TARGETS appinterface
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
