`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// You may study and modify the code inside this module to imporve the display feature or introduce other features
//////////////////////////////////////////////////////////////////////////////////

module Draw_Waveform(
    input clk_sample, //20kHz clock
    input freeze_sw,
    input [9:0] wave_sample,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [2:0] colour_select,
    output reg [3:0] VGA_Red_waveform,
    output reg [3:0] VGA_Green_waveform,
    output reg [3:0] VGA_Blue_waveform
    );
    
/*    //Maximum volume indicator centre - this is for circle to be moved over to draw background
    parameter maxvol_x = 1000;
    parameter maxvol_y = 350;
    parameter radius = 25;*/
    
     //The Sample_Memory represents the memory array used to store the voice samples.
     //There are 1280 points and each point can range from 0 to 1023. 
     reg [9:0] Sample_Memory[1279:0];
     reg [10:0] i = 0;
     reg full_display_cycle = 0;
     reg [3:0] wave_size = 4'h2;
     
     reg [3:0] R_colour;
     reg [3:0] G_colour;
     reg [3:0] B_colour;
     
     always @ (posedge clk_sample) begin
        case(colour_select)
        3'b001: //dark blue bg 084 + neon green waveform 9e0 + white grid fff
            begin
            R_colour = 4'h9;
            G_colour = 4'he;
            B_colour = 4'h0;
            end
        
        3'b010: // white bg fff + brown waveform 642 + red grid b01 CHRISTMAS THEME
            begin
            R_colour = 4'h7;
            G_colour = 4'h5;
            B_colour = 4'h3;
            end
        3'b011: // dark blue bg 228 + orange waveform fa0
            begin
            R_colour = 4'hf;
            G_colour = 4'ha;
            B_colour = 4'h0;
            end
        
        3'b100: // purple bg 614 + white waveform fff + d6b
            begin
            R_colour = 4'hf;
            G_colour = 4'hf;
            B_colour = 4'hf;
            end
        
        3'b101: // light pink bg a49 + deep purple 303  + apple green df8 grid
            begin
            R_colour = 4'h0;
            G_colour = 4'h0;
            B_colour = 4'h0;
            end
        
        default: // default waveform
            begin
            R_colour = 4'hf;
            G_colour = 4'hf;
            B_colour = 4'hf;
            end
        endcase
     
     //Each wave_sample is displayed on the screen from left to right. 
     
         if (freeze_sw)
         begin
             full_display_cycle = (i==1279) ? 1 : ((full_display_cycle==1) ? 1: 0);
             i = (i==1279) ? 0 : i + 1;
             Sample_Memory[i] <= (full_display_cycle==1) ? Sample_Memory[i] : wave_sample;
         end
         else
         begin
             full_display_cycle <= 0;
             i = (i==1279) ? 0 : i + 1;
             Sample_Memory[i] <=  wave_sample;
         end           
     end  

    always@(*) begin
    // this is for circle - to be moved over to draw_backgroun
/*            if ((VGA_HORZ_COORD - maxvol_x)*(VGA_HORZ_COORD - maxvol_x) + (VGA_VERT_COORD - maxvol_y)*(VGA_VERT_COORD - maxvol_y) <= radius*radius) begin
                VGA_Red_waveform = 4'h0;
                VGA_Green_waveform = 4'hF;
                VGA_Blue_waveform = 4'h0;
                end*/  
            if ((VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD - (1024 - Sample_Memory[VGA_HORZ_COORD]) <= wave_size) || ((1024 - Sample_Memory[VGA_HORZ_COORD]) - VGA_VERT_COORD <= wave_size)))
                begin
                    VGA_Red_waveform = R_colour;
                    VGA_Green_waveform = G_colour;
                    VGA_Blue_waveform = B_colour;
                end
            
            else
                begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                end
        end

    
endmodule
