`timescale 1ns / 1ps

module block_filler(
    input clk_sample,
    input freeze_sw,
    input [7:0] wave_sample,
    output reg [7:0] Block0,
    output reg [7:0] Block1,
    output reg [7:0] Block2,
    output reg [7:0] Block3,
    output reg [7:0] Block4,
    output reg [7:0] Block5,
    output reg [7:0] Block6,
    output reg [7:0] Block7,
    output reg [7:0] Block8,
    output reg [7:0] Block9
    );
    
    reg [10:0] i = 0;
    reg full_display_cycle = 0;
    
    reg swap_time = 0;
    reg first_run = 0;
    
    always @(posedge clk_sample) begin
        if (first_run == 0)
        begin
            Block0[i]=0;
            Block1[i]=0;
            Block2[i]=0;
            Block3[i]=0;
            Block4[i]=0;
            Block5[i]=0;
            Block6[i]=0;
            Block7[i]=0;
            Block8[i]=0;
            Block9[i]=0;
            first_run = (i==639) ? 1 : 0;
            i = (i==639) ? 0 : i + 1;
        end
        else
        begin
            if (freeze_sw)
            begin
                full_display_cycle = (i==639) ? 1 : ((full_display_cycle==1) ? 1: 0);
                i = (i==639) ? 0 : i + 1;
                Block0[i] = (full_display_cycle==1) ? Block0[i] : wave_sample;
            end
            else
            begin
                full_display_cycle <= 0;
                if (swap_time == 0) begin 
                    Block0[i] =  wave_sample; 
                    i = (i==639) ? 0 : i + 1; 
                    swap_time = (i==639) ? 1 : 0;
                end
                else if (swap_time == 1)
                begin
                    i = (i==639) ? 0 : i + 1;
                    swap_time = 1;
                    Block9[i] = Block8[i];
                    Block8[i] = Block7[i];
                    Block7[i] = Block6[i];
                    Block6[i] = Block5[i];
                    Block5[i] = Block4[i];
                    Block4[i] = Block3[i];
                    Block3[i] = Block2[i];
                    Block2[i] = Block1[i];
                    Block1[i] = Block0[i];
                    Block0[i] = wave_sample;
                    if (i == 639 && swap_time == 1) begin swap_time = 0; end
                end
                else
                begin
                    Block0[i] =  wave_sample;
                    i = (i==639) ? 0 : i + 1;
                end
            end
        end           
    end
endmodule
