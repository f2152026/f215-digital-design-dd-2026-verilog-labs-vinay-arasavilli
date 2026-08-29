// cla4_dataflow.v
// The same 4-bit CLA as cla4.v, rewritten using dataflow modeling
// (continuous `assign` statements) instead of gate primitives. Compare
// the line count and readability of this file to cla4.v.
//
// TODO: add a delay to every assign statement (e.g. assign #(2) ...) --
// same default-delay expectation as everywhere else from Task 2 onward.
//   assign #(2) p = a ^ b;
//   assign #(2) g = a & b;
//   assign #(2) c1   = g[0] | (p[0] & cin);
//   assign #(2) c2   = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
//   assign #(2) c3   = ... (same pattern, one more term)
//   assign #(2) cout = ... (same pattern, one more term)
//   assign #(2) sum  = p ^ {c3, c2, c1, cin};

module cla4_dataflow(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire [3:0] p, g;
  wire c1, c2, c3;

  // TODO: your dataflow (assign) statements go here.
  assign p0 = a[0] ^ b[0];
  assign p1 = a[1] ^ b[1];
  assign p2 = a[2] ^ b[2];
  assign p3 = a[3] ^ b[3];

  assign g0 = a[0] & b[0];
  assign g1 = a[1] & b[1];
  assign g2 = a[2] & b[2];
  assign g3 = a[3] & b[3];

  assign c1 = g0 | p0 & cin;
  assign c2 = g1 | p1 & g0 | p1 & p0 & cin;
  assign c3 = g2 | p2 & g1 | p2 & p1 & g0 | p2 & p1 & p0 & cin;
  assign cout = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0 | p3 & p2 & p1 & p0 & cin;

  assign sum[0] = p0 ^ cin;
  assign sum[1] = p1 ^ c1;
  assign sum[2] = p2 ^ c2;
  assign sum[3] = p3 ^ c3;

endmodule