`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/04 15:59:23
// Design Name: 
// Module Name: Test
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


module Test(
    input rst,
    input clk,
    output [7:0] DIG,
    output [7:0] Y
    );
    reg clkout;
    reg [31:0]cnt;
    reg [2:0]scan_cnt;
    parameter period = 200000;
    
    reg [3:0] Offset = 4'b0;
    reg [9:0] test = 10'b0;
    
    reg [6:0] Y_r;
    reg [7:0] DIG_r;
    assign Y = {1'b1, (~Y_r[6:0])};
    assign DIG = ~DIG_r;
    
    always @(posedge clk or negedge rst)
    begin
    
    
        
        if(test == 500)
        begin
            Offset = Offset + 1;
            test <= 0;
        end
    
        
        if(!rst) begin
            cnt <= 0;
            clkout <= 0;
        end
        else begin
            if(cnt == (period >> 1) - 1)
            begin
                clkout <= ~clkout;
                cnt <= 0;
                test = test + 1;
            end
            else
                cnt <= cnt+1;
       end
  end
  
  
  always @(scan_cnt)
  begin
        case((scan_cnt + Offset)%8)
            3'b000 : DIG_r = 8'b0000_0001;
            3'b001 : DIG_r = 8'b0000_0010;
            3'b010 : DIG_r = 8'b0000_0100;
            3'b011 : DIG_r = 8'b0000_1000;
            3'b100 : DIG_r = 8'b0001_0000;
            3'b101 : DIG_r = 8'b0010_0000;
            3'b110 : DIG_r = 8'b0100_0000;
            3'b111 : DIG_r = 8'b1000_0000;
         endcase
   end
   
   always @(posedge clkout or negedge rst)
   begin
        if(!rst)
            scan_cnt <= 0;
        else begin
            scan_cnt <= scan_cnt + 1;
            if(scan_cnt == 3'd7) scan_cnt <= 0;
        end
   end
   
   always @(scan_cnt)
   begin
        case(scan_cnt+16)
            0: Y_r = 7'b0111111;
            1: Y_r = 7'b0000110;
            2: Y_r = 7'b1011011;
            3: Y_r = 7'b1001111;
            4: Y_r = 7'b1100110;
            5: Y_r = 7'b1101101;
            6: Y_r = 7'b1111101;
            7: Y_r = 7'b0100111;
            8: Y_r = 7'b1111111;
            9: Y_r = 7'b1100111;
            10: Y_r = 7'b1110111;//A
            11: Y_r = 7'b1111100;//B
            12: Y_r = 7'b0111001;//C
            13: Y_r = 7'b1011110;//D
            14: Y_r = 7'b1111001;//E
            15: Y_r = 7'b1110001;//F
            16: Y_r = 7'b1110110;//H
            17: Y_r = 7'b1111001;//E
            18: Y_r = 7'b0111000;//L
            19: Y_r = 7'b0111000;//L
            20: Y_r = 7'b0111111;//O
            default: Y_r = 7'b0000000;
       endcase
  end
endmodule
