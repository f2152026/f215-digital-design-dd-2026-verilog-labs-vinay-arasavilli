`timescale 1ns/1ps

module tb;
    reg [3:0] t_a, t_b;
    reg t_op;
    wire [3:0] t_result;

    reg [3:0] exp_result;
    integer errors = 0;
    integer i, j, k;

    alu uut (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );

    initial begin
        // Test 1: Verify sensitivity list response when switching op on fixed inputs
        t_a = 4'd7;
        t_b = 4'd3;
        t_op = 1'b0;
        #5;
        if (t_result !== 4'd10) begin
            $display("FAIL Addition: expected 10, got %0d", t_result);
            errors = errors + 1;
        end

        t_op = 1'b1; // Switch op with fixed a and b
        #5;
        if (t_result !== 4'd4) begin
            $display("FAIL Op Sensitivity Bug: expected 4, got %0d", t_result);
            errors = errors + 1;
        end

        // Test 2: Full exhaustive evaluation of all addition and subtraction pairs
        for (k = 0; k < 2; k = k + 1) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    t_op = k[0];
                    t_a = i[3:0];
                    t_b = j[3:0];
                    #5;

                    exp_result = (t_op == 1'b0) ? (t_a + t_b) : (t_a - t_b);

                    if (t_result !== exp_result) begin
                        $display("FAIL at time %0t: op=%b a=%d b=%d got=%d expected=%d",
                                 $time, t_op, t_a, t_b, t_result, exp_result);
                        errors = errors + 1;
                    end
                end
            end
        end

        if (errors == 0)
            $display("PASS: All ALU operations and sensitivity checks passed!");
        else
            $display("FAIL: Found %0d errors during ALU testing.", errors);

        $finish;
    end
endmodule