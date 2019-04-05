`timescale 1ns / 1ps

module cycle_fill(input CLK, input pushbutton, output reg [3:0] fill = 3'b000);
    wire slow_clock;
    wire pulse;
    
    button_clk slowclk (CLK, slow_clock);
    single_pulse sp1 (slow_clock, pushbutton, pulse);
    
    always@(posedge slow_clock)
        begin
        fill = (pulse == 1)? ((fill == 4'b1000)? 4'b0000 : fill + 1) : fill;
        end
endmodule
