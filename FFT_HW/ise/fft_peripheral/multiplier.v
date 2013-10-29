module mulitiplier(
input             i_clk,
input             i_rst_n,
input [47:0]      i_data,
input             i_data_valid,
output            o_data_ready,
output reg[47:0]  o_data,
output reg        o_data_valid,
input             i_data_ready
);

assign o_data_ready   =   1;


always @(posedge i_clk)
begin
    if(!i_rst_n)
        o_data_valid   <=  1'b0;
    else
    begin
		 if(i_data_valid) begin
			  //o_data        <=    i_data[23:0]*i_data[23:0] + i_data[47:24]*i_data[47:24];
			  o_data        <=    i_data[23:0];
			  o_data_valid  <=    1;
		  end
	end  
end


endmodule
