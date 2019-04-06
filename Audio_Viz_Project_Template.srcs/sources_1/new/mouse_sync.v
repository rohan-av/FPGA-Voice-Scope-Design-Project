`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 18:04:42
// Design Name: 
// Module Name: mouse_sync
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mouse_sync(
    input advanced_sw,
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input Mouse_Data, // Mouse PS2 data
    input Mouse_Clk, // Mouse PS2 Clock
    input [1:0] vert_select,
    output reg [1:0] counter0 = 0,
    output reg [1:0] counter1 = 0,
    output reg [1:0] counter2 = 0
    );
    
    reg [5:0] Mouse_bits; // count number of bits receiving from the PS2 mouse
    
 // counting the number of bits receiving from the Mouse Data 
 // 33 bits to be received from the Mouse 
    always @(posedge Mouse_Clk)
    begin
        if(Mouse_bits <=31) 
            Mouse_bits <= Mouse_bits + 1;
        else
             Mouse_bits <= 0;
    end
    
    always @(negedge Mouse_Clk)
    begin
            if (Mouse_bits == 1)
            begin
                if (Mouse_Data == 1)
                begin
                    case (vert_select)
                        0: counter0 <= (advanced_sw)? ((counter0 == 3) ? 0 : counter0 + 1) : counter0;
                        1: counter1 <= (advanced_sw)? ((counter1 == 3) ? 0 : counter1 + 1) : counter1;
                        2: counter2 <= (advanced_sw)? ((counter2 == 3) ? 0 : counter2 + 1) : counter2;
                    endcase
                end
            end
            if (Mouse_bits == 2)
                begin
                if (Mouse_Data == 1)
                begin
                    case (vert_select)
                        0: counter0 <= (advanced_sw)? ((counter0 == 0) ? 3 : counter0 - 1) : counter0;
                        1: counter1 <= (advanced_sw)? ((counter1 == 0) ? 3 : counter1 - 1) : counter1;
                        2: counter2 <= (advanced_sw)? ((counter2 == 0) ? 3 : counter2 - 1) : counter2;
                    endcase
                end
            end
    end
     
    
 endmodule
