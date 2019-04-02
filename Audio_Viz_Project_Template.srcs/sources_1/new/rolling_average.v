`timescale 1ns / 1ps

module rolling_average(
    input cs,
    input [11:0] sample,
    input freeze_sw,
    input ramp_sw,
    output reg [11:0] avg = 0,
    output reg slow_clock
    );
    
    reg [10:0] i = 0;
    reg [22:0] sum = 0;
    //reg [11:0] Memory[999:0];
    
    always @ (posedge cs) begin
        //Memory[i] = sample;
        sum = sum + sample;
        avg = (i==1999) ? sum/2000 : avg;
        sum = (i==1999) ? 0: sum;
        slow_clock = (i==1999) ? 1-slow_clock : slow_clock;
        i = (i==1999) ? 0 : i + 1;
 
    end
    
endmodule
