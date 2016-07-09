#!/bin/bash

# TODO: Retornar um erro de modulo nao econtrado (para poder testar em outras maquinas)!
# Por enquanto nao esta funcionando

ERROR_MODULE_NOT_FOUND=200

SHELL_TYPE=$(basename $SHELL)

if [ -f /soft64/Modules/current/init/$SHELL_TYPE ]; then
	source /soft64/Modules/current/init/$SHELL_TYPE
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/soft64/tcltk/lib
fi

# module purge &> /dev/null
module load 3d/3.13 &> /dev/null

# http://stackoverflow.com/questions/7085360/squelching-glibc-memory-corruption-stack-trace-output
export MALLOC_CHECK_=0

# module load something_missing &> /dev/null
# echo "$?"

# if [ "$?" = "127" ]
# then
# 	exit $ERROR_MODULE_NOT_FOUND
# else
# 	exit $?
# fi