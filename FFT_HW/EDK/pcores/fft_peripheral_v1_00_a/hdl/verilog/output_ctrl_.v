
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
module output_ctrl(
input        i_clk,
input        i_rst_n,
input [31:0] i_data,
input        i_data_valid,
output [31:0]o_data,
output       o_data_ready,
output       o_data_valid,
input        i_data_ready,
output [9:0] index,
output fifo_rd_en,
output fifo_wr_en,
output [31:0] accOut
);

reg[31:0] data_mem[0:127];

reg[9:0] index;
wire[9:0] indexNext;
assign indexNext = index+1;

wire [6:0] indexShort;
wire [6:0] indexNextShort;

assign indexShort = index[6:0];
assign indexNextShort = indexNext[6:0];

reg[31:0] nextValue;

wire[31:0] accOut;
assign accOut = nextValue + i_data;


wire        fifo_rd_en;
wire        fifo_wr_en;

assign valid_input_data  = i_data_valid & o_data_ready;
assign valid_output_data = o_data_valid & i_data_ready;


assign fifo_wr_en = (index>=128*3 && index<128*4);
assign fifo_rd_en = (index>=128*4);

assign o_data_valid = (index>=128*4 && index<128*5);
assign o_data_ready = !o_data_valid;
always@(posedge i_clk) begin
	if(!i_rst_n)
		nextValue<=0;
	else
		if(i_data_valid) nextValue<=data_mem[indexNextShort];
end
integer i;

wire accStore;
assign accStore = (valid_input_data && index<384);
always@(posedge i_clk) begin
	if(!i_rst_n)
		for (i=0;i<128;i=i+1)
		begin
			data_mem[i] <= 0;
		end
	else
	begin
		if(accStore) data_mem[indexShort]<=accOut;
		else if(valid_input_data) data_mem[indexShort]<=0;
	end
end

always@(posedge i_clk) begin
	if(!i_rst_n)
		index<=0;
	else 
		if(i_data_valid) 
		if(index<128*5-1)index<=index+1;
		else index<=0;
end



output_fifo fifo (
  .s_aclk(i_clk), // input s_aclk
  .s_aresetn(i_rst_n), // input s_aresetn
  .s_axis_tvalid(fifo_wr_en), // input s_axis_tvalid
  .s_axis_tready(), // output s_axis_tready
  .s_axis_tdata({{2{accOut[31]}},accOut[31:2]}), // input [31 : 0] s_axis_tdata
  .m_axis_tvalid(),           // output m_axis_tvalid
  .m_axis_tready(fifo_rd_en), // input m_axis_tready
  .m_axis_tdata(o_data) // output [31 : 0] m_axis_tdata
);


endmodule
