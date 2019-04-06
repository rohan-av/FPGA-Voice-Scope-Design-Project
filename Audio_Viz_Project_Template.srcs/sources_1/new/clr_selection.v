`timescale 1ns / 1ps

module clr_selection(
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [1:0] horz_counter,
    input [1:0] vert_counter,
    output reg [3:0] VGA_CSTR,
    output reg [3:0] VGA_CSTG,
    output reg [3:0] VGA_CSTB,
    
    output reg [3:0] VGA_SLCTR,
    output reg [3:0] VGA_SLCTG,
    output reg [3:0] VGA_SLCTB
    );
    
    parameter sep = 40;
    parameter x_left = 40; 
    parameter redrow = 410 + sep*6;
    parameter greenrow = 410 + sep*7;
    parameter bluerow = 410 + sep*8;
    
    wire Horz_Condition_0 = (VGA_HORZ_COORD > x_left+10 && VGA_HORZ_COORD < x_left+30);
    wire Horz_Condition_1 = (VGA_HORZ_COORD > x_left+10+sep*1 && VGA_HORZ_COORD < x_left+30+sep*1);
    wire Horz_Condition_2 = (VGA_HORZ_COORD > x_left+10+sep*2 && VGA_HORZ_COORD < x_left+30+sep*2);
    wire Horz_Condition_3 = (VGA_HORZ_COORD > x_left+10+sep*3 && VGA_HORZ_COORD < x_left+30+sep*3);
    
    wire Vert_Condition_0 = (VGA_VERT_COORD > redrow+10 && VGA_VERT_COORD < redrow+30);
    wire Vert_Condition_1 = (VGA_VERT_COORD > greenrow+10 && VGA_VERT_COORD < greenrow+30);
    wire Vert_Condition_2 = (VGA_VERT_COORD > bluerow+10 && VGA_VERT_COORD < bluerow+30);
    
    always@(*) begin
        VGA_SLCTR <= 4'h0;
        VGA_SLCTG <= 4'h0;
        VGA_SLCTB <= 4'h0;
        
        case(vert_counter)
            0:
                begin
                case(horz_counter)
                    0:
                        begin
                            VGA_CSTR <= (Horz_Condition_0 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_0 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_0 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_SLCTR <= 4'h3;
                        end
                    1:
                        begin
                            VGA_CSTR <= (Horz_Condition_1 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_1 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_1 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_SLCTR <= 4'h7;
                        end
                    2:
                        begin
                            VGA_CSTR <= (Horz_Condition_2 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_2 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_2 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_SLCTR <= 4'hB;
                        end
                    3:
                        begin
                            VGA_CSTR <= (Horz_Condition_3 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_3 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_3 && Vert_Condition_0) ? 4'hf : 0;
                            VGA_SLCTR <= 4'hF;
                        end
                    endcase
                end
            1:
                begin
                case(horz_counter)
                    0:
                        begin
                            VGA_CSTR <= (Horz_Condition_0 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_0 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_0 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_SLCTG <= 4'h3;
                        end
                    1:
                        begin
                            VGA_CSTR <= (Horz_Condition_1 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_1 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_1 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_SLCTG <= 4'h7;
                        end
                    2:
                        begin
                            VGA_CSTR <= (Horz_Condition_2 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_2 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_2 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_SLCTG <= 4'hB;
                        end
                    3:
                        begin
                            VGA_CSTR <= (Horz_Condition_3 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_3 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_3 && Vert_Condition_1) ? 4'hf : 0;
                            VGA_SLCTG <= 4'hF;
                        end
                    endcase
                end
            2:
                begin
                case(horz_counter)
                    0:
                        begin
                            VGA_CSTR <= (Horz_Condition_0 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_0 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_0 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_SLCTB <= 4'h3;
                        end
                    1:
                        begin
                            VGA_CSTR <= (Horz_Condition_1 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_1 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_1 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_SLCTB <= 4'h7;
                        end
                    2:
                        begin
                            VGA_CSTR <= (Horz_Condition_2 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_2 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_2 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_SLCTB <= 4'hB;
                        end
                    3:
                        begin
                            VGA_CSTR <= (Horz_Condition_3 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTG <= (Horz_Condition_3 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_CSTB <= (Horz_Condition_3 && Vert_Condition_2) ? 4'hf : 0;
                            VGA_SLCTB <= 4'hF;
                        end
                    endcase
                end
         endcase
    end
    
endmodule
