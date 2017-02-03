cmake_minimum_required( VERSION 3.0 FATAL_ERROR )
set( CMAKE_VERBOSE_MAKEFILE ON )

project( BasicAwesomium )
set( APP_NAME "${PROJECT_NAME}App" )

# this needs to be set at the moment for the post build copy
set( CMAKE_BUILD_TYPE "Debug" )

get_filename_component( CINDER_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../.." ABSOLUTE )
get_filename_component( APP_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../" ABSOLUTE )

include( "${CINDER_PATH}/proj/cmake/modules/cinderMakeApp.cmake" )

set( APP_SOURCES
	${APP_PATH}/src/_TBOX_PREFIX_App.cpp
)

set_source_files_properties( ${APP_SOURCES}
	PROPERTIES COMPILE_FLAGS "-arch i386"
)

set( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -arch i386" )

ci_make_app(
    APP_NAME ${APP_NAME}
	SOURCES ${APP_SOURCES}
	CINDER_PATH ${CINDER_PATH}
	BLOCKS Cinder-Awesomium
)

if( APPLE )
	add_custom_command( TARGET ${APP_NAME} POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E copy_directory
		"${APP_PATH}/../../build/lib/macosx/Awesomium.framework/"
		"${CMAKE_BUILD_TYPE}/${APP_NAME}/${APP_NAME}.app/Contents/MacOS/Awesomium.framework/"
	)
endif()
