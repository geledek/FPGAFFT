`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:29 10/29/2013 
// Design Name: 
// Module Name:    dataCtrl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dataCtrl(
input        i_clk,
input        i_rst_n,
input [47:0] i_data,
input        i_data_valid,
output reg [47:0]o_data,
output       o_data_ready,
output  reg  o_data_valid,
input        i_data_ready,
output [6:0] index,
output [6:0] indexNext,
output [1:0] window
);

reg[47:0] data_mem[0:127];

reg[6:0] index;
wire[6:0] indexNext;
assign indexNext = index+1;

reg[47:0] nextValue;

wire[47:0] accOut;
assign accOut = nextValue + i_data;

reg[1:0] window;

assign valid_input_data  = i_data_valid & o_data_ready;
assign valid_output_data = o_data_valid & i_data_ready;

always@(posedge i_clk) begin
	if(!i_rst_n)
		nextValue<=0;
	else
		if(i_data_valid) nextValue<=data_mem[indexNext];
end
integer i;
always@(posedge i_clk) begin
	if(!i_rst_n)
		for (i=0;i<128;i=i+1) begin
			data_mem[i] <= 0;
		end
	else begin
		
		if(window==3 && i_data_valid && i_data_ready) begin
			o_data_valid<=1;
			o_data<={{2{accOut[47]}},accOut[47:2]};
			if (index >=1)data_mem[index-1] <=0;
		end
		else begin 
			if(i_data_valid) data_mem[index]<=accOut;
			o_data_valid<=0;
			o_data<=0;
		end
	end
end

always@(posedge i_clk) begin
	if(!i_rst_n)
		index<=0;
	else begin
		if(i_data_valid)begin
			if(window==3 && i_data_ready) begin index<=index+1; end
			else begin if(window!=3)index<=index+1; end
		end
	end
end

always@(posedge i_clk) begin
	if(!i_rst_n)
		window<=0;
	else
		if(index==127) window<=window+1;
end

endmodule
