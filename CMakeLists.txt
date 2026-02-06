cmake_minimum_required(VERSION 3.19)

project(caelestia-welcome VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(Qt6 REQUIRED COMPONENTS Quick Core Gui)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(caelestia-welcome
    main.cpp
)

set_target_properties(caelestia-welcome PROPERTIES
    AUTOMOC ON
    AUTORCC ON
    AUTORCC_OPTIONS "qml.qrc"
)

set(qml_files
    "Main.qml"
    "components/CAnim.qml"
    "components/MaterialIcon.qml"
    "components/StyledRect.qml"
    "components/StyledText.qml"
    "utils/Appearance.qml"
    "utils/Palette.qml"
)

set(qml_singletons
    "utils/Colours.qml"
    "utils/Config.qml"
)

set(qml_assets
    "assets/logo-dark.svg"
    "assets/logo-light.svg"
)

set_source_files_properties(${qml_singletons}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_resources(caelestia-welcome "/qt/qml/caelestia/welcome"
    PREFIX "/"
    FILES ${qml_files} ${qml_singletons} ${qml_assets})

qt_add_qml_module(caelestia-welcome
    URI caelestia.welcome
    VERSION 1.0.0
    QML_FILES ${qml_files} ${qml_singletons}
)

target_link_libraries(caelestia-welcome PRIVATE
    Qt6::Core
    Qt6::Gui
)

include(GNUInstallDirs)
install(TARGETS caelestia-welcome
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
