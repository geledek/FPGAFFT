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
	reg [15:0] s_axis_config_tdata;
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
	wire [31:0] m_axis_data_tdata;
	wire [15:0] outReal = m_axis_data_tdata[15:0];
	wire [15:0] outImage = m_axis_data_tdata[31:16];

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
#1 inReal=128;
#1 inReal=127;
#1 inReal=127;
#1 inReal=126;
#1 inReal=125;
#1 inReal=124;
#1 inReal=122;
#1 inReal=120;
#1 inReal=118;
#1 inReal=115;
#1 inReal=112;
#1 inReal=109;
#1 inReal=106;
#1 inReal=102;
#1 inReal=98;
#1 inReal=94;
#1 inReal=90;
#1 inReal=85;
#1 inReal=81;
#1 inReal=76;
#1 inReal=71;
#1 inReal=65;
#1 inReal=60;
#1 inReal=54;
#1 inReal=48;
#1 inReal=43;
#1 inReal=37;
#1 inReal=31;
#1 inReal=24;
#1 inReal=18;
#1 inReal=12;
#1 inReal=6;
#1 inReal=0;
#1 inReal=-6;
#1 inReal=-12;
#1 inReal=-18;
#1 inReal=-24;
#1 inReal=-31;
#1 inReal=-37;
#1 inReal=-43;
#1 inReal=-48;
#1 inReal=-54;
#1 inReal=-60;
#1 inReal=-65;
#1 inReal=-71;
#1 inReal=-76;
#1 inReal=-81;
#1 inReal=-85;
#1 inReal=-90;
#1 inReal=-94;
#1 inReal=-98;
#1 inReal=-102;
#1 inReal=-106;
#1 inReal=-109;
#1 inReal=-112;
#1 inReal=-115;
#1 inReal=-118;
#1 inReal=-120;
#1 inReal=-122;
#1 inReal=-124;
#1 inReal=-125;
#1 inReal=-126;
#1 inReal=-127;
#1 inReal=-127;
#1 inReal=-127;
#1 inReal=-127;
#1 inReal=-127;
#1 inReal=-126;
#1 inReal=-125;
#1 inReal=-124;
#1 inReal=-122;
#1 inReal=-120;
#1 inReal=-118;
#1 inReal=-115;
#1 inReal=-112;
#1 inReal=-109;
#1 inReal=-106;
#1 inReal=-102;
#1 inReal=-98;
#1 inReal=-94;
#1 inReal=-90;
#1 inReal=-85;
#1 inReal=-81;
#1 inReal=-76;
#1 inReal=-71;
#1 inReal=-65;
#1 inReal=-60;
#1 inReal=-54;
#1 inReal=-48;
#1 inReal=-43;
#1 inReal=-37;
#1 inReal=-31;
#1 inReal=-24;
#1 inReal=-18;
#1 inReal=-12;
#1 inReal=-6;
#1 inReal=0;
#1 inReal=6;
#1 inReal=12;
#1 inReal=18;
#1 inReal=24;
#1 inReal=31;
#1 inReal=37;
#1 inReal=43;
#1 inReal=48;
#1 inReal=54;
#1 inReal=60;
#1 inReal=65;
#1 inReal=71;
#1 inReal=76;
#1 inReal=81;
#1 inReal=85;
#1 inReal=90;
#1 inReal=94;
#1 inReal=98;
#1 inReal=102;
#1 inReal=106;
#1 inReal=109;
#1 inReal=112;
#1 inReal=115;
#1 inReal=118;
#1 inReal=120;
#1 inReal=122;
#1 inReal=124;
#1 inReal=125;
#1 inReal=126;
#1 inReal=127;
#1 inReal=127;
	end
	always #1 aclk = ~ aclk;
	
	always @(posedge aclk) begin
		$display("%d \t outReal\t %d \t outImage\t %d",$time, outReal,outImage);
	end
      
endmodule

