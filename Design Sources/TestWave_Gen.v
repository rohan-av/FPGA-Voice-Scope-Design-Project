`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 23:12:54
// Design Name: 
// Module Name: TestWave_Gen
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


module TestWave_Gen(input SLOW_CLOCK, output reg [9:0] ramp_sample = 10'b0);
    always@(posedge SLOW_CLOCK)
        begin
            ramp_sample = (ramp_sample == 639)? 0 : ramp_sample + 1;
        end
endmodule
