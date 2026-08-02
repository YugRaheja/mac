`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 20:29:50
// Design Name: 
// Module Name: top_mac
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


module top_mac(
    input  logic clk,
    input  logic rst,
    input  logic clear,
    input  logic enable,
    input  logic signed [15:0] A,
    input  logic signed [15:0] B,
    input  logic [1:0] mode,
    output logic signed [31:0] Y
);

    logic signed [15:0] A_sel, B_sel;
    logic signed [15:0] A_ext, B_ext;
    logic signed [31:0] product;

    // Bit selection
    bit_selector u1 (.in(A), .mode(mode), .out(A_sel));
    bit_selector u2 (.in(B), .mode(mode), .out(B_sel));

    // Sign extension
    sign_extender u3 (.in(A_sel), .mode(mode), .out(A_ext));
    sign_extender u4 (.in(B_sel), .mode(mode), .out(B_ext));

    // Multiply
    multiplier u5 (.A(A_ext), .B(B_ext), .product(product));

    // Accumulate
    accumulator u6 (
        .clk(clk),
        .rst(rst),
        .clear(clear),
        .enable(enable),
        .product(product),
        .Y(Y)
    );

endmodule
