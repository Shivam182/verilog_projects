`timescale 1ns/1ps

module tb_baugh_wooley_multiplier;

// Declare 4-bit inputs and 8-bit output
reg [3:0] A, B;
wire [7:0] P;

// Instantiate the DUT (Update module name if needed)
signed_multiplier BWSM (
    .A(A),
    .B(B),
    .P(P)
);

// Provide stimulus using an initial block
initial begin 
    A = 4'b0001; B = 4'b0011; #10;  //  1 *  3  = 3
    A = 4'b1101; B = 4'b0010; #10;  // -3 *  2  = -6
    A = 4'b1010; B = 4'b1010; #10;  // -6 * -6  = 36
    A = 4'b0111; B = 4'b0110; #10;  //  7 *  6  = 42
    A = 4'b1111; B = 4'b1111; #10;  // -1 * -1  = 1

    $finish; // End simulation
end

// Monitor the changes
initial begin 
    $monitor("Time=%0t | A=%b B=%b | P=%b", $time, A, B, P);
end

endmodule

