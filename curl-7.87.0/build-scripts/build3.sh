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
	export LD=$NDK_TOOLCHAIN/bin/ld
	export RANLIB=$NDK_TOOLCHAIN/bin/llvm-ranlib
	export STRIP=$NDK_TOOLCHAIN/bin/llvm-strip

	export BEARSSL_PATH="$SDL_PATH/bearssl-0.6"
	export BEARSSL_LIB_PATH="$BEARSSL_PATH/build/android/lib/$NDK_ARCH/"

	# without ssl, works
	#./configure --host $NDK_TARGET --disable-shared --enable-static --disable-manual --disable-ntlm --disable-smtp --disable-pop3 --disable-imap --disable-telnet --disable-gopher --disable-dict --disable-mqtt --disable-rtsp --disable-ftp --disable-tftp --enable-file --without-ssl && make

	# with bearssl
	#CPPFLAGS="-I$SDL_PATH/bearssl-0.6/inc" ./configure --host $NDK_TARGET --disable-shared --enable-static --disable-manual --disable-ntlm --disable-smtp --disable-pop3 --disable-imap --disable-telnet --disable-gopher --disable-dict --disable-mqtt --disable-rtsp --disable-ftp --disable-tftp --enable-file --with-bearssl=$SDL_PATH/bearssl-0.6/ && make
	CPPFLAGS="-I$SDL_PATH/bearssl-0.6/inc" ./configure --host $NDK_TARGET --disable-shared --enable-static --disable-manual --disable-ntlm --disable-smtp --disable-pop3 --disable-imap --disable-telnet --disable-gopher --disable-dict --disable-mqtt --disable-rtsp --disable-ftp --disable-tftp --enable-file --with-bearssl=$BEARSSL_LIB_PATH && make
	# TODO: set CA bundle path
	#CPPFLAGS="-I$SDL_PATH/bearssl-0.6/inc" ./configure --host $NDK_TARGET --disable-shared --enable-static --disable-manual --disable-ntlm --disable-smtp --disable-pop3 --disable-imap --disable-telnet --disable-gopher --disable-dict --disable-mqtt --disable-rtsp --disable-ftp --disable-tftp --enable-file --with-bearssl=$SDL_PATH/bearssl-0.6/ --with-ca-bundle=/data/data/com.termux/files/home/tmp/isrg-root-x2.pem && make


	mkdir -p build/android/obj/local/$NDK_ARCH/
	cp ./lib/.libs/libcurl.* build/android/obj/local/$NDK_ARCH/
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
