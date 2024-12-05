`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2024 12:26:54 AM
// Design Name: 
// Module Name: DigitConv
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


module DigitConv(
    input            clk,
    input            reset,
    input            enable,
    input            clear,
    output reg [3:0] q
);

// YOU NEED TO EDIT THE ALWAYS BLOCK TO IMPLEMENT THE COUNTER

always @(posedge clk, posedge reset) begin
if(reset)
 q <= 0;
 else begin
        if (clear)
            q <= 0;
        else if (enable)
            q <= q + 1;
    end
end

endmodule