ZSHHOME="${HOME}/.config/zsh.d"


if [ -d $ZSHHOME -a -r $ZSHHOME -a \
	-x $ZSHHOME ]; then
	for i in $ZSHHOME/*; do
		[[ ${i##*/} = *.zsh ]] &&
		[ \( -f $i -o -h $i \) -a -r $i ] && . $i
	done
fi

# pyenv
#export PYENV_ROOT=$HOME/.pyenv
#export PATH=$PYENV_ROOT/bin:$PATH
#eval "$(pyenv init -)"
