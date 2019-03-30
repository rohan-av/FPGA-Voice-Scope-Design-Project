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

    input [3:0] VGA_RED_WAVEFORM, 
    input [3:0] VGA_GREEN_WAVEFORM, 
    input [3:0] VGA_BLUE_WAVEFORM,
    
    input [3:0] VGA_RED_GRID,
    input [3:0] VGA_GREEN_GRID,
    input [3:0] VGA_BLUE_GRID,
    
    output [11:0] VGA_HORZ_COORD,
    output [11:0] VGA_VERT_COORD, 

    output reg[3:0] VGA_RED,    // RGB outputs to VGA connector (4 bits per channel gives 4096 possible colors)
    output reg[3:0] VGA_GREEN,
    output reg[3:0] VGA_BLUE,
    output reg VGA_VS,          // horizontal & vertical sync outputs to VGA connector
    output reg VGA_HS

    );
    
    wire CLK_VGA;
    
    //max volume indicator + accompanying text coordinates   
    parameter maxvol_x = 1100;
    parameter maxvol_y = 950;
    
    // Text Generation
    wire basic1;
    wire basic2;
    wire advanced1;
    
    Pixel_On_Text2 #(.displayText("EE2026 VOICE SCOPE")) t1(
        CLK_VGA,
        25, // text position.x (top left)
        25, // text position.y (top left)
        VGA_HORZ_COORD, // current position.x
        VGA_VERT_COORD, // current position.y
        basic1  // result, 1 if current pixel is on text, 0 otherwise
     );
     
    Pixel_On_Text2 #(.displayText("Toggle SW0 for advanced features")) t2(
         CLK_VGA,
         25, // text position.x (top left)
         45, // text position.y (top left)
         VGA_HORZ_COORD, // current position.x
         VGA_VERT_COORD, // current position.y
         basic2  // result, 1 if current pixel is on text, 0 otherwise
      );
      
      Pixel_On_Text2 #(.displayText("EE2026 VOICE SCOPE (ADVANCED)")) t3(
          CLK_VGA,
          25, // text position.x (top left)
          25, // text position.y (top left)
          VGA_HORZ_COORD, // current position.x
          VGA_VERT_COORD, // current position.y
          advanced1  // result, 1 if current pixel is on text, 0 otherwise
       );
    
    
    wire res;
    Pixel_On_Text2 #(.displayText("CURRENT VOLUME")) t4(
        CLK_VGA,
        maxvol_x - 55, // text position.x (top left)
        maxvol_y, // text position.y (top left)
        VGA_HORZ_COORD, // current position.x
        VGA_VERT_COORD, // current position.y
        res  // result, 1 if current pixel is on text, 0 otherwise
     );
     
     wire [3:0] TEXT0;
     wire [3:0] TEXT1;
     
     assign TEXT0 = (advanced_sw == 0)? (((basic1 | basic2) == 1)? 4'hF : 4'h0) : (advanced1 == 1)? 4'hF : 4'h0;
     assign TEXT1 = (res == 1 && advanced_sw == 1)? 4'hF : 4'h0;
    
    // COMBINE ALL OUTPUTS ON EACH CHANNEL
    wire[3:0] VGA_RED_CHAN = (VGA_RED_GRID | VGA_RED_WAVEFORM | TEXT0 | TEXT1) ;
    wire[3:0] VGA_GREEN_CHAN = (VGA_GREEN_GRID | VGA_GREEN_WAVEFORM | TEXT0 | TEXT1) ; 
    wire[3:0] VGA_BLUE_CHAN = (VGA_BLUE_GRID | VGA_BLUE_WAVEFORM | TEXT0 | TEXT1); 
    
    
    
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
            // (res)? 4'hF
            VGA_RED <= {VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE} & VGA_RED_CHAN ;  
            VGA_GREEN <= {VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE} & VGA_GREEN_CHAN ; 
            VGA_BLUE <= {VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE, VGA_ACTIVE} & VGA_BLUE_CHAN ; 
                // VGA_ACTIVE turns off output to screen if scan lines are outside the active screen area
            
            VGA_HS <= VGA_HORZ_SYNC ;
            VGA_VS <= VGA_VERT_SYNC ;
            
    end
    

endmodule
