`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:54:40 10/25/2013
// Design Name:   top
// Module Name:   /home/bill/workspace/EmbeddedSystemDesign/FPGAFFT/FFT_HW/FFTHW/testbench.v
// Project Name:  FFTHW
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg i_clk;
	reg i_rst_n;
	reg i_data_valid;
	reg [31:0] i_data;
	reg i_data_ready;

	// Outputs
	wire o_data_ready;
	wire o_data_valid;
	wire [31:0] o_data;

	// Instantiate the Unit Under Test (UUT)
	fft_computer uut (
		.i_clk(i_clk), 
		.i_rst_n(i_rst_n), 
		.i_data_valid(i_data_valid), 
		.i_data(i_data), 
		.o_data_ready(o_data_ready), 
		.o_data_valid(o_data_valid), 
		.o_data(o_data), 
		.i_data_ready(i_data_ready)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_rst_n = 0;
		i_data_valid = 0;
		i_data = 0;
		i_data_ready = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule
