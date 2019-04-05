`timescale 1ns / 1ps

module rolling_average(
    input cs,
    input [11:0] sample,
    input freeze_sw,
    input ramp_sw,
    output reg [11:0] avg = 0
    );
    
    reg i = 0;
    reg [16:0] sum = 0;
    //reg [11:0] Memory[999:0];
    
    always @ (posedge cs) begin
        //Memory[i] = sample;
        sum = sum + sample;
        avg = (i==1) ? sum/2 : avg;
        sum = (i==1) ? 0: sum;
        i = (i==1) ? 0 : i + 1;
 
    end
    
endmodule
