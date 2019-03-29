`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// National University of Singapore
// Department of Electrical and Computer Engineering
// EE2026 Digital Design
// AY1819 Semester 1
// Project: Voice Scope
//////////////////////////////////////////////////////////////////////////////////

module Voice_Scope_TOP(
    input CLK,
    input ramp_sw,
    input freeze_sw,
    input colour_button,
    input grid_button,
    input  J_MIC3_Pin3,   // PmodMIC3 audio input data (serial)
    output J_MIC3_Pin1,   // PmodMIC3 chip select, 20kHz sampling clock
    output J_MIC3_Pin4,   // PmodMIC3 serial clock (generated by module VoiceCapturer.v)
   
    output [3:0] VGA_RED,    // RGB outputs to VGA connector (4 bits per channel gives 4096 possible colors)
    output [3:0] VGA_GREEN,
    output [3:0] VGA_BLUE,
    
    output VGA_VS,          // horizontal & vertical sync outputs to VGA connector
    output VGA_HS,
    output [11:0] peakval,
    output [3:0] ss_enable,
    output [7:0] ss_active
    );
       
   
      
       
//-----------------------------------------------------------------------------
//                  STUDENT A - MIC
//-----------------------------------------------------------------------------
   
   wire [2:0] colour_select;
   cycle_colour clr1 (CLK, colour_button, colour_select); 
   
   wire [2:0] grid_select;
   cycle_grid grd1 (CLK, grid_button, grid_select);
       
// Please create a clock divider module to generate a 20kHz clock signal. 
// Instantiate it below
    
    wire [11:0] MIC_in;
    wire new_clock;
    clk_div c0(CLK,new_clock);
   
       
// Please instantiate the voice capturer module below

    Voice_Capturer vc1 ( 
     .CLK(CLK),
     .cs(new_clock),
     .MISO(J_MIC3_Pin3), 
     .clk_samp(J_MIC3_Pin1),
     .sclk(J_MIC3_Pin4), 
     .sample(MIC_in)
     );
    
    volume_indicator vi1 (
        .cs(new_clock),
        .sample(MIC_in),
        .freeze_sw(freeze_sw),
        .ramp_sw(ramp_sw),
        .intensity(peakval),
        .ss_enable(ss_enable),
        .ss_active(ss_active)
        );
//-----------------------------------------------------------------------------
//                  STUDENT B - VGA
//-----------------------------------------------------------------------------

    wire [11:0] VGA_HORZ_COORD;
    wire [11:0] VGA_VERT_COORD; 
    wire [9:0] test_wave;
    
    TestWave_Gen u1 (new_clock, test_wave);
    
// Please instantiate the waveform drawer module below
    
    wire [3:0] VGA_Red_waveform;
    wire [3:0] VGA_Green_waveform;
    wire [3:0] VGA_Blue_waveform;
    wire [9:0] wave_sample; 
    
    assign wave_sample = (ramp_sw == 0)? MIC_in[11:2] : test_wave;
    
    Draw_Waveform d1 (
    .clk_sample(new_clock),
    .freeze_sw(freeze_sw),
    .wave_sample(wave_sample),
    .VGA_HORZ_COORD(VGA_HORZ_COORD),
    .VGA_VERT_COORD(VGA_VERT_COORD),
    .colour_select(colour_select),
    .VGA_Red_waveform(VGA_Red_waveform),
    .VGA_Green_waveform(VGA_Green_waveform),
    .VGA_Blue_waveform(VGA_Blue_waveform)
    );
    
// Please instantiate the background drawing module below   
    wire [3:0] VGA_Red_Grid;
    wire [3:0] VGA_Green_Grid;
    wire [3:0] VGA_Blue_Grid;
    
    Draw_Background d2 (
    .VGA_HORZ_COORD(VGA_HORZ_COORD),
    .VGA_VERT_COORD(VGA_VERT_COORD),
    .colour_select(colour_select),
    .grid_select(grid_select),
    .intensity(peakval),
    .VGA_Red_Grid(VGA_Red_Grid),
    .VGA_Green_Grid(VGA_Green_Grid),
    .VGA_Blue_Grid(VGA_Blue_Grid)
    );
    
// Please instantiate the VGA display module below          
     VGA_DISPLAY d3 (
     .CLK(CLK),
     .VGA_RED_WAVEFORM(VGA_Red_waveform),
     .VGA_GREEN_WAVEFORM(VGA_Green_waveform),
     .VGA_BLUE_WAVEFORM(VGA_Blue_waveform),
     .VGA_RED_GRID(VGA_Red_Grid),
     .VGA_GREEN_GRID(VGA_Green_Grid),
     .VGA_BLUE_GRID(VGA_Blue_Grid),
     .VGA_HORZ_COORD(VGA_HORZ_COORD),
     .VGA_VERT_COORD(VGA_VERT_COORD),
     .VGA_RED(VGA_RED),
     .VGA_GREEN(VGA_GREEN),
     .VGA_BLUE(VGA_BLUE),
     .VGA_VS(VGA_VS),
     .VGA_HS(VGA_HS)
     );
                      
endmodule
