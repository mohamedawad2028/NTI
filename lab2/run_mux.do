vlib work
vlog multiplexer.v multiplexor_test.v
vsim -voptargs=+acc work.multiplexor_test
add wave *
run -all
#quit -sim