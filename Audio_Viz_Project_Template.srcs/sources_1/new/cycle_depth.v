`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 15:24:11
// Design Name: 
// Module Name: cycle_depth
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


module cycle_depth(input CLK, input pushbutton, output reg [1:0] depth = 2'b00);
    wire slow_clock;
    wire pulse;
    
    button_clk slowclk (CLK, slow_clock);
    single_pulse sp1 (slow_clock, pushbutton, pulse);
    
    always@(posedge slow_clock)
        begin
        depth = (pulse == 1)? ((depth == 2'b11)? 2'b00 : depth + 1) : depth ;
        end
endmodule
