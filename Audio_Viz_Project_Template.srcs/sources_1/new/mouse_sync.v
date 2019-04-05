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
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input Mouse_Data, // Mouse PS2 data
    input Mouse_Clk, // Mouse PS2 Clock
    output reg [7:0] x_coord,
    output reg [7:0] y_coord,
    output left_click,
    output right_click
    );
    
    reg [5:0] Mouse_bits; // count number of bits receiving from the PS2 mouse
    assign left_click = (Mouse_bits==1 && Mouse_Data==1);
    assign right_click = (Mouse_bits==2 && Mouse_Data==1);
    
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
            if (Mouse_bits >= 13 && Mouse_bits <= 20) begin
                x_coord[Mouse_bits - 13] <= 1'b1;
            end
            
            else if (Mouse_bits >= 24 && Mouse_bits <= 30) begin
                y_coord[Mouse_bits - 24] <= 1'b1;
            end
    end
     
    
 endmodule
