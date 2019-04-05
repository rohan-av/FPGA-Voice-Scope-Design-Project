`timescale 1ns / 1ps

module Draw_Joy_Waveform(
    input clk_sample, //20kHz clock
    input freeze_sw,
    input advanced_sw,
    input [7:0] wave_sample, //smaller wave sample
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [1:0] depth_select, // 0: normal, 1: fill in with counter, 2: green depth, 3: full terrain
    input [3:0] fill_counter,
    output reg [3:0] VGA_Red_waveform,
    output reg [3:0] VGA_Green_waveform,
    output reg [3:0] VGA_Blue_waveform
    );
    
    reg [10:0] i = 0;
    reg full_display_cycle = 0;
    
    reg [3:0] R_colour = 4'hf;
    reg [3:0] G_colour = 4'hf;
    reg [3:0] B_colour = 4'hf;

    reg [7:0] Block0[639:0];
    reg [7:0] Block1[639:0];
    reg [7:0] Block2[639:0];
    reg [7:0] Block3[639:0];
    reg [7:0] Block4[639:0];
    reg [7:0] Block5[639:0];
    reg [7:0] Block6[639:0];
    reg [7:0] Block7[639:0];
    reg [7:0] Block8[639:0];
    //reg [7:0] Block9[639:0];
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
            //Block9[i]=0;
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
                //Block9[i] = Block8[i];
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
    
    always@(*) begin
    if ((VGA_HORZ_COORD >= 320) && (VGA_HORZ_COORD < 960))
        begin
        VGA_Red_waveform = 0;
        VGA_Green_waveform = 0;
        VGA_Blue_waveform = 0;
        if ((VGA_VERT_COORD == (362 - Block0[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if ((VGA_VERT_COORD >= 365 - Block0[VGA_HORZ_COORD-320]))
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 0) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 0) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 0) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'h1;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (412 - Block1[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if ((VGA_VERT_COORD >= 415 - Block1[VGA_HORZ_COORD-320]))
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 1) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 1) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 1) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'h2;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (462 - Block2[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if ((VGA_VERT_COORD >= 465 - Block2[VGA_HORZ_COORD-320]))
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 2) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 2) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 2) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'h4;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (512 - Block3[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if (VGA_VERT_COORD >= 515 - Block3[VGA_HORZ_COORD-320])
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 3) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 3) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 3) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'h6;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (562 - Block4[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if (VGA_VERT_COORD >= 565 - Block4[VGA_HORZ_COORD-320])
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 4) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 4) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 4) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'h8;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (612 - Block5[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if (VGA_VERT_COORD >= 615 - Block5[VGA_HORZ_COORD-320])
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 5) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 5) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 5) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'ha;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (662 - Block6[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if (VGA_VERT_COORD >= 665 - Block6[VGA_HORZ_COORD-320])
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 6) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 6) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 6) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'hb;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (712 - Block7[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if (VGA_VERT_COORD >= 715 - Block7[VGA_HORZ_COORD-320])
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 7) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 7) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 7) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'hd;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
        if ((VGA_VERT_COORD == (762 - Block8[VGA_HORZ_COORD-320])))
        begin
            VGA_Red_waveform = R_colour;
            VGA_Green_waveform = G_colour;
            VGA_Blue_waveform = B_colour;
        end 
        if (VGA_VERT_COORD >= 765 - Block8[VGA_HORZ_COORD-320])
        begin
            case (depth_select)
                2'b00:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
                2'b01:
                    begin
                    VGA_Red_waveform = (fill_counter == 8) ? 4'hf : 0;
                    VGA_Green_waveform = (fill_counter == 8) ? 4'hf : 0;
                    VGA_Blue_waveform = (fill_counter == 8) ? 4'hf : 0;
                    end
                2'b10:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 4'hf;
                    VGA_Blue_waveform = 0;
                    end
                default:
                    begin
                    VGA_Red_waveform = 0;
                    VGA_Green_waveform = 0;
                    VGA_Blue_waveform = 0;
                    end
            endcase
        end
//        if ((VGA_HORZ_COORD >= 320) && (VGA_HORZ_COORD < 960) && ((VGA_VERT_COORD - (812 - Block9[VGA_HORZ_COORD-320]))<3))
//        begin
//            VGA_Red_waveform = R_colour;
//            VGA_Green_waveform = G_colour;
//            VGA_Blue_waveform = B_colour;
//        end 
//        if ((VGA_HORZ_COORD >= 320) && (VGA_HORZ_COORD < 960) && (VGA_VERT_COORD >= 815 - Block9[VGA_HORZ_COORD-320]))
//        begin
//            case (depth_select)
//                2'b00:
//                    begin
//                    VGA_Red_waveform = 0;
//                    VGA_Green_waveform = 0;
//                    VGA_Blue_waveform = 0;
//                    end
//                2'b01:
//                    begin
//                    VGA_Red_waveform = (fill_counter == 9) ? 4'hf : 0;
//                    VGA_Green_waveform = (fill_counter == 9) ? 4'hf : 0;
//                    VGA_Blue_waveform = (fill_counter == 9) ? 4'hf : 0;
//                    end
//                default:
//                    begin
//                    VGA_Red_waveform = 0;
//                    VGA_Green_waveform = 0;
//                    VGA_Blue_waveform = 0;
//                    end
//            endcase
//        end
        if (VGA_VERT_COORD >= 780)
        begin
            VGA_Red_waveform = 0;
            VGA_Green_waveform = 0;
            VGA_Blue_waveform = 0;
        end
    end
    else
    begin
        VGA_Red_waveform = 0;
        VGA_Green_waveform = 0;
        VGA_Blue_waveform = 0;
    end    
end
    
endmodule