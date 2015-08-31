# превратить текущй каталог в каталог с тестами
# первый параметр - имя теста, остальные - библиотеки необходимые для линковки
function(add_test_dir name)
	aux_source_directory( ${CMAKE_CURRENT_SOURCE_DIR} TEST_SOURCES )
	add_executable( "${name}_gtest" ${TEST_SOURCES} )
	target_link_libraries( "${name}_gtest" ${GTEST_BOTH_LIBRARIES} ${ARGN} )
	if( CROSS )
		add_test( "${name}_gtest" "${name}_gtest" --gtest_output=xml:${GTEST_RESULT_ROOT}/${name}_gtest.xml )
	else()
		add_test( "${name}_gtest" valgrind --track-origins=yes --child-silent-after-fork=yes
		--xml=yes --xml-file=${GTEST_RESULT_ROOT}/${name}_valgrind.xml
		"./${name}_gtest" --gtest_output=xml:${GTEST_RESULT_ROOT}/${name}_gtest.xml )
	endif()
endfunction()
