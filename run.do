vlib work
vlog clk.v
vsim clk +freq=200 +duty=70 +jitter=5
add wave sim:/clk/*
run -all
