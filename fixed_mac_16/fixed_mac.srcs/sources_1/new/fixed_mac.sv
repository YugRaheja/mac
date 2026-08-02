`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2026 00:48:24
// Design Name: 
// Module Name: fixed_mac
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


module fixed_mac (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    input  logic signed [15:0] A,
    input  logic signed [15:0] B,
    output logic signed [31:0] Y
);

    logic signed [31:0] product;

    assign product = A * B;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            Y <= 0;
        else if (enable)
            Y <= Y + product;
    end

endmodule
