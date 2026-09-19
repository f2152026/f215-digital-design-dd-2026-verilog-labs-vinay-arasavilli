`timescale 1ns/1ps
module and_beh_intra #(parameter DELAY = 1)(
    input wire a,
    input wire b,
    output reg y
);
    always @(*) begin
        y = #DELAY (a & b);
    end
endmodule