set (QT_MOC moc)
set (QT_RCC rcc)
set (QT_UIC uic.exe)
set (QT_LRELEASE lrelease)
set (QT_LUPDATE lupdate)
set (QT_LCONVERT lconvert)
set (QT_QSCXMLC qscxmlc) #Compiles the given input.scxml file to a header and a cpp file.

# for Windows operating system in general
if(WIN32)
    if(MSVS OR MSYS OR MINGW)
        # set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} $ENV{QT5_DIR} )
        set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} 
            "D:/Qt/Qt5.8.0/5.8/mingw53_32"
            "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/lib"
            "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/lib"
            "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/bin"
            # "H:/levitics/Arkhe/amd64-windows-Debug/Windows-GNU_GCC_5.3.0-AMD64-Debug/include/gtest"
            # "H:/levitics/Arkhe/amd64-windows-Debug/Windows-GNU_GCC_5.3.0-AMD64-Debug/include/gmock"
            ) # remember to add D:\Qt\Qt5.8.0\5.8\mingw53_32\bin to %PATH%
        # SET(CMAKE_FIND_ROOT_PATH
        # "D:/Qt/Qt5.8.0/5.8/mingw53_32"
        # "D:/Qt/Qt5.8.0/Tools/mingw530_32"
        # "D:/Qt/Qt5.8.0/Tools/mingw530_32/include"
        # "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}"
        # "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
        # "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
        # )

        # set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
        # set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
        # set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
        # set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
        set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)
        set(CMAKE_INCLUDE_CURRENT_DIR ON )
        set(CMAKE_INCLUDE_DIRECTORIES_BEFORE ON )
        set(CMAKE_AUTOMOC ON )
        set(CMAKE_AUTOMOC_MOC_OPTIONS "")
        set(CMAKE_AUTOMOC_RELAXED_MODE "")
        SET(CMAKE_AUTOUIC ON) 
        SET(CMAKE_AUTOUIC_OPTIONS "") 
        SET(CMAKE_AUTORCC ON) 
        SET(CMAKE_AUTORCC_OPTIONS "")
        set(CMAKE_MAKE_PROGRAM mingw32-make.exe)
        # set(CMAKE_C_COMPILER i686-w64-mingw32-gcc.exe)
        # set(CMAKE_CXX_COMPILER i686-w64-mingw32-g++.exe)
    endif()
endif()

# for MacOS X
if(APPLE)
    
endif()

# for Linux, BSD, Solaris, Minix
if(UNIX AND NOT APPLE)
    # set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} $ENV{QT5_DIR} )
    set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH}
        "/opt/Qt5.11.0/5.11.0/gcc_64"
        "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/lib"
        "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/lib"
        "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/bin"
    )

    set(CMAKE_INCLUDE_CURRENT_DIR ON )
    # set(CMAKE_INCLUDE_DIRECTORIES_BEFORE ON )
    set(CMAKE_AUTOMOC ON )
    set(CMAKE_AUTOMOC_MOC_OPTIONS "")
    set(CMAKE_AUTOMOC_RELAXED_MODE "")
    set(CMAKE_AUTOUIC ON) 
    set(CMAKE_AUTOUIC_OPTIONS "") 
    set(CMAKE_AUTORCC ON) 
    set(CMAKE_AUTORCC_OPTIONS "") 
    set(CMAKE_C_COMPILER /usr/bin/gcc)
    set(CMAKE_CXX_COMPILER /usr/bin/g++)
endif()


find_package( Qt5Core    REQUIRED )
find_package( Qt5Concurrent REQUIRED )
find_package( Qt5Widgets REQUIRED )
find_package( Qt5Charts REQUIRED )
find_package( Qt5Gui REQUIRED )
find_package( Qt5LinguistTools REQUIRED )
find_package( Qt5QuickWidgets REQUIRED )
find_package( Qt5Location REQUIRED )
find_package( Qt5DataVisualization REQUIRED )
find_package( Qt5Network REQUIRED )
find_package( Qt5NetworkAuth REQUIRED )
find_package( Qt5Multimedia REQUIRED)
find_package( Qt5MultimediaWidgets REQUIRED)
find_package( Qt5OpenGL REQUIRED )
find_package( Qt5Purchasing REQUIRED )
find_package( Qt5Sensors REQUIRED )
find_package( Qt5Svg REQUIRED )
find_package( Qt5SerialBus REQUIRED )
find_package( Qt5Xml REQUIRED )
find_package( Qt5XmlPatterns REQUIRED )
find_package( Qt5Scxml REQUIRED )
find_package( Qt5Positioning REQUIRED )
#find_package( Qt5WebKit REQUIRED )
find_package( Qt5SerialPort REQUIRED )
#find_package( Qt5WebKitWidgets REQUIRED )
find_package( Qt5TextToSpeech REQUIRED )
find_package( Qt5UiTools REQUIRED )
find_package( Qt5Script REQUIRED )
find_package( Qt5Sql REQUIRED )
find_package( Qt5Qml REQUIRED )
find_package( Qt5Quick REQUIRED )
find_package( Qt5QuickControls2 REQUIRED )
find_package( Qt5OpenGL REQUIRED  )
find_package( Qt53DQuick REQUIRED  )
find_package( Qt53DQuickExtras REQUIRED  )
find_package( Qt5OpenGLExtensions REQUIRED  )
find_package( Qt53DQuickRender REQUIRED  )
find_package( Qt53DQuickInput REQUIRED  )
find_package( Qt53DCore REQUIRED )
find_package( Qt53DExtras REQUIRED )
find_package( Qt53DRender REQUIRED )
find_package( Qt53DInput REQUIRED )

