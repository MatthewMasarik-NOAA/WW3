# doxygen documentation- Matt Masarik 24-Jul-2024.
function(EnableDoxygen outdir)
  find_package(Doxygen)
    if (NOT DOXYGEN_FOUND)
      add_custom_target(enable_docs
          COMMAND false
          COMMENT "Doxygen not found")
      return()
    endif()

    set(src_basedir "${CMAKE_SOURCE_DIR}")
    set(bin_basedir "${CMAKE_BINARY_DIR}")
    file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/${outdir}/html)
    CONFIGURE_FILE(${CMAKE_SOURCE_DIR}/docs/Doxyfile.in
        ${CMAKE_BINARY_DIR}/${outdir}/Doxyfile @ONLY)
    set(DOXYGEN_GENERATE_HTML YES)
    set(DOXYGEN_QUIET YES)
###MTM    set(DOXYGEN_HTML_OUTPUT ${CMAKE_BINARY_DIR}/${outdir}/html)
    add_custom_target(enable_docs
        COMMAND
        ${DOXYGEN_EXECUTABLE} ${CMAKE_BINARY_DIR}/${outdir}/Doxyfile
###MTM        ALL
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/${outdir}
        COMMENT "Generate Doxygen HTML documentation")
    message("-- Doxygen HTML index page: "
        ${CMAKE_BINARY_DIR}/${outdir}/html/index.html)
endfunction()
