`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// - VGA_HORZ_COORD changes at a rate of 108 MHz (CLK_VGA) to traverse each pixel in a row, while VGA_VERT_COORD changes at a rate of ~63.98 KHz to 
//   scan each row one by one and back to the top. These tech details are handled by vga_ctrl.vhd. One only needs to make use of these coordinates 
//   to output whatever they want at desired pixel locations. 
// 
// - VGA_ACTIVE is a binary indicator specifying when VGA_HORZ_COORD, VGA_VERT_COORD are valid (i.e., within the 1024 x 1280 pixel screen). For technical 
//   reasons the said coordinates do go outside this screen area for a short while and no VGA signal should be output during this time (it will and does
//   mess up the display). 
//
// - Hence, VGA_ACTIVE, VGA_HORZ_COORD and VGA_VERT_COORD may be used in conjunction with each other to generate VGA_RED, VGA_GREEN, VGA_BLUE. The Sync
//   signals should be output to the VGA port as well, and are responsible to generate the raster scan on the screen       
// 
//////////////////////////////////////////////////////////////////////////////////


module VGA_DISPLAY(
    input CLK,
    input advanced_sw,
    
    input level,
    
    input [3:0] VGA_RED_WAVEFORM, 
    input [3:0] VGA_GREEN_WAVEFORM, 
    input [3:0] VGA_BLUE_WAVEFORM,
    
    input [3:0] VGA_RED_JOY_WAVEFORM,
    input [3:0] VGA_GREEN_JOY_WAVEFORM,
    input [3:0] VGA_BLUE_JOY_WAVEFORM,
    
    input [3:0] VGA_RED_GRID,
    input [3:0] VGA_GREEN_GRID,
    input [3:0] VGA_BLUE_GRID,
    
    input [3:0] VGA_RED_VOL,
    input [3:0] VGA_GREEN_VOL,
    input [3:0] VGA_BLUE_VOL,
    
    input [3:0] VGA_RED_BOX,
    input [3:0] VGA_GREEN_BOX,
    input [3:0] VGA_BLUE_BOX,
    
    input [3:0] MENU_R,
    input [3:0] MENU_G,
    input [3:0] MENU_B,
    
    output [11:0] VGA_HORZ_COORD,
    output [11:0] VGA_VERT_COORD, 

    output reg[3:0] VGA_RED,    // RGB outputs to VGA connector (4 bits per channel gives 4096 possible colors)
    output reg[3:0] VGA_GREEN,
    output reg[3:0] VGA_BLUE,
    output reg VGA_VS,          // horizontal & vertical sync outputs to VGA connector
    output reg VGA_HS,
    output reg VGA_CLOCK = 1'b0
    );
    
    wire CLK_VGA;
    //max volume indicator + accompanying text coordinates   
    parameter maxvol_x = 1100;
    parameter maxvol_y = 950;
    
    // Text Generation
    wire basic1;
    wire advanced1;
    
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
    
    //Overall   
    Pixel_On_Text2 #(.displayText("EE2026 VOICE SCOPE")) t1(
        CLK_VGA,
        25, // text position.x (top left)
        25, // text position.y (top left)
        VGA_HORZ_COORD, // current position.x
        VGA_VERT_COORD, // current position.y
        basic1  // result, 1 if current pixel is on text, 0 otherwise
     );
      
      Pixel_On_Text2 #(.displayText("EE2026 VOICE SCOPE (ADVANCED)")) t2(
          CLK_VGA,
          25, // text position.x (top left)
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
     reg [3:0] TEXT2 = 4'h0;
     
     assign TEXT0 = (advanced_sw == 0)? ((basic1 == 1)? 4'hF : 4'h0) : (advanced1 == 1)? 4'hF : 4'h0;
     assign TEXT1 = (res == 1)? 4'hF : 4'h0;
     
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
            
    // COMBINE ALL OUTPUTS ON EACH CHANNEL
    wire[3:0] VGA_RED_CHAN = (advanced_sw == 1) ? ( VGA_RED_GRID | VGA_RED_VOL |  VGA_RED_BOX | VGA_RED_WAVEFORM | VGA_RED_JOY_WAVEFORM | TEXT0 | TEXT1 | TEXT2 | MENU_R) : (VGA_RED_GRID | VGA_RED_WAVEFORM | TEXT0) ;
    wire[3:0] VGA_GREEN_CHAN = (advanced_sw == 1) ? (VGA_GREEN_GRID | VGA_GREEN_VOL |  VGA_GREEN_BOX | VGA_GREEN_WAVEFORM | VGA_GREEN_JOY_WAVEFORM | TEXT0 | TEXT1 | TEXT2 | MENU_G) : (VGA_GREEN_GRID | VGA_GREEN_WAVEFORM | TEXT0) ; 
    wire[3:0] VGA_BLUE_CHAN = (advanced_sw == 1) ? (VGA_BLUE_GRID | VGA_BLUE_VOL |  VGA_BLUE_BOX | VGA_BLUE_WAVEFORM | VGA_BLUE_JOY_WAVEFORM | TEXT0 | TEXT1 | TEXT2 | MENU_B) : (VGA_BLUE_GRID | VGA_BLUE_WAVEFORM | TEXT0); 
    
    // VGA Clock Generator (108MHz)
    CLK_108M VGA_CLK_108M( 
            CLK,   // 100 MHz
            CLK_VGA     // 108 MHz
        ) ; 
        
    // VGA CONTROLLER   
    wire VGA_ACTIVE;
    wire VGA_HORZ_SYNC;
    wire VGA_VERT_SYNC; 
    
    VGA_CONTROL VGA_CONTROL(
            CLK_VGA,
            VGA_HORZ_SYNC,
            VGA_VERT_SYNC,
            VGA_ACTIVE,  
            VGA_HORZ_COORD,  
            VGA_VERT_COORD  
        ) ; 
    

    // CLOCK THEM OUT
    always@(posedge CLK_VGA) begin      
            VGA_CLOCK <= ~VGA_CLOCK;
            VGA_RED <= {VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE} & VGA_RED_CHAN ;  
            VGA_GREEN <= {VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE} & VGA_GREEN_CHAN ; 
            VGA_BLUE <= {VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE} & VGA_BLUE_CHAN ; 
                // VGA_ACTIVE turns off output to screen if scan lines are outside the active screen area
            
            VGA_HS <= VGA_HORZ_SYNC ;
            VGA_VS <= VGA_VERT_SYNC ;
            
    end
endmodule
