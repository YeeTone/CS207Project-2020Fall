`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/13 15:39:59
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
    input [2:0] Select,//0为ADNIN，1为ADD，2为ERROR，3为CHECK
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
                    Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
                end//显示N
            3'b001 :
            begin
                DIG_r = 8'b0000_0010;//显示O
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
            end
            3'b010 :  
            begin 
                DIG_r = 8'b0000_0100;//null
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
            end
            3'b011 : 
            begin 
                DIG_r = 8'b0000_1000;//显示缺货商品
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
            end
            3'b100 : begin 
                DIG_r = 8'b0001_0000;
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
            end//显示N
            3'b101 : 
            begin 
                DIG_r = 8'b0010_0000;//显示O
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
            end
            3'b110 :
            begin 
                DIG_r = 8'b0100_0000;//null
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
            end
            3'b111 : 
            begin 
                DIG_r = 8'b1000_0000;//显示商品
                Y_r = Selct_num(Select,scan_cnt);
//                    case(Select)
//                        0: Y_r = Show_Admin(scan_cnt);
//                        1: Y_r = Show_Add(scan_cnt);
//                        2: Y_r = Show_Error(scan_cnt);
//                        3: Y_r = Show_Check(scan_cnt);
//                    endcase
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
  
  function [6:0] Selct_num;
    input [2:0] Select;
    input [2:0] scan_cnt;
    begin 
                    case(Select)
                        0: Selct_num = Show_Admin(scan_cnt);
                        1: Selct_num = Show_Add(scan_cnt);
                        2: Selct_num = Show_Error(scan_cnt);
                        3: Selct_num = Show_Check(scan_cnt);
                    endcase
    end
    endfunction
  
  function [6:0] Show_Admin;
    input [2:0] scan_cnt;
    begin
        case(scan_cnt)
            0: Show_Admin = 7'b1110111;//A
            1: Show_Admin = 7'b1011110;//D
            2: Show_Admin = 7'b0110111;//N
            3: Show_Admin = 7'b0000110;//I
            4: Show_Admin = 7'b0110111;//N
            default:  Show_Admin = 7'b0000000;
        endcase
       end
    endfunction
    
  function [6:0] Show_Add;
    input [2:0] scan_cnt;
    begin
        case(scan_cnt)
            0: Show_Add = 7'b1110111;//A
            1: Show_Add = 7'b1011110;//D
            2: Show_Add = 7'b1011110;//D
            4: Show_Add = 7'b1110111;//A
            5: Show_Add = 7'b1011110;//D
            6: Show_Add = 7'b1011110;//D
            default:  Show_Add = 7'b0000000;
        endcase
       end
    endfunction


  function [6:0] Show_Error;
    input [2:0] scan_cnt;
    begin
        case(scan_cnt)
            0: Show_Error = 7'b1111001;//E
            1: Show_Error = 7'b0110001;//R
            2: Show_Error = 7'b0110001;//R
            3: Show_Error = 7'b0111111;//O
            4: Show_Error = 7'b0110001;//R
            default:  Show_Error = 7'b0000000;
        endcase
       end
    endfunction
    
function [6:0] Show_Check;
    input [2:0] scan_cnt;
    begin
        case(scan_cnt)
            0: Show_Check = 7'b0111001;//C
            1: Show_Check = 7'b1110110;//H
            2: Show_Check = 7'b1111001;//E
            3: Show_Check = 7'b0111001;//C
            4: Show_Check = 7'b1110110;//K
            default:  Show_Check = 7'b0000000;
        endcase
       end
    endfunction
  endmodule  
