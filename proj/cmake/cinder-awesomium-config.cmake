if( NOT TARGET Cinder-Awesomium )
	get_filename_component( CINDER_AWESOMIUM_PATH "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE )

	set( CINDER_AWESOMIUM_INCLUDES
		${CINDER_AWESOMIUM_PATH}/include
		${CINDER_AWESOMIUM_PATH}/src
	)

	set( CINDER_AWESOMIUM_SOURCES
		${CINDER_AWESOMIUM_PATH}/src/CinderAwesomium.cpp
	)

	if( CINDER_MAC )
		set( CINDER_AWESOMIUM_LIBRARIES
			${CINDER_AWESOMIUM_PATH}/build/lib/macosx/Awesomium.framework
		)
	endif()

	set_source_files_properties( ${CINDER_AWESOMIUM_SOURCES}
		PROPERTIES COMPILE_FLAGS "-std=c++11 -arch i386"
	)

	add_library( Cinder-Awesomium ${CINDER_AWESOMIUM_SOURCES} )

	target_link_libraries( Cinder-Awesomium ${CINDER_AWESOMIUM_LIBRARIES} )

	set_target_properties( Cinder-Awesomium
		PROPERTIES LINK_FLAGS "-arch i386"
	)

	target_include_directories( Cinder-Awesomium PUBLIC "${CINDER_AWESOMIUM_INCLUDES}" )
	target_include_directories( Cinder-Awesomium SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )
endif()
