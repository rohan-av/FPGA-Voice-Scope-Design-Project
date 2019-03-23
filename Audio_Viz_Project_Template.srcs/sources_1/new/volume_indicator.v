`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2019 15:43:45
// Design Name: 
// Module Name: volume_indicator
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


module volume_indicator(
    input cs,
    input [11:0] sample,
    input freeze_sw,
    input ramp_sw,
    output reg [11:0] intensity, // 12-bit audio sample peak value
    output reg [3:0] ss_enable, // 7seg enable
    output reg [7:0] ss_active  // 7seg segments
    );
    
     reg [12:0]count4hz = 0;
     reg [11:0]samplemax = 12'b0;
     
     reg [7:0] ss_ones = 8'b0;
     reg [7:0] ss_tens = 8'b0;
    
    always @ (posedge cs) begin
             count4hz = (count4hz == 4999)? 0: count4hz + 1;
             
             ss_enable = (ss_enable == 4'b1011)? 4'b1101 : 4'b1011;
             ss_active = (ss_enable == 4'b1011)? ss_tens : ss_ones;
             
             if (count4hz == 0 && ~(freeze_sw == 1)) begin
                if (ramp_sw == 1) begin
                    intensity = 12'b0;
                    ss_ones = 8'b11000000;
                    ss_tens = 8'b11000000;
                end
                
                else if (samplemax >= 3915) begin
                     intensity = 12'b1111_1111_1111;
                     ss_ones = 8'b10100100;
                     ss_tens = 8'b11111001;
                 end
                 
                 else if (samplemax >= 3735) begin
                     intensity = 12'b0111_1111_1111;
                     ss_ones = 8'b11111001;
                     ss_tens = 8'b11111001;
                 end
                 
                 else if (samplemax >= 3555) begin
                     intensity = 12'b0011_1111_1111;
                     ss_ones = 8'b11000000;
                     ss_tens = 8'b11111001;
                 end
                 
                 else if (samplemax >= 3375) begin
                     intensity = 12'b0001_1111_1111;
                     ss_ones = 8'b10010000;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 3195) begin
                     intensity = 12'b0000_1111_1111;
                     ss_ones = 8'b10000000;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 3015) begin
                     intensity = 12'b0000_0111_1111;
                     ss_ones = 8'b11111000;
                     ss_tens = 8'b11000000;
                 end    
                 
                 else if (samplemax >= 2835) begin
                     intensity = 12'b0000_0011_1111;
                     ss_ones = 8'b10000010;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 2655) begin
                     intensity = 12'b0000_0001_1111;
                     ss_ones = 8'b10010010;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 2475) begin
                     intensity = 12'b0000_0000_1111;
                     ss_ones = 8'b10011001;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 2295) begin
                     intensity = 12'b0000_0000_0111;
                     ss_ones = 8'b10110000;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 2115) begin
                     intensity = 12'b0000_0000_0011;
                     ss_ones = 8'b10100100;
                     ss_tens = 8'b11000000;
                 end
                 
                 else if (samplemax >= 1935) begin
                     intensity = 12'b0000_0000_0001;
                     ss_ones = 8'b11111001;
                     ss_tens = 8'b11000000;
                 end
                 
                 else begin
                     intensity = 12'b0;
                     ss_ones = 8'b11000000;
                     ss_tens = 8'b11000000;
                 end    
             end
             
             samplemax = (count4hz == 0)? 0: (sample > samplemax)? sample[11:0]: samplemax[11:0];
         end
endmodule
