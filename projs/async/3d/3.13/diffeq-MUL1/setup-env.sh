
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
