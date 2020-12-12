`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/04 08:58:01
// Design Name: 
// Module Name: keyboard
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


module keyboard(clk, rst_n, row, col, key_num);
    input clk;
    input rst_n;
    input [3:0] row;
    
    output reg [3:0] col;
    output reg [3:0] key_num;
    
    reg [15:0] count;
    
    parameter Time = 50000;
    //parameter Time = 5;
    
    reg flag;
    
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            begin
                count <= 16'b0;
                flag <= 1'b0;
            end
        else
            begin
                if (count < Time - 1)
                    begin
                        count <= count + 1'b1;
                        flag <= 1'b0;
                    end
            else
                begin
                    flag <= 1'b1;
                    count <= 16'b0;
                end
        end
    
    always @ (posedge clk or negedge rst_n)
        if (!rst_n)
            begin
                col <= 4'b0111;
            end
        else
            begin
                if (flag)
                    col <= {col[2:0], col[3]};
                else
                    col <= col;
            end
    
    always @ (posedge clk or negedge rst_n)
        if (!rst_n) begin
            key_num = 4'b0;
        end
        else
            case ({row, col})
                8'b0111_0111: key_num = 4'hf;
                8'b0111_1011: key_num = 4'he;
                8'b0111_1101: key_num = 4'hd;
                8'b0111_1110: key_num = 4'hc;
                
                8'b1011_0111: key_num = 4'hb;
                8'b1011_1011: key_num = 4'ha;
                8'b1011_1101: key_num = 4'h9;
                8'b1011_1110: key_num = 4'h8;
               
                8'b1101_0111: key_num = 4'h7;
                8'b1101_1011: key_num = 4'h6;
                8'b1101_1101: key_num = 4'h5;
                8'b1101_1110: key_num = 4'h4;
               
                8'b1110_0111: key_num = 4'h3;
                8'b1110_1011: key_num = 4'h2;
                8'b1110_1101: key_num = 4'h1;
                8'b1110_1110: key_num = 4'h0;
               
                default: ;
               
            endcase
    
endmodule
