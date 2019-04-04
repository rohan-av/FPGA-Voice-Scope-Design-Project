`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 18:35:22
// Design Name: 
// Module Name: volume_visual
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


module volume_visual(
    input [11:0] VGA_VERT_COORD,
    input [11:0] VGA_HORZ_COORD,
    input advanced_sw,
    input [11:0] intensity,
    output reg [3:0] VGA_Red_Grid,
    output reg [3:0] VGA_Green_Grid,
    output reg [3:0] VGA_Blue_Grid,
    output reg [3:0] level
    );
    
    //max volume indicator + accompanying text coordinates   
    parameter maxvol_x = 1100;
    parameter maxvol_y = 950;
     
    //Maximum volume indicator centre - this is for circle to be moved over to draw background
    parameter radius = 40;
    reg [20:0] dist;
    
    always@(*) begin
        dist = (VGA_HORZ_COORD - maxvol_x)*(VGA_HORZ_COORD - maxvol_x) + (VGA_VERT_COORD - maxvol_y)*(VGA_VERT_COORD - maxvol_y);
        VGA_Red_Grid = 4'h0;
        VGA_Green_Grid = 4'h0;
        VGA_Blue_Grid = 4'h0;
        level = 4'h0;
        
        if (VGA_VERT_COORD <= maxvol_y && advanced_sw == 1) begin
            //lvl 12, red
            if (intensity >= 12'b1111_1111_1111 && dist <= ((radius + 120)*(radius + 120)) && dist >= ((radius + 112)*(radius + 112))) begin
                        VGA_Red_Grid = 4'hF;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'hC)? 4'hC : level; //percent = " 100 %";
                        end
            
            //lvl 11, red
            if (intensity >= 12'b0111_1111_1111 && dist <= ((radius + 110)*(radius + 110)) && dist >= ((radius + 102)*(radius + 102))) begin
                        VGA_Red_Grid = 4'hC;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'hB)? 4'hB : level; //percent = " 092 %";
                        end
            
            //lvl 10, red
            if (intensity >= 12'b0011_1111_1111 && dist <= ((radius + 100)*(radius + 100)) && dist >= ((radius + 92)*(radius + 92))) begin
                        VGA_Red_Grid = 4'h9;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'hA)? 4'hA : level; //percent = " 083 %";
                        end
            
            //lvl 9, red
            if (intensity >= 12'b0001_1111_1111 && dist <= ((radius + 90)*(radius + 90)) && dist >= ((radius + 82)*(radius + 82))) begin
                        VGA_Red_Grid = 4'h6;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h9)? 4'h9 : level; //percent = " 075 %";
                        end
            
            //lvl 8, yellow
            if (intensity >= 12'b0000_1111_1111 && dist <= ((radius + 80)*(radius + 80)) && dist >= ((radius + 72)*(radius + 72))) begin
                        VGA_Red_Grid = 4'h6;
                        VGA_Green_Grid = 4'h6;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h8)? 4'h8 : level; //percent = " 067 %";
                        end
            
            //lvl 7, yellow
            if (intensity >= 12'b0000_0111_1111 && dist <= ((radius + 70)*(radius + 70)) && dist >= ((radius + 62)*(radius + 62))) begin
                        VGA_Red_Grid = 4'h9;
                        VGA_Green_Grid = 4'h9;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h7)? 4'h7 : level; //percent = " 058 %";
                        end
            
            //lvl 6, yellow
            if (intensity >= 12'b0000_0011_1111 && dist <= ((radius + 60)*(radius + 60)) && dist >= ((radius + 52)*(radius + 52))) begin
                        VGA_Red_Grid = 4'hC;
                        VGA_Green_Grid = 4'hC;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h6)? 4'h6 : level; //percent = " 050 %";
                        end
                           
            //lvl 5, yellow
            if (intensity >= 12'b0000_0001_1111 && dist <= ((radius + 50)*(radius + 50)) && dist >= ((radius + 42)*(radius + 42))) begin
                        VGA_Red_Grid = 4'hF;
                        VGA_Green_Grid = 4'hF;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h5)? 4'h5 : level; //percent = " 042 %";
                        end   
            
            //lvl 4, green
            if (intensity >= 12'b0000_0000_1111 && dist <= ((radius + 40)*(radius + 40)) && dist >= ((radius + 32)*(radius + 32))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'h6;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h4)? 4'h4 : level; //percent = " 033 %";
                        end   
            
            //lvl 3, green
            if (intensity >= 12'b0000_0000_0111 && dist <= ((radius + 30)*(radius + 30)) && dist >= ((radius + 22)*(radius + 22))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'h9;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h3)? 4'h3 : level; //percent = " 025 %";
                        end   
            
            //lvl 2, green
            if (intensity >= 12'b0000_0000_0011 && dist <= ((radius + 20)*(radius + 20)) && dist >= ((radius + 12)*(radius + 12))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'hC;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h2)? 4'h2 : level; //percent = " 017 %";
                        end   
            
            //lvl 1, green
            if (intensity >= 12'b0000_0000_0001 && dist <= ((radius + 10)*(radius + 10)) && dist >= ((radius + 2)*(radius + 2))) begin
                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'hF;
                        VGA_Blue_Grid = 4'h0;
                        level = (level < 4'h1)? 4'h1 : level; //percent = " 008 %";
                        end
        end
    end
      
endmodule
