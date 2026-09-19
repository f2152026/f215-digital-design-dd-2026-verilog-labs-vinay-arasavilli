`timescale 1ns/1ps

module tb;
    parameter TEST_WIDTH = 8;
    parameter TEST_DEPTH = 8;

    reg [$clog2(TEST_DEPTH)-1:0] t_sel;
    wire [TEST_WIDTH-1:0] t_dout;

    lut #(
        .WIDTH(TEST_WIDTH),
        .DEPTH(TEST_DEPTH)
    ) U1 (
        .sel(t_sel),
        .dout(t_dout)
    );

    integer i;
    integer errors = 0;

    initial begin
        for (i = 0; i < TEST_DEPTH; i = i + 1) begin
            t_sel = i;
            #5;
            if (t_dout !== (i * i)) begin
                $display("FAIL at address %0d: expected %0d, got %0d", i, (i * i), t_dout);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("PASS: All %0d memory locations verified correctly.", TEST_DEPTH);
        else
            $display("FAIL: %0d errors found.", errors);
            
        $finish;
    end
endmodule