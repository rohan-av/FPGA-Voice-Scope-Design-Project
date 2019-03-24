`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2019 21:47:48
// Design Name: 
// Module Name: single_pulse
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


module single_pulse(input clock_sig, pushbutton, output pulse);
    wire Q1;
    wire Q2;
    
    dff dff1(clock_sig, pushbutton,Q1);
    dff dff2(clock_sig, Q1, Q2);
    assign pulse = Q1 & (~Q2);
endmodule
