`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 20:10:33
// Design Name: 
// Module Name: bit_selector
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


module bit_selector(
    input  signed [15:0] in,
    input  [1:0] mode,
    output logic signed [15:0] out
);

always_comb begin
    case (mode)
        2'b00: out = in[3:0];    // INT4
        2'b01: out = in[7:0];    // INT8
        2'b10: out = in[15:0];   // INT16
        default: out = in[15:0];
    endcase
end

endmodule
