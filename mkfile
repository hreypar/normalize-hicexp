# DESCRIPTION:
# mk module to create a normalized hicexp R object
#
# USAGE:
# Single target execution: `mk <TARGET>` where TARGET is
# any line printed by the script `bin/mk-targets`
#
# Multiple target execution in tandem `bin/mk-targets | xargs mk`
#
# AUTHOR: HRG
#
# Run R script to normalize matrices using cyclic loess.
#
results/%.normalized.hicexp.Rds:	data/%.hicexp.Rds
	mkdir -p `dirname $target`
	bin/normalize-hicexp-cycloess.R \
		--vanilla \
		$prereq \
		$target

