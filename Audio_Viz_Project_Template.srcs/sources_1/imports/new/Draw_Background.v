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
    input advanced_sw,   
    input [2:0] colour_select,
    input [2:0] grid_select,
    input [11:0] intensity,
    output reg [3:0] VGA_Red_Grid,
    output reg [3:0] VGA_Green_Grid,
    output reg [3:0] VGA_Blue_Grid
    //output reg [71:0] percent
    );
 
     reg [3:0] R_bgcolour;
     reg [3:0] G_bgcolour;
     reg [3:0] B_bgcolour;
     reg [3:0] R_gridcolour;
     reg [3:0] G_gridcolour;
     reg [3:0] B_gridcolour;
     reg [3:0] R_tickcolour;
     reg [3:0] G_tickcolour;
     reg [3:0] B_tickcolour;
     
     //max volume indicator + accompanying text coordinates   
     parameter maxvol_x = 1100;
     parameter maxvol_y = 950;
     
     //scaled wave properties
     parameter scale = 6;
     parameter xadjust = 30;
     parameter yadjust = 750;
     
     //Maximum volume indicator centre - this is for circle to be moved over to draw background
     parameter radius = 40;
     wire [20:0] dist = (VGA_HORZ_COORD - maxvol_x)*(VGA_HORZ_COORD - maxvol_x) + (VGA_VERT_COORD - maxvol_y)*(VGA_VERT_COORD - maxvol_y);
     
     always@(*) begin

     end
    
// The code below draws two grid lines. Modify the codes to draw more grid lines. 
    wire Condition_For_Grid_0 = (advanced_sw == 0) && ((VGA_HORZ_COORD % 80 == 0) ||  (VGA_VERT_COORD % 64 == 0) || (VGA_HORZ_COORD == 1279) || (VGA_VERT_COORD == 1023));
    wire Condition_For_Grid_1 = (advanced_sw == 0) && ((VGA_HORZ_COORD % 20 == 0 && VGA_VERT_COORD % 16 == 0));
    wire Condition_For_Grid_2 = (advanced_sw == 0) && (VGA_HORZ_COORD == 1279) || (VGA_VERT_COORD == 1023) || (VGA_HORZ_COORD == 0) ||  (VGA_VERT_COORD == 0);
    parameter [1:0] tt = 1; // tick thickness

// Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
    wire Condition_For_Ticks = (advanced_sw == 0) && ((((VGA_HORZ_COORD % 20 > 20 - tt) || (VGA_HORZ_COORD % 20 < tt)) && (VGA_VERT_COORD > 505 && VGA_VERT_COORD < 519 )) 
                               || (((VGA_VERT_COORD % 16 > 16 - tt) || (VGA_VERT_COORD % 16 < tt)) && (VGA_HORZ_COORD > 633 && VGA_HORZ_COORD < 647)) 
                               || (VGA_VERT_COORD > 510 && VGA_VERT_COORD < 514 ) || (VGA_HORZ_COORD > 638 && VGA_HORZ_COORD < 642));


    
// Please modify below codes to change the background color and to display ticks defined above
    always @(*) begin
        //percent = " 000 %";
        case(colour_select)
        3'b001: //dark blue bg 137 + neon green waveform 9e0 + white grid fff + darker blue tick 115
            begin
            R_bgcolour = 4'h1;
            G_bgcolour = 4'h3;
            B_bgcolour = 4'h7;
            if (advanced_sw == 0) begin
                R_gridcolour = 4'he;
                G_gridcolour = 4'he;
                B_gridcolour = 4'he;
                R_tickcolour = 4'h1;
                G_tickcolour = 4'h1;
                B_tickcolour = 4'h5;
                end
            end
        
        3'b010: // white bg fff + black waveform 000 + red grid b01 + dark green ticks 181
            begin
            R_bgcolour = 4'h0;
            G_bgcolour = 4'h0;
            B_bgcolour = 4'h0;
            R_gridcolour = 4'hb;
            G_gridcolour = 4'h0;
            B_gridcolour = 4'h1;
            R_tickcolour = 4'h1;
            G_tickcolour = 4'h8;
            B_tickcolour = 4'h1;
            end
        
        3'b011: // dark blue bg 228 + orange waveform fa0 + dark green 181 grid + darker orange ticks e90
            begin
            R_bgcolour = 4'h2;
            G_bgcolour = 4'h2;
            B_bgcolour = 4'h8;
            R_gridcolour = 4'h1;
            G_gridcolour = 4'h8;
            B_gridcolour = 4'h1;
            R_tickcolour = 4'he;
            G_tickcolour = 4'h9;
            B_tickcolour = 4'h0;       
            end
        
        3'b100: // purple bg 614 + white waveform fff + d6b + yellow ff1 ticks
            begin
            R_bgcolour = 4'h6;
            G_bgcolour = 4'h1;
            B_bgcolour = 4'h4;
            R_gridcolour = 4'hd;
            G_gridcolour = 4'h6;
            B_gridcolour = 4'hb;
            R_tickcolour = 4'he;
            G_tickcolour = 4'he;
            B_tickcolour = 4'h0;
            end
        
        3'b101: // light pink bg a49 + deep purple 525  + apple green df8 grid
            begin
            R_bgcolour = 4'ha;
            G_bgcolour = 4'h4;
            B_bgcolour = 4'h9;
            R_gridcolour = 4'hc;
            G_gridcolour = 4'he;
            B_gridcolour = 4'h7;
            R_tickcolour = 4'hb;
            G_tickcolour = 4'h0;
            B_tickcolour = 4'h1;
            end
        
        default: // default waveform
            begin
            R_bgcolour = 4'h0;
            G_bgcolour = 4'h0;
            B_bgcolour = 4'h0;
            R_gridcolour = 4'h0;
            G_gridcolour = 4'hD;
            B_gridcolour = 4'h0;
            R_tickcolour = 4'he;
            G_tickcolour = 4'ha;
            B_tickcolour = 4'h0;
            end
        endcase
    
        case(grid_select)
            3'b000: 
            begin
                VGA_Red_Grid = Condition_For_Ticks ? R_tickcolour : Condition_For_Grid_0 ? R_gridcolour : R_bgcolour;
                VGA_Green_Grid = Condition_For_Ticks ? G_tickcolour : Condition_For_Grid_0 ? G_gridcolour : G_bgcolour;
                VGA_Blue_Grid = Condition_For_Ticks ? B_tickcolour : Condition_For_Grid_0 ? B_gridcolour : B_bgcolour;
            end
            3'b001: 
            begin
                VGA_Red_Grid = Condition_For_Ticks ? R_tickcolour : Condition_For_Grid_1 ? R_gridcolour : R_bgcolour;
                VGA_Green_Grid = Condition_For_Ticks ? G_tickcolour : Condition_For_Grid_1 ? G_gridcolour : G_bgcolour;
                VGA_Blue_Grid = Condition_For_Ticks ? B_tickcolour : Condition_For_Grid_1 ? B_gridcolour : B_bgcolour;
            end
            3'b010:
            begin
                VGA_Red_Grid = Condition_For_Ticks ? R_tickcolour : Condition_For_Grid_2 ? R_gridcolour : R_bgcolour;
                VGA_Green_Grid = Condition_For_Ticks ? G_tickcolour : Condition_For_Grid_2 ? G_gridcolour : G_bgcolour;
                VGA_Blue_Grid = Condition_For_Ticks ? B_tickcolour : Condition_For_Grid_2 ? B_gridcolour : B_bgcolour;
            end
        endcase
        
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
        
        // max volume indicator
        else if (VGA_VERT_COORD <= maxvol_y && advanced_sw == 1) begin
            //level 12, red
            if (intensity >= 12'b1111_1111_1111 && dist <= ((radius + 120)*(radius + 120)) && dist >= ((radius + 112)*(radius + 112))) begin
                        VGA_Red_Grid = 4'hF;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 100 %";
                        end
            
            //level 11, red
            if (intensity >= 12'b0111_1111_1111 && dist <= ((radius + 110)*(radius + 110)) && dist >= ((radius + 102)*(radius + 102))) begin
                        VGA_Red_Grid = 4'hC;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 092 %";
                        end
            
            //level 10, red
            if (intensity >= 12'b0011_1111_1111 && dist <= ((radius + 100)*(radius + 100)) && dist >= ((radius + 92)*(radius + 92))) begin
                        VGA_Red_Grid = 4'h9;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 083 %";
                        end
            
            //level 9, red
            if (intensity >= 12'b0001_1111_1111 && dist <= ((radius + 90)*(radius + 90)) && dist >= ((radius + 82)*(radius + 82))) begin
                        VGA_Red_Grid = 4'h6;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 075 %";
                        end
            
            //level 8, yellow
            if (intensity >= 12'b0000_1111_1111 && dist <= ((radius + 80)*(radius + 80)) && dist >= ((radius + 72)*(radius + 72))) begin
                        VGA_Red_Grid = 4'h6;
                        VGA_Green_Grid = 4'h6;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 067 %";
                        end
            
            //level 7, yellow
            if (intensity >= 12'b0000_0111_1111 && dist <= ((radius + 70)*(radius + 70)) && dist >= ((radius + 62)*(radius + 62))) begin
                        VGA_Red_Grid = 4'h9;
                        VGA_Green_Grid = 4'h9;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 058 %";
                        end
            
            //level 6, yellow
            if (intensity >= 12'b0000_0011_1111 && dist <= ((radius + 60)*(radius + 60)) && dist >= ((radius + 52)*(radius + 52))) begin
                        VGA_Red_Grid = 4'hC;
                        VGA_Green_Grid = 4'hC;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 050 %";
                        end
                           
            //level 5, yellow
            if (intensity >= 12'b0000_0001_1111 && dist <= ((radius + 50)*(radius + 50)) && dist >= ((radius + 42)*(radius + 42))) begin
                        VGA_Red_Grid = 4'hF;
                        VGA_Green_Grid = 4'hF;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 042 %";
                        end   
            
            //level 4, green
            if (intensity >= 12'b0000_0000_1111 && dist <= ((radius + 40)*(radius + 40)) && dist >= ((radius + 32)*(radius + 32))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'h6;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 033 %";
                        end   
            
            //level 3, green
            if (intensity >= 12'b0000_0000_0111 && dist <= ((radius + 30)*(radius + 30)) && dist >= ((radius + 22)*(radius + 22))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'h9;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 025 %";
                        end   
            
            //level 2, green
            if (intensity >= 12'b0000_0000_0011 && dist <= ((radius + 20)*(radius + 20)) && dist >= ((radius + 12)*(radius + 12))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'hC;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 017 %";
                        end   
            
            //level 1, green
            if (intensity >= 12'b0000_0000_0001 && dist <= ((radius + 10)*(radius + 10)) && dist >= ((radius + 2)*(radius + 2))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'hF;
                        VGA_Blue_Grid = 4'h0;
                        //percent = " 008 %";
                        end
            
        end  
    end
    
    
endmodule
