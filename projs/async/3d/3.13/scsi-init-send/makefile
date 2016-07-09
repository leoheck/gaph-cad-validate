
src = $(shell find -name "*.nounc")
eqn = $(src:.nounc=.eqn)

all: $(eqn)

%.eqn: %.nounc
	@ 3D $^ > $(^:.nounc=.log) 2>&1

clean:
	@ rm -rf *.eqn
	@ rm -rf *.log
	@ rm -rf *.on
	@ rm -rf *.off
	@ rm -rf *.trans
	@ rm -rf *.pi
	@ rm -rf *.sym
	@ rm -rf *.enc
	@ rm -rf *.unc
	@ rm -rf *.sol
	@ rm -rf *.out.tr
	@ rm -rf *.out.priv
	@ rm -rf *.out
