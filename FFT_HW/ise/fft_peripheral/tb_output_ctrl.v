`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:20:46 11/08/2013
// Design Name:   output_ctrl
// Module Name:   /home/bill/workspace/EmbeddedSystemDesign/zynq_project-master/zynq_custom_ip/hw/ise/fft_peripheral/tb_output_ctrl.v
// Project Name:  fft_peripheral
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: output_ctrl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_output_ctrl;

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
	wire [9:0] index;
	wire fifo_rd_en,fifo_wr_en;
	wire [31:0] accOut;

	// Instantiate the Unit Under Test (UUT)
	output_ctrl uut (
		.i_clk(i_clk), 
		.i_rst_n(i_rst_n), 
		.i_data(i_data), 
		.i_data_valid(i_data_valid), 
		.o_data_ready(o_data_ready), 
		.o_data(o_data), 
		.o_data_valid(o_data_valid), 
		.i_data_ready(i_data_ready)//,
		//.index(index),
		//.fifo_rd_en(fifo_rd_en),
		//.fifo_wr_en(fifo_wr_en),
		//.accOut(accOut)
	);

	initial begin
		// Initialize Inputs
		i_clk = 0;
		i_rst_n = 0;
		i_data = 0;
		i_data_valid = 0;
		i_data_ready = 0;

		// Wait 100 ns for global reset to finish
		#8;
      i_rst_n = 1;
		i_data_valid = 1;
		i_data_ready = 1;
		// Add stimulus here

	end
	
	always #1 i_clk = ~ i_clk;
	always@(posedge i_clk) begin
		i_data<=i_data+1;
		$display("%d \t %d",$time, o_data);
	end

      
endmodule

