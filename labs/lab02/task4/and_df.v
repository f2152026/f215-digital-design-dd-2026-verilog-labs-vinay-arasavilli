`timescale 1ns/1ps
module and_df #(parameter DELAY = 1)(
    input wire a,
    input wire b,
    output wire y
);
    assign #DELAY y = a & b;
endmodule