`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/14 08:46:40
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
//    input [2:0] Select,//0为ADNIN，1为ADD，2为ERROR，3为CHECK
    output [7:0] DIG,
    output [7:0] Y,
    output reg signal_end
    );
    reg clkout;
    reg [63:0]cnt;
    reg [2:0]scan_cnt;
    parameter period = 200000;
    
    reg [6:0] Y_r;
    reg [7:0] DIG_r;
    
    reg [2:0] ten_th = 3'b000;
    reg [3:0] sec_th = 4'b1001;
    reg [9:0] clk_cnt = 10'b0000000000;
    
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
                    Y_r = Selct_ten(ten_th);
                end
            3'b001 :
            begin
                DIG_r = 8'b0000_0010;
                Y_r = Selct_sec(sec_th);
            end
            3'b010 :  
            begin 
                DIG_r = 8'b0000_0100;
                Y_r = 7'b1101101;
            end
            3'b011 : 
            begin 
                DIG_r = 8'b0000_1000;
                Y_r = 7'b0000000;
            end
            3'b100 : begin 
                DIG_r = 8'b0001_0000;
                if(ten_th > 3)
                    Y_r = 7'b1111001;
                else
                    Y_r = 7'b0000000;
            end
            3'b101 : 
            begin 
                DIG_r = 8'b0010_0000;
                if(ten_th > 3)
                    Y_r = 7'b0110111;
                else
                    Y_r = 7'b0000000;
            end
            3'b110 :
            begin 
                DIG_r = 8'b0100_0000;
                if(ten_th > 3)
                    Y_r = 7'b1011110;
                else
                    Y_r = 7'b0000000;
            end
            3'b111 : 
            begin 
                DIG_r = 8'b1000_0000;
                Y_r = 7'b0000000;
            end
         endcase
   end
   
   always @(posedge clkout or negedge rst)
   begin
        if(!rst)
            scan_cnt <= 0;
        else begin
            scan_cnt <= scan_cnt + 1;
            clk_cnt <= clk_cnt + 1;
            if(scan_cnt == 3'd7) scan_cnt <= 0;
            if(clk_cnt == 500) begin
                sec_th = sec_th + 1;
                ten_th = ten_th + sec_th/10;
                sec_th = sec_th - (sec_th/10)*10;
                clk_cnt <= 0;
                if(ten_th > 3)
                begin
                    sec_th = 9;
                    ten_th = 4;
                    signal_end = 1;
                end
            end
        end
   end
   
  
  
  //function
  
  function [6:0] Selct_ten;
    input [2:0] ten_th;
    begin
        case(3 - ten_th)
            1: Selct_ten = 7'b0000110;
            2: Selct_ten = 7'b1011011;
            3: Selct_ten = 7'b1001111;
           default: Selct_ten = 7'b0000000;
        endcase
    end
  endfunction
  
 function [6:0] Selct_sec;
    input [3:0] sec_th;
    begin
        case((9 - sec_th)%10)
            0: Selct_sec = 7'b0111111;
            1: Selct_sec = 7'b0000110;
            2: Selct_sec = 7'b1011011;
            3: Selct_sec = 7'b1001111;
            4: Selct_sec = 7'b1100110;
            5: Selct_sec = 7'b1101101;
            6: Selct_sec = 7'b1111101;
            7: Selct_sec = 7'b0100111;
            8: Selct_sec = 7'b1111111;
            9: Selct_sec = 7'b1100111;
           default: Selct_sec = 7'b0000000;
        endcase
    end
  endfunction
  
//  function [6:0] Selct_num;
//    input [2:0] Select;
//    input [2:0] scan_cnt;
//    begin 
//                    case(Select)
//                        0: Selct_num = Show_Admin(scan_cnt);
//                        1: Selct_num = Show_Add(scan_cnt);
//                        2: Selct_num = Show_Error(scan_cnt);
//                        3: Selct_num = Show_Check(scan_cnt);
//                    endcase
//    end
//    endfunction
  
//  function [6:0] Show_Admin;
//    input [2:0] scan_cnt;
//    begin
//        case(scan_cnt)
//            0: Show_Admin = 7'b1110111;//A
//            1: Show_Admin = 7'b1011110;//D
//            2: Show_Admin = 7'b0110111;//N
//            3: Show_Admin = 7'b0000110;//I
//            4: Show_Admin = 7'b0110111;//N
//            default:  Show_Admin = 7'b0000000;
//        endcase
//       end
//    endfunction
    
//  function [6:0] Show_Add;
//    input [2:0] scan_cnt;
//    begin
//        case(scan_cnt)
//            0: Show_Add = 7'b1110111;//A
//            1: Show_Add = 7'b1011110;//D
//            2: Show_Add = 7'b1011110;//D
//            4: Show_Add = 7'b1110111;//A
//            5: Show_Add = 7'b1011110;//D
//            6: Show_Add = 7'b1011110;//D
//            default:  Show_Add = 7'b0000000;
//        endcase
//       end
//    endfunction


//  function [6:0] Show_Error;
//    input [2:0] scan_cnt;
//    begin
//        case(scan_cnt)
//            0: Show_Error = 7'b1111001;//E
//            1: Show_Error = 7'b0110001;//R
//            2: Show_Error = 7'b0110001;//R
//            3: Show_Error = 7'b0111111;//O
//            4: Show_Error = 7'b0110001;//R
//            default:  Show_Error = 7'b0000000;
//        endcase
//       end
//    endfunction
    
//function [6:0] Show_Check;
//    input [2:0] scan_cnt;
//    begin
//        case(scan_cnt)
//            0: Show_Check = 7'b0111001;//C
//            1: Show_Check = 7'b1110110;//H
//            2: Show_Check = 7'b1111001;//E
//            3: Show_Check = 7'b0111001;//C
//            4: Show_Check = 7'b1110110;//K
//            default:  Show_Check = 7'b0000000;
//        endcase
//       end
//    endfunction
  endmodule  
