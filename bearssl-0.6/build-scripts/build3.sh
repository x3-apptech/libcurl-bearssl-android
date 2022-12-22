# Only choose one of these, depending on your build machine...
#export NDK_TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
export NDK_TOOLCHAIN=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64

export NDK_API=21

buildarch() {
	make clean

	# Configure and build.
	export AR=$NDK_TOOLCHAIN/bin/llvm-ar
	export CC=$NDK_TOOLCHAIN/bin/$NDK_TARGET$NDK_API-clang
	export AS=$CC
	export CXX=$NDK_TOOLCHAIN/bin/$NDK_TARGET$NDK_API-clang++
	#export LD=$NDK_TOOLCHAIN/bin/ld.lld
	#TODO
	#export LD=$NDK_TOOLCHAIN/$NDK_TARGET/bin/ld
	export LD=$NDK_TOOLCHAIN/arm-linux-androideabi/bin/ld

	export RANLIB=$NDK_TOOLCHAIN/bin/llvm-ranlib
	export STRIP=$NDK_TOOLCHAIN/bin/llvm-strip

	#make CC=$CC AR=$AR AS=$CC CXX=$CXX LD=$LD LDDLL=$CC RANLIB=$RANLIB STRIP=$STRIP CFLAGS='-O3 -fPIC -mfpu=neon-vfpv4 -fno-math-errno'
	make CC=$CC AR=$AR AS=$CC CXX=$CXX LD=$LD LDDLL=$CC RANLIB=$RANLIB STRIP=$STRIP

	$CC -shared -fvisibility=extern build/obj/*.o -o build/libbearssl.so

	mkdir -p build/android/obj/local/$NDK_ARCH/
	mkdir -p build/android/lib/$NDK_ARCH/lib/
	cp build/libbearssl.* build/android/obj/local/$NDK_ARCH/
	ln -s ../../../obj/local/$NDK_ARCH/libbearssl.a build/android/lib/$NDK_ARCH/lib/libbearssl.a
	ln -s ../../../obj/local/$NDK_ARCH/libbearssl.so build/android/lib/$NDK_ARCH/lib/libbearssl.so
}


#export NDK_TARGET=aarch64-linux-android
export NDK_TARGET=armv7a-linux-androideabi
#export NDK_TARGET=i686-linux-android
#export NDK_TARGET=x86_64-linux-android

#export NDK_ARCH=arm64-v8a
export NDK_ARCH=armeabi-v7a
#export NDK_ARCH=x86
#export NDK_ARCH=x86_64

buildarch


export NDK_TARGET=aarch64-linux-android
export NDK_ARCH=arm64-v8a

buildarch


export NDK_TARGET=i686-linux-android
export NDK_ARCH=x86

buildarch


export NDK_TARGET=x86_64-linux-android
export NDK_ARCH=x86_64

buildarch
