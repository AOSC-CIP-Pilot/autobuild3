#!/bin/bash
##arch/mips64r6el.sh: Build definitions for mips64r6el.
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=mips64r6 -mtune=mips64r6 -mcompact-branches=always '

# DRAFT: Append MSA flags if SIMD support is desired.
if bool $MIPS64R6EL_USE_MSA; then
	CFLAGS_COMMON_ARCH+='-mmsa -mhard-float -mfp64 -mnan=2008 '
fi

RUSTFLAGS_COMMON_ARCH='-Ctarget-cpu=mips64r6 '
