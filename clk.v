// Verilog code to generate user defined frequency, duty cycle
// and jitter clock
// Select timescale appropriately to make sure your desired numberss
// are not rounded off, rather shows up with more precision
`timescale 1ns/1ps
module clock_gen;
  reg clk;
  real freq, tp, duty, jitter, jitter_factor, tp_jitter;
  real prev_time, current_time, freq_check, tp_check;
  
  always begin
    jitter_factor = $urandom_range(100-jitter,100+jitter)/100.0;
    tp_jitter = tp * jitter_factor;
    
    #(tp_jitter * ((100-duty)/100.0)) 
    clk=1;
    #(tp_jitter * (duty/100.0)) 
    clk=0;
  end

  initial begin
	// initialize variables
	clk = 0;
	freq = 0;
	tp = 0;
	duty = 0;
	jitter = 0;
	jitter_factor = 0;
	tp_jitter = 0;
	prev_time = 0;
	current_time = 0;
	freq_check = 0;
	tp_check =0;

	// Take input arguments 
    $value$plusargs("freq=%f",freq); // Frequency is in MHz
    $value$plusargs("duty=%f",duty); // Duty cycle in %
    $value$plusargs("jitter=%f",jitter); // Jitter in %
    
    $monitor("Freq check = %f Freq cal = %f",freq_check,1000/tp_jitter); 
    tp = 1000.0/freq; // Mhz to ns
    #200
    $finish;
  end

  // For EDA playground
  /*initial begin 
    $dumpfile("1.vcd");
    $dumpvars;
  end*/
  
  // logic to check generated clock frequency
  always @ (posedge clk) begin
    prev_time = current_time;
    current_time = $realtime;
    tp_check = current_time - prev_time;
    freq_check = 1000.0/(tp_check); // ns to Mhz
  end
endmodule

