`timescale 1ns/1ps
module and_beh_before #(parameter DELAY = 1)(
    input wire a,
    input wire b,
    output reg y
);
    always @(*) begin
        #DELAY y = a & b;
    end
endmodule