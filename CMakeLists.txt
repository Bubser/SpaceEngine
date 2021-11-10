cmake_minimum_required(VERSION 3.0)

# Nom du projet 
PROJECT(SPACEENGINE) 
SET(CMAKE_BUILD_TYPE "Release")


# Windows 
if (!MSVC)
SET(CMAKE_CXX_FLAGS "-Wno-deprecated")
endif()


set (OUR_DEPENDENCIES "${CMAKE_SOURCE_DIR}/Dependencies")
# --------------------------
# compile and link GLFW
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)


set(OUR_GLFW_DIR "${OUR_DEPENDENCIES}/glfw-3.3.5")
add_subdirectory(${OUR_GLFW_DIR})

# Link GLFW 
link_libraries(glfw)
include_directories(${glfw_INCLUDE_DIRS})
include_directories("${OUR_GLFW_DIR}/deps")


# add GLAD library 
set(OUR_GLAD_DIR "${OUR_DEPENDENCIES}/GLAD")
include_directories("${OUR_GLAD_DIR}/include")
add_library(glad "${OUR_GLAD_DIR}/include/glad/glad.h"
         		 "${OUR_GLAD_DIR}/src/glad.c")	

# link GLAD library			 
link_libraries(glad)

# --------------------------
# exemple ajout d'un sous dossier avec un cmakelist
#ADD_SUBDIRECTORY(pngdecode)
#link_libraries(pngdecode)
#include_directories(${CMAKE_SOURCE_DIR}/pngdecode)
# --------------------------

# include all our libraries
set(SRC_COMMON "${CMAKE_SOURCE_DIR}/src/common")
include_directories(${SRC_COMMON})



set (SRCS
	src/main.cpp
	${SRC_COMMON}/spaceengine.cpp
	)
	
set(HEADERS
	${SRC_COMMON}/spaceengine.h
	)

# executable 
add_executable(spaceengine WIN32 MACOSX_BUNDLE 
	${SRCS}
	${HEADERS}
)


#Windows cleanup
if (MSVC)
    # Tell MSVC to use main instead of WinMain for Windows subsystem executables
    set_target_properties(spaceengine PROPERTIES LINK_FLAGS "/ENTRY:mainCRTStartup")
endif()

#Apple cleanup
if (APPLE)
    set_target_properties(spaceengine PROPERTIES MACOSX_BUNDLE_BUNDLE_NAME "simple")
	
    set_target_properties(spaceengine PROPERTIES
                          MACOSX_BUNDLE_SHORT_VERSION_STRING ${GLFW_VERSION}
                          MACOSX_BUNDLE_LONG_VERSION_STRING ${GLFW_VERSION_FULL}
    					  MACOSX_BUNDLE_ICON_FILE glfw.icns)				  
endif()

