#!/bin/bash
##proc/patch: Loads the build/ functions
##@copyright GPL-2.0+
abrequire arch

PATCHFLAGS="-Np1 -t"
RPATCHFLAGS="-Rp1 -t"

if [ ! -f .patch ]
then
	if arch_loadfile_strict patch
	then
		touch .patch
	elif [ -f autobuild/patches/series ]
	then
		for i in $(grep -v '^#' autobuild/patches/series); do
			abinfo "Applying patch $i ..."
			patch $PATCHFLAGS -i "autobuild/patches/$i" || abdie "Applying patch $i failed: $?."
		done
		touch .patch
	elif [ -d autobuild/patches ]
	then
		for i in autobuild/patches/*.{patch,diff}; do
			abinfo "Applying patch $i ..."
			patch $PATCHFLAGS -i "$i" || abdie "Applying patch $i failed: $?."
		done
		for i in autobuild/patches/*.{patch,diff}."${CROSS:-$ARCH}"; do
			abinfo "Applying patch $i (for ${CROSS:-$ARCH}) ..."
			patch $PATCHFLAGS -i "$i" || abdie "Applying patch $i for ${CROSS:-$ARCH} failed: $?."
		done
		for i in autobuild/patches/*.r{patch,diff}; do
			abinfo "Reverting patch $i ..."
			patch $RPATCHFLAGS -i "$i" || abdie "Reverting patch $i failed: $?."
		done
		for i in autobuild/patches/*.r{patch,diff}."${CROSS:-$ARCH}"; do
			abinfo "Applying patch $i (for ${CROSS:-$ARCH}) ..."
			patch $RPATCHFLAGS -i "$i" || abdie "Reverting patch $i for ${CROSS:-$ARCH} failed: $?."
		done
		touch "$SRCDIR"/.patch
	fi
fi
