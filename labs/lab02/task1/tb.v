`timescale 1ns/1ps

module tb;
    reg t_I0;
    reg t_I1;
    reg t_S;
    wire t_Y;

    dut uut (
        .I0(t_I0),
        .I1(t_I1),
        .S(t_S),
        .Y(t_Y)
    );

    integer i;

    initial begin
        $monitor("Time=%0t | S=%b I1=%b I0=%b => Y=%b", $time, t_S, t_I1, t_I0, t_Y);
        
        for (i = 0; i < 8; i = i + 1) begin
            {t_S, t_I1, t_I0} = i[2:0];
            #5;
        end
        
        $finish;
    end
endmodule