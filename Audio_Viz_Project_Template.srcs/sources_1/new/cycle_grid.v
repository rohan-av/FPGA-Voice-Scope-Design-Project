`timescale 1ns / 1ps

module cycle_grid(input CLK, input pushbutton, output reg [2:0] grid = 3'b000);
    wire slow_clock;
    wire pulse;
    
    button_clk slowclk (CLK, slow_clock);
    single_pulse sp1 (slow_clock, pushbutton, pulse);
    
    always@(posedge slow_clock)
        begin
        grid = (pulse == 1)? ((grid == 3'b010)? 3'b000 : grid + 1) : grid;
        end
endmodule
