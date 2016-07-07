
src = $(shell find -name "*.nounc")
eqn = $(src:.nounc=.eqn)

all: $(eqn)

%.eqn: %.nounc
	@ 3D $^ | tee $(^:.nounc=.log)

clean:
	@ rm -rf *.eqn
	@ rm -rf *.log
	@ rm -f *.on
	@ rm -f *.off
	@ rm -f *.trans
	@ rm -f *.pi
	@ rm -f *.sym
	@ rm -f *.enc
	@ rm -f *.unc
	@ rm -f *.sol
	@ rm -f *.out.tr
	@ rm -f *.out.priv
	@ rm -f *.out
