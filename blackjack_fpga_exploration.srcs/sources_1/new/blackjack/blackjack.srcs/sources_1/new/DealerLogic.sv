`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 11:18:19 AM
// Design Name: 
// Module Name: DealerLogic
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


module DealerLogic (
    input logic [7:0] hand_value,
    input logic bust,
    output logic hit // Signal to draw another card
);

    always_comb begin
        if (bust || hand_value >= 17)
            hit = 0; // Stop drawing cards
        else
            hit = 1; // Continue drawing cards
    end
endmodule
