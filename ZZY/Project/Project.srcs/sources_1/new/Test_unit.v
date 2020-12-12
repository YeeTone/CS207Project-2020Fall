`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/12 18:47:58
// Design Name: 
// Module Name: Test_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Test_unit(clk,rst_n,keyin,keyscan,LED);

 input 			clk,rst_n;
 input 	[3:0]		keyin;
 output 	[3:0] 	keyscan;
 output	reg 	[15:0]	LED; 

 wire [4:0] real_number;
 
 	keyscan0 u2(
				.clk(clk),
				.rst_n(rst_n),
				.keyscan(keyscan),
				.keyin(keyin),
				.real_number(real_number)
				);

always @(*)
	case(real_number)
		5'd0:	LED	<=	16'b0_00000_00000_00001;
		5'd1:	LED	<=	16'b0_00000_00000_00010;
		5'd2:	LED	<=	16'b0_00000_00000_00100;
		5'd3:	LED	<=	16'b0_00000_00000_01000;
		5'd4:	LED	<=	16'b0_00000_00000_10000;
		5'd5:	LED	<=	16'b0_00000_00001_00000;
		5'd6:	LED	<=	16'b0_00000_00010_00000;
		5'd7:	LED	<=	16'b0_00000_00100_00000;
		5'd8:	LED	<=	16'b0_00000_01000_00000;
		5'd9:	LED	<=	16'b0_00000_10000_00000;
		5'd10:  LED	<=	16'b0_00001_00000_00000;
		5'd11:  LED	<=	16'b0_00010_00000_00000;
		5'd12:  LED	<=	16'b0_00100_00000_00000;
		5'd13:  LED	<=	16'b0_01000_00000_00000;
		5'd14:  LED	<=	16'b0_10000_00000_00000;
		5'd15:  LED	<=	16'b1_00000_00000_00000;
	default:	LED	<= ~16'b1_11111_11111_11111;
	endcase 
endmodule 
