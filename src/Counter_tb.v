`timescale 1ns / 1ps


module Counter_tb(
    );
	reg        clk_in;
	reg        reset_in;
    reg        enable_in;
	reg        clear_in;
    wire [3:0] q_out;
	
    Counter dut (.clk(clk_in), .reset(reset_in), .enable(enable_in), .clear(clear_in), .q(q_out));

    initial begin
	    clk_in = 1'b0;
		reset_in = 1'b1;
		#10 reset_in = 1'b0;
	end
	
	always begin
		#5 clk_in = !clk_in;
	end
	
	initial begin
        enable_in = 1'b1;
		clear_in  = 1'b0;
		#150 
		enable_in = 1'b0;
		#50
		enable_in = 1'b1;
		#50
		clear_in = 1'b1;
		#20
		clear_in = 1'b0;
		#32
		clear_in = 1'b1;
		#2
		clear_in = 1'b0;
		#16
		enable_in = 1'b0;
		#10
		clear_in = 1'b1;
		#10
		clear_in = 1'b0;
		enable_in = 1'b1;
		#40;
    end

endmodule
