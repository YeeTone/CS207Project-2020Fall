`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/04 09:24:24
// Design Name: 
// Module Name: keyboard_sim
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


module keyboard_sim();
    reg sK1, sK2, sK3, sK4, sK5, sK6, sK7, sK8, sK9;
    wire [15:0] sKey;
    
    keyboard u(sK1, sK2, sK3, sK4, sK5, sK6, sK7, sK8, sK9, sKey);
    
    initial begin
        sK9 <= 0;
        {sK1, sK2, sK3, sK4, sK5, sK6, sK7, sK8} = 8'b00000000;

        repeat(15) begin
            repeat(15)
                #10 {sK5, sK6, sK7, sK8} = {sK5, sK6, sK7, sK8} + 1;
            #10 {sK1, sK2, sK3, sK4} = {sK1, sK2, sK3, sK4} + 1;
            {sK5, sK6, sK7, sK8} = 4'b0000;
        end
        
        #10
        {sK1, sK2, sK3, sK4, sK5} = 5'b11111;
    end
    
endmodule
