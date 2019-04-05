`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 11:14:47
// Design Name: 
// Module Name: menu_bg
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


module menu_bg(
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input advanced_sw,
    
    input [3:0] bgcolorr,
    input [3:0] bgcolorg,
    input [3:0] bgcolorb,
    
    output reg [3:0] VGA_MENUR,
    output reg [3:0] VGA_MENUG,
    output reg [3:0] VGA_MENUB
);
    
    parameter sep = 40;
    parameter x_left = 40; 
    
    wire menu_horz = (advanced_sw == 1 && VGA_HORZ_COORD >= 30 && VGA_HORZ_COORD <= 250)? 1: 0;
    wire menu_vert = (advanced_sw == 1 && VGA_VERT_COORD >= 400 && VGA_VERT_COORD <= 800)? 1: 0;
    wire exclude = (advanced_sw == 1 && ~((VGA_HORZ_COORD >= x_left && VGA_HORZ_COORD <= x_left + sep*4)&&(VGA_VERT_COORD >= 410 + sep*6 && VGA_VERT_COORD <= 410 + sep*9))); 
    
    always@(*) begin
        VGA_MENUR <= (menu_horz && menu_vert && exclude)? bgcolorr + 1: 4'h0;
        VGA_MENUG <= (menu_horz && menu_vert && exclude)? bgcolorg + 1: 4'h0;
        VGA_MENUB <= (menu_horz && menu_vert && exclude)? bgcolorb + 1: 4'h0;
      end
endmodule
