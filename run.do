vlib work
vlog clk.v
vsim clock_gen +freq=200 +duty=70 +jitter=5
add wave sim:/clock_gen/*
run -all
