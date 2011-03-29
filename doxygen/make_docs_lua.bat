::kill existing copy of source files folder, if any
rmdir /s /q src-copy

::create copy of source files
xcopy /v /i /s /y "../src" "src-copy"

::modify copy of source files
set PARAM_EXP_PREFIX=(\@name.*\()(.*)\s*\).*\@param
set PARAM_EXP_SUFFIX=\s*(\w*)\s*\@type\s*(\w*)\n(.*?)\*\/
set PARAM_EXP_REPLACE=$1 $2, $3 \)\n$5\t\@param $3 \($4\)\n\*\/

call fr "src-copy" "*" "(\@name\s*(\w*))\n" "$1 \(\)\n"
call fr "src-copy" "*" "%PARAM_EXP_PREFIX%1%PARAM_EXP_SUFFIX%" "%PARAM_EXP_REPLACE%"
call fr "src-copy" "*" "%PARAM_EXP_PREFIX%2%PARAM_EXP_SUFFIX%" "%PARAM_EXP_REPLACE%"
call fr "src-copy" "*" " , " ", "
call fr "src-copy" "*" "(\@name.*\() ,(.*)\)" "$1$2\)"
call fr "src-copy" "*" "\@name\s*(\w*.*)\)" "\@brief\n\t\<tt\>function $1 \(\)\<\/tt\>\\n\n\t\\n\n"
call fr "src-copy" "*" "\@text\s*(\w*.*)\n" "$1\n"

::kill existing doxygen output folder, if any
rmdir /s /q html-lua

::run doxygen on copy of source files
doxygen doxyfile-lua

::modify doxygen's output
call fr "html-lua" "*.html" "Static .*? Member Functions" "Function List"
call fr "html-lua" "*.html" "Member Function Documentation" "Function Documentation"
call fr "html-lua" "*.html" "SUPPRESS_EMPTY_FILE_WARNING" ""
call fr "html-lua" "*.html" "static int(.*?\>)_(.*?\<\/a\>)" "$1$2"
call fr "html-lua" "*.html" "\(lua_State \*L\)" ""
call fr "html-lua" "*.html" "int MOAI.*?::_(.*?\<\/td\>)" "$1"
call fr "html-lua" "*.html" "(\>)lua_State \*.*?(\<)" "$1$2"
call fr "html-lua" "*.html" "\<em\>L\<\/em\>" ""
call fr "html-lua" "*.html" "\<td class=\"paramtype\"\>\<\/td\>" ""
call fr "html-lua" "*.html" "\<td class=\"paramname\"\>\<\/td\>" ""
call fr "html-lua" "*.html" "\<td\>\(\<\/td\>" ""
call fr "html-lua" "*.html" "\<td\>\)\<\/td\>" ""
::call fr "html-lua" "*.html" "(\<code\>).*?\[.*?static.*?\].*?(\<\/code\>?)" "$1$2"
call fr "html-lua" "*.html" "(\>)_(.*?\(\))" "$1$2"