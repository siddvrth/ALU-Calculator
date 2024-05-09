`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 02:24:13 PM
// Design Name: 
// Module Name: Top_Module
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

module Top_Module(
    input [3:0] A,
    input [3:0] B,
    input [3:0] Opcode,
    input reset,
    input clock, 
    output [6:0] cathode,
    output [7:0] anode
);

    wire [3:0] alu_result;
    wire alu_overflow;
    wire [11:0] bcd_output;
    wire fsm_clock;  


    Clock_divider clk_div(
        .in_clk(clock),
        .out_clk(fsm_clock)  
    );

    ALU alu(
        .A(A),
        .B(B),
        .Opcode(Opcode),
        .reset(reset),
        .Result(alu_result),
        .Overflow(alu_overflow)
    );


    binary_to_BCD_converter converter(
        .bin({4'b0000, alu_result}),
        .bcd(bcd_output)
    );

   
    fsm fsm_instance(
        .clock(fsm_clock),
        .sixteen_bit_number({Opcode, bcd_output}),  
        .cathode(cathode),
        .anode(anode)
    );

endmodule
