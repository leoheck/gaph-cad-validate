#!/bin/bash

# Leandro Sehnem Heck (leoheck@gmail.com)

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
	echo

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
	echo "  |   __||  _  ||  _  ||  |  |   ___   |   _ ||  _  ||    \ "
	echo "  |  |  ||     ||   __||     |  |___|  |  |_  |     || |  | "
	echo "  |_____||__|__||__|   |__|__|         |_____||__|__||____/ "
	echo "                                                            "
	echo "  VALIDATION SCRIPT (MADE FOR UBUNTU 16.04)${NORMAL}"
	echo
	echo "  [1] ${BOLD}RUN ALL${NORMAL}"
	echo "  [2] Validade Async Tools"
	echo "  [ ] ... todo: add sections/tools here ..."
	echo
	echo "${BLUE}  Hit CTRL+C to exit${NORMAL}"
	echo

	# while :;
	# do
	#   read -p '  #> ' choice
	#   case $choice in
	# 	1 ) break ;;
	# 	2 ) break ;;
	# 	3 ) break ;;
	# 	4 ) break ;;
	# 	* )
	# 		tput cuu1
	# 		tput el1
	# 		tput el
	# 		;;
	#   esac
	# done
}


validade_async()
{
	echo "${YELLOW}Running Tests in ASYNC Tools${NORMAL}"
	PROJS=$(find projs -name "makefile")

	for PROJ in $PROJS
	do
		DIR=$(dirname $PROJ)
		PROJ=$(basename $DIR)

		echo -ne "  - $PROJ "

		# TESTA SE TEM DISPLAY
		xhost +si:localuser:$(whoami) >&/dev/null && {
			# echo "${BLUE} Loading the GUI, please wait...${NORMAL}"
			xterm \
				-title 'Installing BASE Software' \
				-fa 'Ubuntu Mono' -fs 12 \
				-bg 'black' -fg 'white' \
				-e "source $DIR/setup-env.sh; make -s -C $DIR"
			# tput cuu1
			# tput el
		} || {
			bash -c "source $DIR/setup-env.sh; make -s -C $DIR"
		}

		STATUS=$?
		if [ "$STATUS" == "0" ]; then
			echo "${GREEN}DONE${NORMAL}"
		else
			echo "${RED}Error $STATUS${NORMAL}"
		fi

	done
}


validade_cadence()
{
	echo "${YELLOW}Running Tests in Cadence Tools${NORMAL}"
}

validade_synopsys()
{
	echo "${YELLOW}Running Tests in Synopsys Tools${NORMAL}"
}

validade_mentor()
{
	echo "${YELLOW}Running Tests in Mentor Tools${NORMAL}"
}

validade_altera()
{
	echo "${YELLOW}Running Tests in Altera Tools${NORMAL}"
}

validade_xilinx()
{
	echo "${YELLOW}Running Tests in Xlinx Tools${NORMAL}"
}

validade_sesd()
{
	echo "${YELLOW}Running Tests in SESD Tools${NORMAL}"
}

#  add all sections here...

validade_all()
{
	validade_altera
	validade_async
	validade_cadence
	validade_mentor
	validade_sesd
	validade_synopsys
	validade_xilinx
}

# clear
echo
main
# clear

# TODO: Update the selector
case $choice in
	1 ) validade_all ;;
	2 ) validade_async ;;
esac

validade_all
