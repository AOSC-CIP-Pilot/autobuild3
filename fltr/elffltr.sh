abrequire fileenum elf

for i in $AB/fltr/elffltr/*.sh
do
	. $i
done

fltr_elffltr__process(){
	elf_iself "$*" || return 0
	[ -z "$ABELFFLTRS" ] && return 0
	for i in $ABELFFLTRS
	do
		elffltr_$i "$@"
	done
}

fltr_elffltr(){
	for i in {/opt/*/,usr/,}{lib{,64,exec},bin}
	do
		[ -d "$i" ] || continue
		pushd "$i" >/dev/null
		fileenum "fltr_elffltr__process {}"
		popd >/dev/null
	done
}

export ABFLTRS+=" elffltr"
