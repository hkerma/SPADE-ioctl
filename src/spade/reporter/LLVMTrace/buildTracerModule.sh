
echo llvm[0]: "Compiling llvmTracer.cpp for Release+Asserts build" "(PIC)"
if  clang++ -I/usr/local/include/llvm -I./  -D_DEBUG -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -O3 -fomit-frame-pointer -std=c++11 -fvisibility-inlines-hidden -fno-exceptions -fno-rtti -fPIC -ffunction-sections -fdata-sections -Wcast-qual    -pedantic -Wno-long-long -Wall -W -Wno-unused-parameter -Wwrite-strings  -Wcovered-switch-default -Wno-uninitialized  -Wno-missing-field-initializers -Wno-comment -c -MMD -MP -MF "llvmTracer.d.tmp" -MT "llvmTracer.o" -MT "llvmTracer.d" llvmTracer.cpp -o llvmTracer.o ; \
	        then /bin/mv -f "llvmTracer.d.tmp" "Release+Asserts/llvmTracer.d"; else /bin/rm "Release+Asserts/llvmTracer.d.tmp"; exit 1; fi
echo "{" > Release+Asserts/Hello.exports.map
grep -q '[[:alnum:]_]' Hello.exports && echo "  global:" >> Release+Asserts/Hello.exports.map || :
sed -e 's/$/;/' -e 's/^/    /' < Hello.exports >> Release+Asserts/Hello.exports.map
echo "  local: *;" >> Release+Asserts/Hello.exports.map
echo "};" >> Release+Asserts/Hello.exports.map
echo llvm[0]: Linking Release+Asserts "Loadable Module" \
	  LLVMTrace.so
clang++  -O3 -Wl,-R -Wl,'$ORIGIN' -Wl,--gc-sections -rdynamic -L./ -L./  -shared -o LLVMTrace.so llvmTracer.o \
	   -Wl,--version-script,Release+Asserts/Hello.exports.map -lz -lpthread -ltinfo -ldl -lm 
mv LLVMTrace.so ../../bin/
