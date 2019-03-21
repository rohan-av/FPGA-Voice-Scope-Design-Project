`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2019 21:49:10
// Design Name: 
// Module Name: button_clk
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


module button_clk(input clk_signal, output reg slowclock = 0);
    reg [22:0] counter = 23'b0;
    
    always@(posedge clk_signal)
        begin
            counter <= counter + 1;
            slowclock <= (counter == 0)? ~slowclock : slowclock;
        end 
endmodule
