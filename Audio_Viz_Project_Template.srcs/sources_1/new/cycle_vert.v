`timescale 1ns / 1ps

module cycle_vert(input CLK, input pushbutton, output reg [1:0] vert = 2'b00);
    wire slow_clock;
    wire pulse;
    
    button_clk slowclk (CLK, slow_clock);
    single_pulse sp1 (slow_clock, pushbutton, pulse);
    
    always@(posedge slow_clock)
        begin
        vert = (pulse == 1)? ((vert == 2'b10)? 2'b00 : vert + 1) : vert;
        end
endmodule
