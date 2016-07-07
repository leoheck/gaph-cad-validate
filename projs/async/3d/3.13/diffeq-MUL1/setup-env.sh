
if [ -f /soft64/Modules/current/init/bash ]; then
	source /soft64/Modules/current/init/bash
	export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/soft64/tcltk/lib
fi

module purge
module load 3d/3.13