`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:01:14 10/29/2013
// Design Name:   fft_core
// Module Name:   /home/bill/workspace/EmbeddedSystemDesign/zynq_project-master/zynq_custom_ip/hw/ise/fft_peripheral/tb_fft.v
// Project Name:  fft_peripheral
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fft_core
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_fft;

	// Inputs
	reg aclk;
	reg aresetn;
	reg s_axis_config_tvalid;
	reg s_axis_data_tvalid;
	reg s_axis_data_tlast;
	reg m_axis_data_tready;
	reg [7:0] s_axis_config_tdata;
	reg [15:0] inImage;
	reg [15:0] inReal;
	wire [31:0] s_axis_data_tdata={inImage,inReal};

	// Outputs
	wire s_axis_config_tready;
	wire s_axis_data_tready;
	wire m_axis_data_tvalid;
	wire m_axis_data_tlast;
	wire event_frame_started;
	wire event_tlast_unexpected;
	wire event_tlast_missing;
	wire event_status_channel_halt;
	wire event_data_in_channel_halt;
	wire event_data_out_channel_halt;
	wire [47:0] m_axis_data_tdata;
	wire signed[23:0] outReal = m_axis_data_tdata[23:0];
	wire signed[23:0] outImage = m_axis_data_tdata[47:24];

	// Instantiate the Unit Under Test (UUT)
	fft_core uut (
		.aclk(aclk), 
		.aresetn(aresetn), 
		.s_axis_config_tvalid(s_axis_config_tvalid), 
		.s_axis_data_tvalid(s_axis_data_tvalid), 
		.s_axis_data_tlast(s_axis_data_tlast), 
		.m_axis_data_tready(m_axis_data_tready), 
		.s_axis_config_tready(s_axis_config_tready), 
		.s_axis_data_tready(s_axis_data_tready), 
		.m_axis_data_tvalid(m_axis_data_tvalid), 
		.m_axis_data_tlast(m_axis_data_tlast), 
		.event_frame_started(event_frame_started), 
		.event_tlast_unexpected(event_tlast_unexpected), 
		.event_tlast_missing(event_tlast_missing), 
		.event_status_channel_halt(event_status_channel_halt), 
		.event_data_in_channel_halt(event_data_in_channel_halt), 
		.event_data_out_channel_halt(event_data_out_channel_halt), 
		.s_axis_config_tdata(s_axis_config_tdata), 
		.s_axis_data_tdata(s_axis_data_tdata), 
		.m_axis_data_tdata(m_axis_data_tdata)
	);

	initial begin
		// Initialize Inputs
		aclk = 0;
		aresetn = 0;
		s_axis_config_tvalid = 0;
		s_axis_data_tvalid = 0;
		s_axis_data_tlast = 0;
		m_axis_data_tready = 0;
		s_axis_config_tdata = 0;
		inReal = 0;
		inImage = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		aresetn = 1;
		s_axis_data_tvalid = 1;
		m_axis_data_tready = 1;
#2 inReal=128;
#2 inReal=127;
#2 inReal=127;
#2 inReal=126;
#2 inReal=125;
#2 inReal=124;
#2 inReal=122;
#2 inReal=120;
#2 inReal=118;
#2 inReal=115;
#2 inReal=112;
#2 inReal=109;
#2 inReal=106;
#2 inReal=102;
#2 inReal=98;
#2 inReal=94;
#2 inReal=90;
#2 inReal=85;
#2 inReal=81;
#2 inReal=76;
#2 inReal=71;
#2 inReal=65;
#2 inReal=60;
#2 inReal=54;
#2 inReal=48;
#2 inReal=43;
#2 inReal=37;
#2 inReal=31;
#2 inReal=24;
#2 inReal=18;
#2 inReal=12;
#2 inReal=6;
#2 inReal=0;
#2 inReal=-6;
#2 inReal=-12;
#2 inReal=-18;
#2 inReal=-24;
#2 inReal=-31;
#2 inReal=-37;
#2 inReal=-43;
#2 inReal=-48;
#2 inReal=-54;
#2 inReal=-60;
#2 inReal=-65;
#2 inReal=-71;
#2 inReal=-76;
#2 inReal=-81;
#2 inReal=-85;
#2 inReal=-90;
#2 inReal=-94;
#2 inReal=-98;
#2 inReal=-102;
#2 inReal=-106;
#2 inReal=-109;
#2 inReal=-112;
#2 inReal=-115;
#2 inReal=-118;
#2 inReal=-120;
#2 inReal=-122;
#2 inReal=-124;
#2 inReal=-125;
#2 inReal=-126;
#2 inReal=-127;
#2 inReal=-127;
#2 inReal=-127;
#2 inReal=-127;
#2 inReal=-127;
#2 inReal=-126;
#2 inReal=-125;
#2 inReal=-124;
#2 inReal=-122;
#2 inReal=-120;
#2 inReal=-118;
#2 inReal=-115;
#2 inReal=-112;
#2 inReal=-109;
#2 inReal=-106;
#2 inReal=-102;
#2 inReal=-98;
#2 inReal=-94;
#2 inReal=-90;
#2 inReal=-85;
#2 inReal=-81;
#2 inReal=-76;
#2 inReal=-71;
#2 inReal=-65;
#2 inReal=-60;
#2 inReal=-54;
#2 inReal=-48;
#2 inReal=-43;
#2 inReal=-37;
#2 inReal=-31;
#2 inReal=-24;
#2 inReal=-18;
#2 inReal=-12;
#2 inReal=-6;
#2 inReal=0;
#2 inReal=6;
#2 inReal=12;
#2 inReal=18;
#2 inReal=24;
#2 inReal=31;
#2 inReal=37;
#2 inReal=43;
#2 inReal=48;
#2 inReal=54;
#2 inReal=60;
#2 inReal=65;
#2 inReal=71;
#2 inReal=76;
#2 inReal=81;
#2 inReal=85;
#2 inReal=90;
#2 inReal=94;
#2 inReal=98;
#2 inReal=102;
#2 inReal=106;
#2 inReal=109;
#2 inReal=112;
#2 inReal=115;
#2 inReal=118;
#2 inReal=120;
#2 inReal=122;
#2 inReal=124;
#2 inReal=125;
#2 inReal=126;
#2 inReal=127;
#2 inReal=127;
	end
	always #1 aclk = ~ aclk;
	
	always @(posedge aclk) begin
		$display("%d \t outReal\t %d \t outImage\t %d",$time, outReal,outImage);
	end
   
endmodule

