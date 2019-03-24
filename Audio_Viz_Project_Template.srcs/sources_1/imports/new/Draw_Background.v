`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------  
//                  DRAWING GRID LINES AND TICKS ON SCREEN
// Description:
// Grid lines are drawn at pixel # 320 along the x-axis, and
// pixel #768 along the y-axis

// Note the VGA controller is configured to produce a 1024 x 1280 pixel resolution
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// TOOD:    Draw grid lines at every 80-th pixel along the horizontal axis, and every 64th pixel
//          along the vertical axis. This gives us a 16x16 grid on screen. 
//          
//          Further draw ticks on the central x and y grid lines spaced 16 and 8 pixels apart in the 
//          horizontal and vertical directions respectively. This gives us 5 sub-divisions per division 
//          in the horizontal and 8 sub-divisions per divsion in the vertical direction   
//-------------------------------------------------------------------------  
  
//////////////////////////////////////////////////////////////////////////////////


module Draw_Background(
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [2:0] colour_select,
    output [3:0] VGA_Red_Grid,
    output [3:0] VGA_Green_Grid,
    output [3:0] VGA_Blue_Grid
    );
 
     reg [3:0] R_bgcolour;
     reg [3:0] G_bgcolour;
     reg [3:0] B_bgcolour;
     reg [3:0] R_gridcolour;
     reg [3:0] G_gridcolour;
     reg [3:0] B_gridcolour;
     
     always@(*) begin
        case(colour_select)
        3'b001: //dark blue bg 084 + neon green waveform 9e0 + white grid fff
            begin
            R_bgcolour = 4'h0;
            G_bgcolour = 4'h8;
            B_bgcolour = 4'h4;
            R_gridcolour = 4'hf;
            G_gridcolour = 4'hf;
            B_gridcolour = 4'hf;
            end
        
        3'b010: // white bg fff + dark blue waveform 004 + red grid b01
            begin
            R_bgcolour = 4'hf;
            G_bgcolour = 4'hf;
            B_bgcolour = 4'hf;
            R_gridcolour = 4'hb;
            G_gridcolour = 4'h0;
            B_gridcolour = 4'h1;
            end
        
        3'b011: // dark blue bg 337 + orange waveform fa0
            begin
            R_bgcolour = 4'h3;
            G_bgcolour = 4'h3;
            B_bgcolour = 4'h7;
            R_gridcolour = 4'h3;
            G_gridcolour = 4'h3;
            B_gridcolour = 4'h7;
            end
        
        3'b100: // purple bg c1d + white waveform fff + d6b
            begin
            R_bgcolour = 4'hc;
            G_bgcolour = 4'h1;
            B_bgcolour = 4'hd;
            R_gridcolour = 4'hd;
            G_gridcolour = 4'h6;
            B_gridcolour = 4'hb;
            end
        
        3'b101: // light pink bg e8d + light blue waveform 8de  + apple green de8 grid
            begin
            R_bgcolour = 4'he;
            G_bgcolour = 4'h8;
            B_bgcolour = 4'hd;
            R_gridcolour = 4'hd;
            G_gridcolour = 4'he;
            B_gridcolour = 4'h8;
            end
        
        default: // default waveform
            begin
            R_bgcolour = 4'h0;
            G_bgcolour = 4'h0;
            B_bgcolour = 4'h0;
            R_gridcolour = 4'h0;
            G_gridcolour = 4'hD;
            B_gridcolour = 4'h0;
            end
        endcase
     end
    
// The code below draws two grid lines. Modify the codes to draw more grid lines. 
    wire Condition_For_Grid = (VGA_HORZ_COORD % 80 == 0) ||  (VGA_VERT_COORD % 64 == 0) || (VGA_HORZ_COORD == 1279) || (VGA_VERT_COORD == 1023) ;
    parameter [1:0] tt = 1; // tick thickness

// Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
    wire Condition_For_Ticks = (((VGA_HORZ_COORD % 20 > 20 - tt) || (VGA_HORZ_COORD % 20 < tt)) && (VGA_VERT_COORD > 505 && VGA_VERT_COORD < 519 )) 
                               || (((VGA_VERT_COORD % 16 > 16 - tt) || (VGA_VERT_COORD % 16 < tt)) && (VGA_HORZ_COORD > 633 && VGA_HORZ_COORD < 647)) 
                               || (VGA_VERT_COORD > 510 && VGA_VERT_COORD < 514 ) || (VGA_HORZ_COORD > 638 && VGA_HORZ_COORD < 642);


    
// Please modify below codes to change the background color and to display ticks defined above
    assign VGA_Red_Grid = Condition_For_Ticks ? 4'hF : Condition_For_Grid ? R_gridcolour : R_bgcolour ;
    assign VGA_Green_Grid = Condition_For_Ticks ? 4'hA : Condition_For_Grid ? G_gridcolour : G_bgcolour ;
    assign VGA_Blue_Grid = Condition_For_Ticks ? 4'h0 : Condition_For_Grid ? B_gridcolour : B_bgcolour ;
                            // if true, a red pixel is put at coordinates (VGA_HORZ_COORD, VGA_VERT_COORD), 
     
endmodule
