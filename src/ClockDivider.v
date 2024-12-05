module ClockDivider(
    input            clk_in,
    input            reset,
    input      [1:0] turbo,
    input            slow,
    output reg       clk_out
);

reg  [31:0] counter = 32'b0;
reg   [5:0] slowCtr = 6'b0;

wire  [5:0] slowStart;

always @(posedge clk_in, posedge reset) begin
  if(reset == 1'b1) begin
    counter <= 32'd0;
    clk_out <= 1'b0;
    slowCtr <= slowStart;
  end
  // THE LINE BELOW IS THE ONLY ONE YOU SHOULD NEED TO EDIT
  else if(counter >= 32'd25000) begin
  // THE LINE ABOVE IS THE ONLY ONE YOU SHOULD NEED TO EDIT
    counter <= 32'd0;
    clk_out <= ~clk_out;
    slowCtr <= slowStart;
  end
  else begin
    slowCtr = slowCtr + 6'b1;
    if(slowCtr == 6'd50) begin
      counter = counter + (turbo[1] ? (turbo[0] ? 32'd10000 : 32'd100) : (turbo[0] ? 32'd10 : 32'd1));
      slowCtr = slowStart;
    end
  end
end

assign slowStart = (slow ? 6'd0 : 6'd49);


endmodule