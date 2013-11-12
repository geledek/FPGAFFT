module mulitiplier(
input             i_clk,
input             i_rst_n,
input [31:0]      i_data,
input             i_data_valid,
output            o_data_ready,
output reg[31:0]  o_data,
output reg        o_data_valid,
input             i_data_ready
);

assign o_data_ready   =   i_data_ready;

//Just pipeline the input data valid to make the output data valid since output data is one clock delayed
//from the input data

reg signed [31:0]  _image;
reg signed [31:0]  _real;

wire signed [15:0] realPart;
wire signed [15:0] imagePart;
assign realPart = i_data[15:0];
assign imagePart = i_data[31:16];

always @(posedge i_clk)
begin
    if(!i_rst_n)
        o_data_valid   <=  1'b0;
    else
    begin
		_image<=realPart*realPart;
		_real<=imagePart*imagePart;
		o_data <= _image + _real;
		o_data_valid  <=    i_data_valid;
	end  
end


endmodule
