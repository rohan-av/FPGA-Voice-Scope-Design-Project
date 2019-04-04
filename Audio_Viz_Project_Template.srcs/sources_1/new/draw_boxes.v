`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 18:07:48
// Design Name: 
// Module Name: draw_boxes
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


module draw_boxes(
    input advanced_sw,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    output reg [3:0] VGA_Red_Grid,
    output reg [3:0] VGA_Green_Grid,
    output reg [3:0] VGA_Blue_Grid
    );
    
    //scaled wave properties
    parameter scale = 6;
    parameter xadjust = 30;
    parameter yadjust = 750;
    
    //envelope wave properties
    parameter scale2 = 6;
    parameter xadjust2 = 1280 - 30 - (1280/scale2);
    parameter yadjust2 = 750;
    
    always@(*) begin
        VGA_Red_Grid = 4'h0;
        VGA_Green_Grid = 4'h0;
        VGA_Blue_Grid = 4'h0;
     // box for scaled wave
           if (advanced_sw == 1 && ((VGA_HORZ_COORD == xadjust || VGA_HORZ_COORD == (xadjust + 1280/scale)) && (VGA_VERT_COORD >= (1024 - yadjust - 1024/scale) && VGA_VERT_COORD <= (1024 - yadjust))))
               begin
                   VGA_Red_Grid = 4'hF;
                   VGA_Green_Grid = 4'hF;
                   VGA_Blue_Grid = 4'hF;
               end
               
           if (advanced_sw == 1 && ((VGA_VERT_COORD == (1024 - yadjust) || VGA_VERT_COORD == (1024 - yadjust - 1024/scale)) && (VGA_HORZ_COORD >= xadjust && VGA_HORZ_COORD <= (xadjust + 1280/scale))))
               begin
                   VGA_Red_Grid = 4'hF;
                   VGA_Green_Grid = 4'hF;
                   VGA_Blue_Grid = 4'hF;
               end
               
           //box for envelope
           if (advanced_sw == 1 && ((VGA_HORZ_COORD == xadjust2 || VGA_HORZ_COORD == (xadjust2 + 1280/scale2)) && (VGA_VERT_COORD >= (1024 - yadjust2 - 1024/scale2) && VGA_VERT_COORD <= (1024 - yadjust2))))
                begin
                    VGA_Red_Grid = 4'hF;
                    VGA_Green_Grid = 4'hF;
                    VGA_Blue_Grid = 4'hF;
                end
                
           if (advanced_sw == 1 && ((VGA_VERT_COORD == (1024 - yadjust2) || VGA_VERT_COORD == (1024 - yadjust2 - 1024/scale2)) && (VGA_HORZ_COORD >= xadjust2 && VGA_HORZ_COORD <= (xadjust2 + 1280/scale2))))
                begin
                    VGA_Red_Grid = 4'hF;
                    VGA_Green_Grid = 4'hF;
                    VGA_Blue_Grid = 4'hF;
                end
        end
endmodule
