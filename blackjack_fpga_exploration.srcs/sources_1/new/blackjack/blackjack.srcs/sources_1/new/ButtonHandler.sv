`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2024 04:58:15 PM
// Design Name: 
// Module Name: ButtonHandler
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


module ButtonHandler(
    input   clk,
    input   reset,
    input   btn,
    output  btn_h
    );
    
typedef enum logic [2:0] {
    START = 3'b001,
    PRESS = 3'b010,
    HOLD  = 3'b100
} state_enum;

state_enum curr_state;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        curr_state <= START;
    end else begin
        if(curr_state == START) begin
            if(btn == 1'b1)
                curr_state <= PRESS;
            else
                curr_state <= START;
        end else if(curr_state == PRESS)
            curr_state <= HOLD;
        else begin 
            if(btn == 1'b1) 
                curr_state <= HOLD;
            else
                curr_state <= START;         
        end
    end
end
endmodule
