`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 14:58:30
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
    input [2:0] num,
    output [7:0] DIG,
    output [7:0] Y
    );
    reg clkout;
    reg [63:0]cnt;
    reg [2:0]scan_cnt;
    parameter period = 200000;
    
    reg [6:0] Y_r;
    reg [7:0] DIG_r;
    
    assign Y = {1'b1, (~Y_r[6:0])};
    assign DIG = ~DIG_r;
    
    always @(posedge clk or negedge rst)
    begin

        if(!rst) begin
            cnt <= 0;
            clkout <= 0;
        end
        else begin
            if(cnt == (period >> 1) - 1)
            begin
                clkout <= ~clkout;
                cnt <= 0;
            end
            else
                cnt <= cnt+1;
       end
  end
  
  
  always @(scan_cnt)
  begin
        case(scan_cnt)
            3'b000 : 
                begin 
                    DIG_r = 8'b0000_0001;
                    Y_r = 7'b0110111;
                end//��ʾN
            3'b001 :
            begin
                DIG_r = 8'b0000_0010;//��ʾO
                Y_r = 7'b0111111;
            end
            3'b010 :  DIG_r = 8'b0000_0000;//null
            3'b011 : 
            begin 
                DIG_r = 8'b0000_1000;//��ʾȱ����Ʒ
                 Y_r = Show_alpha(num);
            end
            3'b100 : begin 
                DIG_r = 8'b0001_0000;
                Y_r = 7'b0110111;
            end//��ʾN
            3'b101 : 
            begin 
                DIG_r = 8'b0010_0000;//��ʾO
                Y_r = 7'b0111111;
            end
            3'b110 : DIG_r = 8'b0000_0000;//null
            3'b111 : 
            begin 
                DIG_r = 8'b1000_0000;//��ʾ��Ʒ
                Y_r = Show_alpha(num);
            end
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
   
  
  
  //function
  function [6:0] Show_num;
  
    input [2:0] num;
    begin
        case(num)
            0: Show_num = 7'b0111111;
            1: Show_num = 7'b0000110;
            2: Show_num = 7'b1011011;
            3: Show_num = 7'b1001111;
            4: Show_num = 7'b1100110;
            5: Show_num = 7'b1101101;
            6: Show_num = 7'b1111101;
            default:  Show_num = 7'b0000000;
        endcase
       end
    endfunction
    
    
    function [6:0] Show_alpha;
    input [2:0] num;
    begin
        case(num)
            1: Show_alpha = 7'b1110111;//A
            2: Show_alpha = 7'b1111100;//B
            3: Show_alpha = 7'b0111001;//C
            4: Show_alpha = 7'b1011110;//D
            5: Show_alpha = 7'b1111001;//E
            6: Show_alpha = 7'b1110001;//F
            default:  Show_alpha = 7'b0000000;
        endcase
    end  
    endfunction
  endmodule  
