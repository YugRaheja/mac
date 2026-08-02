`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 20:34:31
// Design Name: 
// Module Name: tb_mac
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_top_mac;

  // ---------------- SIGNALS ----------------
  reg clk;
  reg rst;
  reg enable;
  reg [1:0] mode;
  reg signed [15:0] A, B;

  wire signed [31:0] Y;

  // ---------------- DUT ----------------
  top_mac uut (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .mode(mode),
    .A(A),
    .B(B),
    .Y(Y)
  );

  // ---------------- CLOCK ----------------
  initial clk = 0;
  always #5 clk = ~clk;   // 100 MHz

  // ---------------- RESET ----------------
  initial begin
    rst = 1;
    enable = 0;
    mode = 2'b10;
    A = 0;
    B = 0;
    #20;
    rst = 0;
    enable = 1;
  end

  // ---------------- STIMULUS ----------------
  integer i;

  always @(posedge clk) begin
    if (!rst) begin
      // HIGH ACTIVITY (important for power)
      A <= $random;
      B <= $random;

      // Controlled mode switching
      case (i % 150)
        0: mode <= 2'b00;   // 4-bit
        50: mode <= 2'b01;  // 8-bit
        100: mode <= 2'b10; // 16-bit
      endcase

      i = i + 1;
    end
  end

  // ---------------- VCD ----------------
  initial begin
    $dumpfile("top_mac.vcd");
    $dumpvars(0);   // capture full hierarchy
  end

  // ---------------- MONITOR (optional but useful) ----------------
  initial begin
    $display("Time\tMode\tA\tB\tY");
    $monitor("%0t\t%b\t%d\t%d\t%d", $time, mode, A, B, Y);
  end

  // ---------------- SIM CONTROL ----------------
  initial begin
    i = 0;

    // long run → proper switching
    #5000;

    $finish;
  end

endmodule