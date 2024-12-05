module Counter(
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