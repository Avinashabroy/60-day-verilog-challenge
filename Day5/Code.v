//Given several input vectors, concatenate them together then split them up into several output vectors. There are six 5-bit input vectors: a, b, c, d, e, and f, for a total of 30 bits of input. There are four 8-bit output vectors: w, x, y, and z, for 32 bits of output. The output should be a concatenation of the input vectors followed by two 1 bits:
module concat_split(
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z
);

    // Concatenate the input vectors into a 30-bit vector and add two '1' bits
    wire [31:0] concatenated;
    assign concatenated = {a, b, c, d, e, f, 2'b11};

    // Split the 32-bit concatenated vector into four 8-bit output vectors
    assign w = concatenated[31:24];
    assign x = concatenated[23:16];
    assign y = concatenated[15:8];
    assign z = concatenated[7:0];

endmodule

