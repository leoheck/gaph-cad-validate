#!/bin/bash

# TODO: Retornar um erro de modulo nao econtrado (para poder testar em outras maquinas)!
# Por enquanto nao esta funcionando

ERROR_MODULE_NOT_FOUND=200


if [ '$SHELL' = '/bin/zsh' ]; then
	if [ -f /soft64/Modules/current/init/bash ]; then
		source /soft64/Modules/current/init/bash
		export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/soft64/tcltk/lib
	fi
else
	if [ -f /soft64/Modules/current/init/zsh ]; then
		source /soft64/Modules/current/init/zsh
		export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/soft64/tcltk/lib
	fi
fi

module purge &> /dev/null
module load 3d/3.13 &> /dev/null

# module load something_missing &> /dev/null

echo "$?"

if [ "$?" == "127" ];
then
	exit $ERROR_MODULE_NOT_FOUND
else
	exit $?
fi