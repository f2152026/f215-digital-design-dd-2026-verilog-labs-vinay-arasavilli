module dut (
    input wire I0,
    input wire I1,
    input wire S,
    output wire Y
);
    // Select one implementation at a time by commenting/uncommenting:

    // Dataflow Mux
    // mux_df u_mux (.I0(I0), .I1(I1), .S(S), .Y(Y));

    // Behavioral Mux
    mux_beh u_mux (.I0(I0), .I1(I1), .S(S), .Y(Y));
endmodule