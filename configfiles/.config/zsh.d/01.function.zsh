# alias用
function runcpp () {
	g++ -O2 $1
	shift
	./a.out	$@
	rm ./a.out
}
# alias用
function runjava () {
	clasName=$1
	className=${className%.java}
	javac %1
	shift
	java $clasName $@
}
