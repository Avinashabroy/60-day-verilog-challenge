module universal_register(
  input wire [3:0] data_input,
  input wire [1:0] sel,
  input wire clock,
  input wire left_in,
  input wire right_in,
  output reg [3:0] data_output
);
  reg [3:0] reg_data;

  always @(posedge clock) begin
    case (sel)
      2'b00: reg_data <= reg_data;                   // Retain
      2'b01: reg_data <= {right_in, reg_data[3:1]};  // Shift right with right_in
      2'b10: reg_data <= {reg_data[2:0], left_in};   // Shift left with left_in
      2'b11: reg_data <= data_input;                 // Parallel load
    endcase
  end

  always @(posedge clock) begin
    data_output <= reg_data;
  end
endmodule
