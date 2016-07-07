#/!bin/bash

## GERA OS DIRETORIOS DE AVALIACAO

ROOT=projs

for i in $(cat module-list)
do
	case $i in

		# PARSE COMPANY
		\#*)
			COMPANY=$(echo $i | sed "s/\#//g")
			mkdir -p $ROOT/$COMPANY
		;;

		# PARSE TOOL-VERSION
		*)
			TOOL_AND_VERSION=$i
			mkdir -p $ROOT/$COMPANY/$TOOL_AND_VERSION

			echo "#/!bin/bash" > $ROOT/$COMPANY/$TOOL_AND_VERSION/setup-env.sh
			echo "module purge" >> $ROOT/$COMPANY/$TOOL_AND_VERSION/setup-env.sh
			echo "module load ${TOOL_AND_VERSION}" >> $ROOT/$COMPANY/$TOOL_AND_VERSION/setup-env.sh

			echo "all:" > $ROOT/$COMPANY/$TOOL_AND_VERSION/makefile
			echo "clean:" >> $ROOT/$COMPANY/$TOOL_AND_VERSION/makefile
		;;

	esac
done