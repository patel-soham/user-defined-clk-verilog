vlib work
vlog a3_3.v
vsim a3_3 +freq=200 +duty=70 +jitter=5
add wave /a3_3/*
run -all
