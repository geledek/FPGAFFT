`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:36:59 10/31/2013
// Design Name:   mulitiplier
// Module Name:   /home/bill/workspace/EmbeddedSystemDesign/zynq_project-master/zynq_custom_ip/hw/ise/fft_peripheral/tb_multi.v
// Project Name:  fft_peripheral
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mulitiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_multi;

	// Inputs
	reg i_clk;
	reg i_rst_n;
	reg [31:0] i_data;
	reg i_data_valid;
	reg i_data_ready;

	// Outputs
	wire o_data_ready;
	wire [31:0] o_data;
	wire o_data_valid;

	// Instantiate the Unit Under Test (UUT)
	mulitiplier uut (
		.i_clk(i_clk), 
		.i_rst_n(i_rst_n), 
		.i_data(i_data), 
		.i_data_valid(i_data_valid), 
		.o_data_ready(o_data_ready), 
		.o_data(o_data), 
		.o_data_valid(o_data_valid), 
		.i_data_ready(i_data_ready)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_rst_n = 0;
		i_data = 0;
		i_data_valid = 0;
		i_data_ready = 0;

		// Wait 100 ns for global reset to finish
		#100;
      i_data = {16'd5,16'd6};
		i_data_valid = 1;
		i_data_ready = 1;
		i_rst_n=1;
		// Add stimulus here

	end
	
	always #1 i_clk=~i_clk;
      
endmodule

