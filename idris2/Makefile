include config.mk

# Idris 2 executable used to bootstrap
export IDRIS2_BOOT ?= idris2

# Idris 2 executable we're building
NAME = idris2erl
TARGETDIR = build/exec
TARGET = ${TARGETDIR}/${NAME}

MAJOR=0
MINOR=2
PATCH=1


GIT_SHA1=
ifeq ($(shell git status >/dev/null 2>&1; echo $$?), 0)
    # inside a git repo
    ifneq ($(shell git describe --exact-match --tags >/dev/null 2>&1; echo $$?), 0)
        # not tagged as a released version, so add sha1 of this build in between releases
        GIT_SHA1 := $(shell git rev-parse --short=9 HEAD)
    endif
endif

export IDRIS2_VERSION := ${MAJOR}.${MINOR}.${PATCH}
IDRIS2_SUPPORT := libidris2_support${SHLIB_SUFFIX}
IDRIS2_APP_IPKG := idris2.ipkg
IDRIS2_LIB_IPKG := idris2api.ipkg

ifeq ($(OS), windows)
	# This produces D:/../.. style paths
	IDRIS2_PREFIX := $(shell cygpath -m ${PREFIX})
	IDRIS2_CURDIR := $(shell cygpath -m ${CURDIR})
	SEP := ;
else
	IDRIS2_PREFIX := ${PREFIX}
	IDRIS2_CURDIR := ${CURDIR}
	SEP := :
endif

# Library and data paths for bootstrap-test
IDRIS2_BOOT_TEST_LIBS := ${IDRIS2_CURDIR}/bootstrap/${NAME}-${IDRIS2_VERSION}/lib
IDRIS2_BOOT_TEST_DATA := ${IDRIS2_CURDIR}/bootstrap/${NAME}-${IDRIS2_VERSION}/support

# These are the library path in the build dir to be used during build
export IDRIS2_BOOT_PATH := "${IDRIS2_CURDIR}/libs/prelude/build/ttc${SEP}${IDRIS2_CURDIR}/libs/base/build/ttc${SEP}${IDRIS2_CURDIR}/libs/contrib/build/ttc${SEP}${IDRIS2_CURDIR}/libs/network/build/ttc"

export SCHEME


.PHONY: all idris2-exec ${TARGET} testbin support support-clean clean distclean

all: support ${TARGET} testbin libs

idris2-exec: ${TARGET}

${TARGET}: src/IdrisPaths.idr
	${IDRIS2_BOOT} --build ${IDRIS2_APP_IPKG}

src/IdrisPaths.idr:
	echo 'module IdrisPaths' > src/IdrisPaths.idr
	echo 'export idrisVersion : ((Nat,Nat,Nat), String); idrisVersion = ((${MAJOR},${MINOR},${PATCH}), "${GIT_SHA1}")' >> src/IdrisPaths.idr
	echo 'export yprefix : String; yprefix="${IDRIS2_PREFIX}"' >> src/IdrisPaths.idr

prelude:
	${MAKE} -C libs/prelude IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}

base: prelude
	${MAKE} -C libs/base IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}

network: prelude
	${MAKE} -C libs/network IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}

contrib: prelude
	${MAKE} -C libs/contrib IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}

erlang: prelude
	${MAKE} -C libs/erlang IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}

libs : prelude base contrib network erlang

testbin:
	@${MAKE} -C tests testbin

test:
	@${MAKE} -C tests only=$(only) IDRIS2=../../../${TARGET}

support:
	@${MAKE} -C support/c

support-clean:
	@${MAKE} -C support/c clean

clean-libs:
	${MAKE} -C libs/prelude clean
	${MAKE} -C libs/base clean
	${MAKE} -C libs/contrib clean
	${MAKE} -C libs/network clean
	${MAKE} -C libs/erlang clean

clean: clean-libs support-clean
	-${IDRIS2_BOOT} --clean ${IDRIS2_APP_IPKG}
	$(RM) src/IdrisPaths.idr
	${MAKE} -C tests clean
	$(RM) -r build

install: install-idris2 install-support install-libs

install-api: src/IdrisPaths.idr
	${IDRIS2_BOOT} --install ${IDRIS2_LIB_IPKG}

install-idris2:
	mkdir -p ${PREFIX}/bin/
	install ${TARGET} ${PREFIX}/bin
ifeq ($(OS), windows)
	-install ${TARGET}.cmd ${PREFIX}/bin
endif
	mkdir -p ${PREFIX}/lib/
	install support/c/${IDRIS2_SUPPORT} ${PREFIX}/lib
	mkdir -p ${PREFIX}/bin/${NAME}_app
	install ${TARGETDIR}/${NAME}_app/* ${PREFIX}/bin/${NAME}_app

install-support:
	mkdir -p ${PREFIX}/idris2-${IDRIS2_VERSION}/support/chez
	mkdir -p ${PREFIX}/idris2-${IDRIS2_VERSION}/support/racket
	mkdir -p ${PREFIX}/idris2-${IDRIS2_VERSION}/support/gambit
	mkdir -p ${PREFIX}/idris2-${IDRIS2_VERSION}/support/js
	install support/chez/* ${PREFIX}/idris2-${IDRIS2_VERSION}/support/chez
	install support/racket/* ${PREFIX}/idris2-${IDRIS2_VERSION}/support/racket
	install support/gambit/* ${PREFIX}/idris2-${IDRIS2_VERSION}/support/gambit
	install support/js/* ${PREFIX}/idris2-${IDRIS2_VERSION}/support/js
	@${MAKE} -C support/c install

install-libs:
	${MAKE} -C libs/prelude install IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}
	${MAKE} -C libs/base install IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}
	${MAKE} -C libs/contrib install IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}
	${MAKE} -C libs/network install IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}
	${MAKE} -C libs/erlang install IDRIS2=../../${TARGET} IDRIS2_PATH=${IDRIS2_BOOT_PATH}


.PHONY: bootstrap bootstrap-build bootstrap-racket bootstrap-racket-build bootstrap-test bootstrap-clean

# Bootstrapping using SCHEME
bootstrap: bootstrap-build bootstrap-test

bootstrap-build: support
	cp support/c/${IDRIS2_SUPPORT} bootstrap/idris2_app
	sed s/libidris2_support.so/${IDRIS2_SUPPORT}/g bootstrap/idris2_app/idris2.ss > bootstrap/idris2_app/idris2-boot.ss
ifeq ($(OS), darwin)
	sed -i '' 's|__PREFIX__|${IDRIS2_CURDIR}/bootstrap|g' bootstrap/idris2_app/idris2-boot.ss
else
	sed -i 's|__PREFIX__|${IDRIS2_CURDIR}/bootstrap|g' bootstrap/idris2_app/idris2-boot.ss
endif
	sh ./bootstrap.sh

# Bootstrapping using racket
bootstrap-racket: bootstrap-racket-build bootstrap-test

bootstrap-racket-build: support
	cp support/c/${IDRIS2_SUPPORT} bootstrap/idris2_app
	cp bootstrap/idris2_app/idris2.rkt bootstrap/idris2_app/idris2-boot.rkt
ifeq ($(OS), darwin)
	sed -i '' 's|__PREFIX__|${IDRIS2_CURDIR}/bootstrap|g' bootstrap/idris2_app/idris2-boot.rkt
else
	sed -i 's|__PREFIX__|${IDRIS2_CURDIR}/bootstrap|g' bootstrap/idris2_app/idris2-boot.rkt
endif
	sh ./bootstrap-rkt.sh

bootstrap-test:
	$(MAKE) test INTERACTIVE='' IDRIS2_PATH=${IDRIS2_BOOT_PATH} IDRIS2_DATA=${IDRIS2_BOOT_TEST_DATA} IDRIS2_LIBS=${IDRIS2_BOOT_TEST_LIBS}

bootstrap-clean:
	$(RM) -r bootstrap/bin bootstrap/lib bootstrap/idris2-${IDRIS2_VERSION}
	$(RM) bootstrap/idris2boot* bootstrap/idris2_app/idris2-boot.* bootstrap/idris2_app/${IDRIS2_SUPPORT}


.PHONY: distclean

distclean: clean bootstrap-clean
	@find . -type f -name '*.ttc' -exec rm -f {} \;
	@find . -type f -name '*.ttm' -exec rm -f {} \;
	@find . -type f -name '*.ibc' -exec rm -f {} \;
