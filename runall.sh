#!/bin/bash

# Leandro Sehnem Heck (leoheck@gmail.com)

# http://www.tldp.org/LDP/abs/html/io-redirection.html

ERROR_MODULE_NOT_FOUND=200

# GITHUB REPOSITORY CONFIG
REPO="gaph-cad-validate"
BRANCH="master"

GITHUB="https://github.com/leoheck/$REPO/archive/"
PKG=$BRANCH.zip

PROJECTDIR=/tmp/$REPO-$BRANCH

export PATH=./scripts:$PATH
export PATH=$PROJECTDIR/scripts:$PATH

mkdir -p /var/log/gaph/

# Ctrl+c function to halt execution
control_c()
{
	clear
	echo -e "\n$0 interrupted by user :(\n"
	kill -KILL $$
}

trap control_c SIGINT

# Use colors only if connected to a terminal which supports them
if which tput >/dev/null 2>&1; then
	ncolors=$(tput colors)
fi

if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
	RED="$(tput setaf 1)"
	GREEN="$(tput setaf 2)"
	YELLOW="$(tput setaf 3)"
	BLUE="$(tput setaf 4)"
	BOLD="$(tput bold)"
	NORMAL="$(tput sgr0)"
else
	RED=""
	GREEN=""
	YELLOW=""
	BLUE=""
	BOLD=""
	NORMAL=""
fi

# Only enable exit-on-error after the non-critical colorization stuff,
# which may fail on systems lacking tput or terminfo
set -e

# Prevent the cloned repository from having insecure permissions. Failing to do
# so causes compinit() calls to fail with "command not found: compdef" errors
# for users with insecure umasks (e.g., "002", allowing group writability). Note
# that this will be ignored under Cygwin by default, as Windows ACLs take
# precedence over umasks except for filesystems mounted with option "noacl".
umask g-w,o-w

# TODO: Update and activate the menus

main()
{
	# echo

	# if [ -f /tmp/$PKG ]; then
	# 	printf "%s  Removing preview /tmp/$PKG ...%s\n" "${BLUE}" "${NORMAL}"
	# 	rm -rf /tmp/$PKG
	# fi

	# printf "%s  Donwloading an updated $PKG from github in /tmp ...%s\n" "${BLUE}" "${NORMAL}"
	# wget $GITHUB/$PKG -O /tmp/$PKG 2> /dev/null

	# if [ -d $PROJECTDIR ]; then
	# 	printf "%s  Removing $PROJECTDIR ...%s\n" "${BLUE}" "${NORMAL}"
	# 	rm -rf $PROJECTDIR
	# fi

	# printf "%s  Unpacking /tmp/$PKG into $PROJECTDIR ...%s\n" "${BLUE}" "${NORMAL}"
	# unzip -qq /tmp/$PKG -d /tmp > /dev/null

	echo "${GREEN}"
	echo "   _____  _____  _____  _____           _____  _____  ____  "
	echo "  |   __||  _  ||  _  ||  |  |   ___   |     ||  _  ||    \ "
	echo "  |  |  ||     ||   __||     |  |___|  |   --||     ||  |  |"
	echo "  |_____||__|__||__|  ||__|__|         |_____||__|__||____/ "
	echo "                                                            "
	echo "  VALIDATION SCRIPT (MADE FOR UBUNTU 16.04)${NORMAL}"
	echo
	echo "   [1] ${BOLD}RUN ALL${NORMAL}"
	echo "   [2] Evaluate altera"
	echo "   [3] Evaluate async"
	echo "   [4] Evaluate cadence"
	echo "   [5] Evaluate design-kits"
	echo "   [6] Evaluate imperas"
	echo "   [7] Evaluate mentor"
	echo "   [8] Evaluate others"
	echo "   [9] Evaluate sesd"
	echo "  [10] Evaluate synopsys"
	echo "  [11] Evaluate xilinx"
	echo
	echo "${BLUE}  Hit CTRL+C to exit${NORMAL}"
	echo

	while :;
	do
	  read -p '  #> ' choice
	  case $choice in
		[1-9]) break ;;
		 10) break ;;
		 11) break ;;
		 *)
			tput cuu1
			tput el1
			tput el
			;;
	  esac
	done
}

header()
{
	echo "  - Evaluating ${YELLOW}${1}${NORMAL}"
}

evaluate()
{
	DIR=$1

	bash -e -c "source $DIR/setup-env.sh; make -s -C $DIR"
	# bash -e -c "make -s -C $DIR"

	# source $DIR/setup-env.sh 1>&- 2>&-  &
	# make -s -C $DIR

	# TESTA SE TEM DISPLAY
	# xhost +si:localuser:$(whoami) >&/dev/null && {
	# 	# echo "${BLUE} Loading the GUI, please wait...${NORMAL}"
	# 	xterm \
	# 		-title 'Installing BASE Software' \
	# 		-fa 'Ubuntu Mono' -fs 12 \
	# 		-bg 'black' -fg 'white' \
	# 		-e "source $DIR/setup-env.sh; make -s -C $DIR"
	# 	# tput cuu1
	# 	# tput el
	# } || {
	# 	bash -c "source $DIR/setup-env.sh; make -s -C $DIR"
	# }

	# STATUS=$ERROR_MODULE_NOT_FOUND
	# echo $STATUS

	STATUS=$?

	case $STATUS in
		0)
			echo "${GREEN}: DONE (status=${STATUS})${NORMAL}"
			;;
		$ERROR_MODULE_NOT_FOUND)
			echo "${BLUE}: Module not found (status=${STATUS})${NORMAL}"
			;;
		*)
			echo "${RED}: Error (status=${STATUS})${NORMAL}"
			;;
	esac
}

validade_altera()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_async()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY

	PROJS=$(find projs -name "makefile")

	for PROJ in $PROJS
	do
		DIR=$(dirname $PROJ)
		PROJ=$(basename $DIR)

		echo -ne "    - $PROJ "

		# bash -c "source $DIR/setup-env.sh; make -s -C $DIR"
		evaluate "$DIR"

	done
}

validade_cadence()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_imperas()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_mentor()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_others()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_sesd()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_synopsys()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_xilinx()
{
	COMPANY=$(echo ${FUNCNAME[0]} | sed 's/validade_//g')
	header $COMPANY
}

validade_all()
{
	validade_altera
	validade_async
	validade_cadence
	validade_imperas
	validade_mentor
	validade_others
	validade_sesd
	validade_synopsys
	validade_xilinx
}

clear
echo
main
clear
echo

# TODO: Update the selector
case $choice in
	 1) validade_all ;;
	 2) validade_altera ;;
	 3) validade_async ;;
	 4) validade_cadence ;;
	 5) validade_design-kits ;;
	 6) validade_imperas ;;
	 7) validade_mentor ;;
	 8) validade_others ;;
	 9) validade_sesd ;;
	10) validade_synopsys ;;
	11) validade_xilinx ;;
esac
