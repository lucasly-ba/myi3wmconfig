# ~/.bashrc
export LANG=en_US.utf8
export EDITOR=hx
export SCREEN_STATUS=LAPTOP

mark() {
    echo "$1" >>~/.mark
    pwd >>~/.mark
}

cd() {

	if [ "$#" -eq 0 ]; then
		builtin cd
		return
	fi
	if builtin cd "$1" 2>/dev/null; then
        return
    fi

    path=~/.mark
    a=0
    for LINE in $(cat "$path"); do
        if [ "$a" -eq 1 ]; then
            builtin cd "$LINE"
			break		
        fi

        if [ "$LINE" == "$1" ]; then
            a=1
        fi
    done
	if [ "$a" -eq 0 ]; then
		builtin cd "$1"
	fi
}

mclean() {
    rm ~/.mark
    touch ~/.mark
}

function psh() {

    git add .
    git commit -m "$1"
    git tag -ma "$2"
    git push --follow-tags

}

function pshh() {
    git add .
    git commit -m "$1"
    git push
}

function log() {
    git log --oneline
}


function auto() {
    libtoolize
    ./bootstrap
    ./configure CXXFLAGS='-std=c++20 -O0 -g -fno-inline'
    make -j 8
}

function ma() {
    make -j 4
}

function clean() {
    rm -rf configure configure~ aclocal.m4 autom4te.cache Makefile.in config.h.in
}

function blur()
{
	cp ~/.config/picom/picom.conf.bak ~/.config/picom/picom.conf
	i3-msg restart
}

function bblur()
{
	rm ~/.config/picom/picom.conf
}
function tignix()
{
	nix run nixpkgs#nixVersions.nix_2_28 develop
}

function addpackage()
{
	sudo sed -i "55i\\    $1" /etc/nixos/configuration.nix
	sudo nixos-rebuild switch 
}

function deploytclocal()
{
	export NIX_OPTIONS=--impure	
	nix run .#check-student -j8 -- tc-6 /home/macaronjaune/afs/yaka/tiger/mytiger
}

function rmpackage()
{
	sudo sed -i "/$1/d" /etc/nixos/configuration.nix
	sudo nixos-rebuild switch 
}

function listpackages()
{
	sed -n '/environment.systemPackages/,/]/p' /etc/nixos/configuration.nix \
		| grep -v 'environment.systemPackages' \
		| grep -v '\[' \
		| grep -v '\]' \
		| sed 's/^[ \t]*//;s/[ \t]*$//' \
		| sed 's/^[0-9]*:[0-9]*:[0-9]*:[ \t]*//'
}

function tctest()
{
	builtin cd tests
	./testsuite/tc_check.py -c configurations -p . -f ssa_tc6 -j16
	./testsuite/tc_check.py -c configurations -p . -f ssa_tc7 -j16
	./testsuite/tc_check.py -c configurations -p . -f ssa_tc8 -j16
	./testsuite/tc_check.py -c configurations -p . -f ssa_tc9 -j16
	./testsuite/tc_check.py -c configurations -p . -f dce_tc9 -j16
	./testsuite/tc_check.py -c configurations -p . -f scp_tc9 -j16
	builtin cd ..
}

alias cat='bat'
alias ls='ls --color=auto'
alias grep='grep --color -n'

alias breload='source ~/.bashrc'
alias rebuild='sudo nixos-rebuild switch'

alias gf='git push --force-with-lease'
alias gb='git branch'
alias gs='git status'
alias grb='git rebase -i HEAD~10'
alias grc='git rebase --continue'
alias gl='git log'
alias gca='git commit --amend'
alias gc='git commit -m'
alias ga='git add -u'
alias gd='git diff'

alias h='hx .'
alias m='make -j 16'

alias gentests='make gen-all-outputs -j16'
alias dce='./src/tc -e --dead-code-elimination --ssa -L a.tig'
alias ssa='./src/tc -e --ssa -L a.tig'
alias lir='./src/tc -e -L a.tig'
alias debug='./src/tc -e --ssa-debug a.tig'
alias scp='./src/tc -e --constant-propagation --ssa -L a.tig'
alias cpy='./src/tc -e --copy-propagation --ssa -L a.tig'

alias mg='make -C build  -j16'
alias crab='build/gcc/crab1'
alias embecosm='xrandr --output HDMI-1 --mode 2880x1620 --rate 60'
alias r='rustc --crate-type=lib'
alias gdbg='gdb --args build/gcc/crab1 a.rs'
alias f='fzf | tr -d "\n" | xclip -selection clipboard'

export LS_COLORS="di=1;33:fi=95:ex=1;31"
PS1='\[\e[1;95m\]\u \[\e[1;91m\]\w \[\e[0;33m\]\$ \[\e[95m\]'

