set (SRCS
	main.cpp
	spaceengine.cpp 
	)
	
set(HEADERS
	spaceengine.h
	)

# add the files for compilation
add_executable(SpaceEngine-out ${SRCS} ${HEADERS})
