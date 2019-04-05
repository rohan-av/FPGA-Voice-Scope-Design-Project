`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 10:36:53
// Design Name: 
// Module Name: colour_boxes
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


module colour_boxes(
    input [7:0] x_coord,
    input [7:0] y_coord,
    input left_click,
    input right_click,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    output reg [3:0] VGA_CBOXR,
    output reg [3:0] VGA_CBOXG,
    output reg [3:0] VGA_CBOXB,
    
    output reg [3:0] VGA_BGR,
    output reg [3:0] VGA_BGG,
    output reg [3:0] VGA_BGB,
    output reg [3:0] VGA_GRR,
    output reg [3:0] VGA_GRG,
    output reg [3:0] VGA_GRB
    );
    
    parameter sep = 40;
    parameter x_left = 40; 
    parameter redrow = 410 + sep*6;
    parameter greenrow = 410 + sep*7;
    parameter bluerow = 410 + sep*8;
    
    wire red = (VGA_VERT_COORD > redrow && VGA_VERT_COORD < redrow + 40);
    wire green = (VGA_VERT_COORD > greenrow && VGA_VERT_COORD < greenrow + 40);
    wire blue = (VGA_VERT_COORD > bluerow && VGA_VERT_COORD < bluerow + 40);
    
    wire mouse_red = (y_coord > redrow && y_coord < redrow + 40);
    wire mouse_green = (y_coord > greenrow && y_coord < greenrow + 40);
    wire mouse_blue = (y_coord > bluerow && y_coord < bluerow + 40);  
    always @(*) begin
        VGA_CBOXR = 4'h0;
        VGA_CBOXG = 4'h0;
        VGA_CBOXB = 4'h0;
        
        VGA_BGR = 4'h0;
        VGA_BGG = 4'h0;
        VGA_BGB = 4'h0;
        VGA_GRR = 4'h0;
        VGA_GRG = 4'h0;
        VGA_GRB = 4'h0;
        
        if (VGA_HORZ_COORD > x_left && VGA_HORZ_COORD < x_left + sep*1) begin   
            VGA_CBOXR <= (red == 1)? 4'h3 : 4'h0;
            VGA_CBOXG <= (green == 1)? 4'h3 : 4'h0;
            VGA_CBOXB <= (blue == 1)? 4'h3 : 4'h0;
            
            VGA_BGR <= (mouse_red == 1 && left_click == 1)? 4'h3: 4'h0;
            VGA_BGG <= (mouse_green == 1 && left_click == 1)? 4'h3: 4'h0;
            VGA_BGB <= (mouse_blue == 1 && left_click == 1)? 4'h3: 4'h0;
            
            VGA_GRR <= (mouse_red == 1 && right_click == 1)? 4'h3: 4'h0;
            VGA_GRG <= (mouse_green == 1 && right_click == 1)? 4'h3: 4'h0;
            VGA_GRB <= (mouse_blue == 1 && right_click == 1)? 4'h3: 4'h0;
        end
        
        else if (VGA_HORZ_COORD > x_left + sep*1 && VGA_HORZ_COORD < x_left + sep*2) begin
            VGA_CBOXR <= (red == 1)? 4'h7 : 4'h0;
            VGA_CBOXG <= (green == 1)? 4'h7 : 4'h0;
            VGA_CBOXB <= (blue == 1)? 4'h7 : 4'h0;
            
            VGA_BGR <= (mouse_red == 1 && left_click == 1)? 4'h7: 4'h0;
            VGA_BGG <= (mouse_green == 1 && left_click == 1)? 4'h7: 4'h0;
            VGA_BGB <= (mouse_blue == 1 && left_click == 1)? 4'h7: 4'h0;
            
            VGA_GRR <= (mouse_red == 1 && right_click == 1)? 4'h7: 4'h0;
            VGA_GRG <= (mouse_green == 1 && right_click == 1)? 4'h7: 4'h0;
            VGA_GRB <= (mouse_blue == 1 && right_click == 1)? 4'h7: 4'h0;
        end
        
        else if (VGA_HORZ_COORD > x_left + sep*2 && VGA_HORZ_COORD < x_left + sep*3) begin
            VGA_CBOXR <= (red == 1)? 4'hB : 4'h0;
            VGA_CBOXG <= (green == 1)? 4'hB : 4'h0;
            VGA_CBOXB <= (blue == 1)? 4'hB : 4'h0;
            
            VGA_BGR <= (mouse_red == 1 && left_click == 1)? 4'hB: 4'h0;
            VGA_BGG <= (mouse_green == 1 && left_click == 1)? 4'hB: 4'h0;
            VGA_BGB <= (mouse_blue == 1 && left_click == 1)? 4'hB: 4'h0;
            
            VGA_GRR <= (mouse_red == 1 && right_click == 1)? 4'hB: 4'h0;
            VGA_GRG <= (mouse_green == 1 && right_click == 1)? 4'hB: 4'h0;
            VGA_GRB <= (mouse_blue == 1 && right_click == 1)? 4'hB: 4'h0;
        end
        
        else if (VGA_HORZ_COORD > x_left + sep*3 && VGA_HORZ_COORD < x_left + sep*4) begin
            VGA_CBOXR <= (red == 1)? 4'hF : 4'h0;
            VGA_CBOXG <= (green == 1)? 4'hF : 4'h0;
            VGA_CBOXB <= (blue == 1)? 4'hF : 4'h0;
            
            VGA_BGR <= (mouse_red == 1 && left_click == 1)? 4'hF: 4'h0;
            VGA_BGG <= (mouse_green == 1 && left_click == 1)? 4'hF: 4'h0;
            VGA_BGB <= (mouse_blue == 1 && left_click == 1)? 4'hF: 4'h0;
            
            VGA_GRR <= (mouse_red == 1 && right_click == 1)? 4'hF: 4'h0;
            VGA_GRG <= (mouse_green == 1 && right_click == 1)? 4'hF: 4'h0;
            VGA_GRB <= (mouse_blue == 1 && right_click == 1)? 4'hF: 4'h0;
        end
        end
endmodule
