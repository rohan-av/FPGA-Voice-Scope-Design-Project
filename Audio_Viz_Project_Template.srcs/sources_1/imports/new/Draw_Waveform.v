`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// You may study and modify the code inside this module to imporve the display feature or introduce other features
//////////////////////////////////////////////////////////////////////////////////

module Draw_Waveform(
    input clk_sample, //20kHz clock
    input freeze_sw,
    input advanced_sw,   
    input [9:0] wave_sample,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [2:0] colour_select,
    output reg [3:0] VGA_Red_waveform,
    output reg [3:0] VGA_Green_waveform,
    output reg [3:0] VGA_Blue_waveform
    );
    
    //scaled wave properties
    parameter scale = 6;
    parameter xadjust = 30;
    parameter yadjust = 750;
    
    //envelope wave properties
    reg [10:0] prev_j = 0;
    reg [10:0] j = 0;
    parameter scale2 = 6;
    parameter xadjust2 = 1280 - 30 - (1280/scale2);
    parameter yadjust2 = 750;
    
    
     //The Sample_Memory represents the memory array used to store the voice samples.
     //There are 1280 points and each point can range from 0 to 1023. 
     // The reduced memory register scales the wave by 1/6
     reg [9:0] Scaled_Memory[(1279/scale):0];
     reg [9:0] Sample_Memory[1279:0];
     reg [9:0] Minscaled_Memory[(1279/scale2):0];
     reg [9:0] Maxscaled_Memory[(1279/scale2):0];
     
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
            R_colour = 4'hf;
            G_colour = 4'hf;
            B_colour = 4'hf;
            end
        
        default: // default waveform
            begin
            R_colour = 4'hf;
            G_colour = 4'hf;
            B_colour = 4'hf;
            end
        endcase
     
     //Each wave_sample is displayed on the screen from left to right. 
        i = (i==1279) ? 0 : i + 1;
        j = (i % 159 == scale2)? ((j == 1279)? 0 : j + 1) : j;
        prev_j <= j;
        Minscaled_Memory[(j/scale2)] = (prev_j < j)? 10'b0 : Minscaled_Memory[(j/scale2)];
        Maxscaled_Memory[(j/scale2)] = (prev_j < j)? 10'b0 : Maxscaled_Memory[(j/scale2)];
        Minscaled_Memory[(j/scale2)] = (Minscaled_Memory[(j/scale2)] == 10'b0)? 10'b11111_11111 : Minscaled_Memory[(j/scale2)];
         if (freeze_sw)
         begin
             full_display_cycle = (i==1279) ? 1 : ((full_display_cycle==1) ? 1: 0);
             Sample_Memory[i] <= (full_display_cycle==1) ? Sample_Memory[i] : wave_sample;
             Scaled_Memory[(i/scale)] <= (full_display_cycle==1) ? Scaled_Memory[(i/scale)] : (wave_sample/scale) + yadjust;
             Maxscaled_Memory[(j/scale2)] <= (full_display_cycle==1) ? Maxscaled_Memory[(j/scale2)] : (((wave_sample/scale2) + yadjust2) > Maxscaled_Memory[(j/scale2)])? ((wave_sample/scale2) + yadjust2) : Maxscaled_Memory[(j/scale2)];
             Minscaled_Memory[(j/scale2)] <= (full_display_cycle==1) ? Minscaled_Memory[(j/scale2)] : (((wave_sample/scale2) + yadjust2) <= Minscaled_Memory[(j/scale2)])? ((wave_sample/scale2) + yadjust2) : Minscaled_Memory[(j/scale2)];
         end
         else
         begin
             full_display_cycle <= 0;         
             Sample_Memory[i] <=  wave_sample;
             Scaled_Memory[(i/scale)] <= (wave_sample/scale) + yadjust;
             Maxscaled_Memory[(j/scale2)] <= (((wave_sample/scale2) + yadjust2) > Maxscaled_Memory[(j/scale2)])? ((wave_sample/scale2) + yadjust2) : Maxscaled_Memory[(j/scale2)];
             Minscaled_Memory[(j/scale2)] <= (((wave_sample/scale2) + yadjust2) <= Minscaled_Memory[(j/scale2)])? ((wave_sample/scale2) + yadjust2) : Minscaled_Memory[(j/scale2)];
         end           
     end  

    always@(*) begin
            VGA_Red_waveform = 0;
            VGA_Green_waveform = 0;
            VGA_Blue_waveform = 0;
        
            if ((advanced_sw == 0) && (VGA_HORZ_COORD < 1280) && ((VGA_VERT_COORD - (1024 - Sample_Memory[VGA_HORZ_COORD]) <= wave_size) || ((1024 - Sample_Memory[VGA_HORZ_COORD]) - VGA_VERT_COORD <= wave_size)))
                begin
                    VGA_Red_waveform = R_colour;
                    VGA_Green_waveform = G_colour;
                    VGA_Blue_waveform = B_colour;
                end
            
            if ((advanced_sw == 1) && (VGA_HORZ_COORD < (1280/scale) + xadjust) && (VGA_HORZ_COORD > xadjust) && (VGA_VERT_COORD == (1024 - Scaled_Memory[VGA_HORZ_COORD - xadjust])))
                begin
                    VGA_Red_waveform = R_colour;
                    VGA_Green_waveform = G_colour;
                    VGA_Blue_waveform = B_colour;
                end
            
            if ((advanced_sw == 1) && (VGA_HORZ_COORD > xadjust2) && (VGA_HORZ_COORD < (j/scale2) + xadjust2)  && (VGA_VERT_COORD >= (1024 - Maxscaled_Memory[VGA_HORZ_COORD - xadjust2])) && (VGA_VERT_COORD <= (1024 - Minscaled_Memory[VGA_HORZ_COORD- xadjust2])))
                begin
                VGA_Red_waveform = R_colour;
                VGA_Green_waveform = G_colour;
                VGA_Blue_waveform = B_colour;
            end
        end   
endmodule
