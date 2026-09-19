`timescale 1ns/1ps

module tb;
    reg [1:0] t_a, t_b;
    wire t_gt, t_lt, t_eq;

    reg exp_gt, exp_lt, exp_eq;
    integer errors = 0;
    integer total_tests = 0;
    integer i, j;

    comp2 uut (
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
    );

    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                t_a = i[1:0];
                t_b = j[1:0];
                #5;

                exp_gt = (i > j);
                exp_lt = (i < j);
                exp_eq = (i == j);

                total_tests = total_tests + 1;

                if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
                    $display("FAIL at time %0t: A=%b B=%b got GT=%b LT=%b EQ=%b expected GT=%b LT=%b EQ=%b",
                             $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
                    errors = errors + 1;
                end
            end
        end

        $write("Test Summary: %0d / %0d tests passed.", (total_tests - errors), total_tests);
        if (errors == 0)
            $display(" ALL TESTS PASSED!");
        else
            $display(" TOTAL FAILURES: %0d", errors);

        $finish;
    end
endmodule