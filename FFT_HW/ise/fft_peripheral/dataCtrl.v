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
input [31:0] i_data,
input        i_data_valid,
output reg [31:0]o_data,
output       o_data_ready,
output  reg  o_data_valid,
input        i_data_ready,
output [8:0] index,
output [8:0] indexNext
);

reg[31:0] data_mem[0:127];

reg[8:0] index;
wire[8:0] indexNext;
assign indexNext = index+1;

wire [6:0] indexShort;
wire [6:0] indexNextShort;

assign indexShort = index[6:0];
assign indexNextShort = indexNext[6:0];

reg[31:0] nextValue;

wire[31:0] accOut;
assign accOut = nextValue + i_data;
assign o_data_ready = 1;

assign valid_input_data  = i_data_valid & o_data_ready;
assign valid_output_data = o_data_valid & i_data_ready;

always@(posedge i_clk) begin
	if(!i_rst_n)
		nextValue<=0;
	else
		if(i_data_valid) nextValue<=data_mem[indexNextShort];
end
integer i;

wire accStore;
assign accStore = (i_data_valid && index<384);
always@(posedge i_clk) begin
	if(!i_rst_n)
		for (i=0;i<128;i=i+1)
		begin
			data_mem[i] <= 0;
		end
	else
	begin
		if(accStore) data_mem[indexShort]<=accOut;
		else if(i_data_valid) data_mem[indexShort]<=0;
	end
end

always@(posedge i_clk) begin
	if(index>=384) begin
		o_data_valid<=1;
		o_data<={{2{accOut[31]}},accOut[31:2]};
		//o_data<=accOut;
	end
	else begin
		o_data_valid<=0;
		o_data<=0;
	end
end

always@(posedge i_clk) begin
	if(!i_rst_n)
		index<=0;
	else 
		if(i_data_valid) index<=index+1;
end

endmodule
