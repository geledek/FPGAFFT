module top(input FMC_CLK1_P, output[7:0] SW);
	reg [7:0] SW;
	// Inputs
	wire i_clk;
	assign i_clk = FMC_CLK1_P;
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
		i_rst_n = 0;
		i_data_valid = 0;
		i_data = 0;
		i_data_ready = 0;
	end
	
	always @(posedge i_clk)
	begin
		i_data<=i_data+1;
		i_data_valid<=1;
		i_data_valid<= 1;
		SW <= o_data[7:0]+o_data[15:8]+o_data[23:16]+o_data[31:24];
	end
	

endmodule

