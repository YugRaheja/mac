`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 20:28:49
// Design Name: 
// Module Name: accumulator
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


module accumulator(
    input  logic clk,
    input  logic rst,
    input  logic clear,
    input  logic enable,
    input  logic signed [31:0] product,
    output logic signed [31:0] Y
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        Y <= 0;
    else if (clear)
        Y <= 0;
    else if (enable)
        Y <= Y + product;  // wrap-around happens naturally
end

endmodule
