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

assign o_data_ready   =   1;

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
		 if(i_data_valid) begin
		 
			//o_data        <=    i_data[15:0]*i_data[15:0] + i_data[32:16]*i_data[32:16];
			//o_data        <=    i_data[23:0];
			_image<=realPart*realPart;
			_real<=imagePart*imagePart;
			o_data <= _image + _real;
			o_data_valid  <=    1;
		  end
	end  
end


endmodule
