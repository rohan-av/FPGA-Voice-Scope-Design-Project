`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 07:57:25
// Design Name: 
// Module Name: menu_clrselect
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


module menu_clrselect(
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input CLK_VGA,
    output reg [3:0] MENU_OPTIONS
    );
    
    parameter y_top = 410;
    parameter sep = 40;
    
    wire wave_op;
    wire bg_op;
    
    Pixel_On_Text2 #(.displayText("Colour Selector")) m0(
       CLK_VGA,
       40, // text position.x (top left)
       y_top + sep*5, // text position.y (top left)
       VGA_HORZ_COORD, // current position.x
       VGA_VERT_COORD, // current position.y
       wave_op // result, 1 if current pixel is on text, 0 otherwise
    ); 
    
    always@(*) begin
        MENU_OPTIONS = (bg_op | wave_op == 1)? 4'hF : 4'h0;
    end
    
endmodule
