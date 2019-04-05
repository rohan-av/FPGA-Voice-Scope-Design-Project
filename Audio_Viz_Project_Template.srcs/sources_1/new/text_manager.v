`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 08:50:00
// Design Name: 
// Module Name: text_manager
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


module text_manager(
    input CLK,
    input advanced_sw,
    input [3:0] MENU_R,
    input [3:0] MENU_G,
    input [3:0] MENU_B,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [3:0] MENU_OPTIONS,
    output reg [3:0] TEXTR,
    output reg [3:0] TEXTG,
    output reg [3:0] TEXTB
    );
    
    wire CLK_VGA;
    
    // VGA Clock Generator (108MHz)
    CLK_108M VGA_CLK_108M( 
            CLK,   // 100 MHz
            CLK_VGA     // 108 MHz
        ) ;
        
     //max volume indicator + accompanying text coordinates   
    parameter maxvol_x = 1100;
    parameter maxvol_y = 950;
    
    // Text Generation
    wire basic1;
    wire advanced1;
    
     //Overall   
     Pixel_On_Text2 #(.displayText("EE2026 VOICE SCOPE")) t1(
         CLK_VGA,
         25, // text position.x (top left)
         25, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         basic1  // result, 1 if current pixel is on text, 0 otherwise
      );
       
       Pixel_On_Text2 #(.displayText("(ADVANCED)")) t2(
           CLK_VGA,
           180, // text position.x (top left)
           25, // text position.y (top left)
           VGA_HORZ_COORD, // current position.x
           VGA_VERT_COORD, // current position.y
           advanced1  // result, 1 if current pixel is on text, 0 otherwise
        );
     
     
     wire res;
     Pixel_On_Text2 #(.displayText("CURRENT VOLUME")) t3(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         res  // result, 1 if current pixel is on text, 0 otherwise
      );
      
      wire [3:0] TEXT0;
      wire [3:0] TEXT1;
      
      assign TEXT0 = ((advanced_sw == 1 && advanced1 == 1) || basic1 == 1)? 4'hF : 4'h0;
      assign TEXT1 = (res == 1)? 4'hF : 4'h0;
      
      always@(*) begin
        TEXTR <= (advanced_sw == 1)? (TEXT0 | TEXT1 | MENU_OPTIONS | MENU_R) : TEXT0;
        TEXTG <= (advanced_sw == 1)? (TEXT0 | TEXT1 | MENU_OPTIONS | MENU_G) : TEXT0;
        TEXTB <= (advanced_sw == 1)? (TEXT0 | TEXT1 | MENU_OPTIONS | MENU_B) : TEXT0;
      end
endmodule

/*    wire percent0;
    wire percent1;
    wire percent2;
    wire percent3;
    wire percent4;
    wire percent5;
    wire percent6;
    wire percent7;
    wire percent8;
    wire percent9;
    wire percent10;
    wire percent11;
    wire percent12;
      
      //Volume specific
      Pixel_On_Text2 #(.displayText("100%")) p12(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent12  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("092%")) p11(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent11  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("083%")) p10(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent10  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("075%")) p9(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent9  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("067%")) p8(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent8  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("058%")) p7(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent7  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("050%")) p6(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent6  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("042%")) p5(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent5  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("033%")) p4(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent4  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
      Pixel_On_Text2 #(.displayText("025%")) p3(
         CLK_VGA,
         maxvol_x - 55, // text position.x (top left)
         maxvol_y + 15, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         percent3  // result, 1 if current pixel is on text, 0 otherwise
      ); 
      
       Pixel_On_Text2 #(.displayText("017%")) p2(
          CLK_VGA,
          maxvol_x - 55, // text position.x (top left)
          maxvol_y + 15, // text position.y (top left)
          VGA_HORZ_COORD, // current position.x
          VGA_VERT_COORD, // current position.y
          percent2  // result, 1 if current pixel is on text, 0 otherwise
       ); 
      
      Pixel_On_Text2 #(.displayText("008%")) p1(
          CLK_VGA,
          maxvol_x - 55, // text position.x (top left)
          maxvol_y + 15, // text position.y (top left)
          VGA_HORZ_COORD, // current position.x
          VGA_VERT_COORD, // current position.y
          percent1  // result, 1 if current pixel is on text, 0 otherwise
       );
          
      Pixel_On_Text2 #(.displayText("000%")) p0(
          CLK_VGA,
          maxvol_x - 55, // text position.x (top left)
          maxvol_y + 15, // text position.y (top left)
          VGA_HORZ_COORD, // current position.x
          VGA_VERT_COORD, // current position.y
          percent0  // result, 1 if current pixel is on text, 0 otherwise
       );*/
    
 

     
/*     always@(*) begin
        case(level)
            4'h0:
                TEXT2 <= (percent0 == 1)? 4'hF : 4'h0;
            4'h1:
                TEXT2 <= (percent1 == 1)? 4'hF : 4'h0;
            4'h2:
                TEXT2 <= (percent2 == 1)? 4'hF : 4'h0; 
            4'h3:
                TEXT2 <= (percent3 == 1)? 4'hF : 4'h0;
            4'h4:
                TEXT2 <= (percent4 == 1)? 4'hF : 4'h0;
            4'h5:
                TEXT2 <= (percent5 == 1)? 4'hF : 4'h0;
            4'h6:
                TEXT2 <= (percent6 == 1)? 4'hF : 4'h0;
            4'h7:
                TEXT2 <= (percent7 == 1)? 4'hF : 4'h0;
            4'h8:
                TEXT2 <= (percent8 == 1)? 4'hF : 4'h0;
            4'h9:
                TEXT2 <= (percent9 == 1)? 4'hF : 4'h0;
            4'hA:
                TEXT2 <= (percent10 == 1)? 4'hF : 4'h0;
            4'hB:
                TEXT2 <= (percent11 == 1)? 4'hF : 4'h0;
            default:
                TEXT2 <= (percent12 == 1)? 4'hF : 4'h0;
        endcase
    end*/