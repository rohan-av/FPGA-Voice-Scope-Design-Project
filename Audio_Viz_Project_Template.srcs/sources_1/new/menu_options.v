`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 23:09:18
// Design Name: 
// Module Name: menu_options
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


module menu_options(
    input freeze_sw,
    input ramp_sw,
    
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input CLK_VGA,
    output reg [3:0] MENU_TEXTR = 4'h0,
    output reg [3:0] MENU_TEXTG = 4'h0,
    output reg [3:0] MENU_TEXTB = 4'h0
    );
    
    //menu options text coordinates
    parameter x_left = 40; 
    parameter y_top = 440;
    parameter sep = 40;
    
    wire freeze_op;
    wire test_op;
     
    wire freeze_option;
    wire test_option;
    
    Pixel_On_Text2 #(.displayText("Freeze")) m0(
       CLK_VGA,
       x_left, // text position.x (top left)
       y_top + sep*0, // text position.y (top left)
       VGA_HORZ_COORD, // current position.x
       VGA_VERT_COORD, // current position.y
       freeze_op // result, 1 if current pixel is on text, 0 otherwise
    ); 
    
    Pixel_On_Text2 #(.displayText("Test wave")) m1(
       CLK_VGA,
       x_left, // text position.x (top left)
       y_top + sep*1, // text position.y (top left)
       VGA_HORZ_COORD, // current position.x
       VGA_VERT_COORD, // current position.y
       test_op // result, 1 if current pixel is on text, 0 otherwise
    );
    
    assign freeze_option = (freeze_op == 1 && freeze_sw == 1)? 1: 0;
    assign test_option = (test_op == 1 && ramp_sw == 1)? 1: 0;
      
    always@(*) begin
        if ((freeze_option && VGA_VERT_COORD < y_top + sep*1 && VGA_VERT_COORD >= y_top + sep*0) || (test_option && VGA_VERT_COORD < y_top + sep*2 && VGA_VERT_COORD >= y_top + sep*1)) begin
            MENU_TEXTG = 4'hF;
        end
        
        else begin
            MENU_TEXTG = 4'h0;
        end
    end   
endmodule
