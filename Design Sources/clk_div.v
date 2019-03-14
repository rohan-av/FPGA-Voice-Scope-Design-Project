`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 15:26:39
// Design Name: 
// Module Name: clk_div
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


module clk_div(input CLK, output reg SLOW_CLK = 0);
    reg [11:0] counter = 12'b0;
    
    always@(posedge CLK)
        begin
            counter <= (counter == 2499)? 0 : counter + 1;
            SLOW_CLK = (counter == 0)? ~SLOW_CLK : SLOW_CLK;
        end  
endmodule