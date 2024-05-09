`timescale 1ns / 1ps

module faster_clock_divider(
    input in_clk,
    output reg out_clk
);

reg [32:0] count;
parameter MAX_COUNT = 50000;

initial begin
    count = 0;
    out_clk = 0;
end

always @(negedge in_clk) begin
    count = count + 1;
    if (count == MAX_COUNT) begin
        out_clk = ~out_clk;
        count = 0;
    end
end

endmodule
