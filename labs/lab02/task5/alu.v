module alu (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire op, // 0: add, 1: sub
    output reg [3:0] result
);
    reg [3:0] b_inv;
    reg [3:0] b_twos;

    // Bug 1 Fix: Explicitly list all dependent inputs (a, b, op) in sensitivity list
    always @(a, b, op) begin
        if (op == 1'b0) begin
            result = a + b;
        end else begin
            // Bug 2 Fix: Use blocking assignments (=) for combinational sequence
            b_inv = ~b;
            b_twos = b_inv + 4'b0001;
            result = a + b_twos;
        end
    end
endmodule