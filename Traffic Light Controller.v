// Code your testbench here
// or browse Examples
module tlc(
  input clk, rst, X,
  output reg [1:0] hwy, // Highway signal: 2'b00=Red, 2'b01=Yellow, 2'b10=Green
  output reg [1:0] cty  // Country road signal: 2'b00=Red, 2'b01=Yellow, 2'b10=Green
);
  typedef enum reg [2:0] {
    S0 = 3'b000,  // Highway Green, Country Red
    S1 = 3'b001,  // Highway Yellow, Country Red
    S2 = 3'b010,  // Highway Red, Country Red (Intermediate)
    S3 = 3'b011,  // Highway Red, Country Green
    S4 = 3'b100   // Highway Red, Country Yellow
} state_t;

  state state_t;
  reg [2:0] delay_counter; // Counter for delay

  always @(posedge clk) begin
    if (!rst) begin
      state_t <= s0;
      delay_counter <= 3'b000;
    end 
    else begin
      case(state_t)
        s0: begin
          hwy <= 2'b10; // Green
          cty <= 2'b00; // Red
          if (X) 
            state_t <= s1; // Move to yellow if car detected
        end
        
        s1: begin
          hwy <= 2'b01; // Yellow
          cty <= 2'b00; // Red
          if (delay_counter == 3'd5) begin // 5 clock cycle delay
            state_t <= s2;
            delay_counter <= 0;
          end 
          else 
            delay_counter <= delay_counter + 1;
        end
        
        s2: begin
          hwy <= 2'b00; // Red
          cty <= 2'b00; // Red
          if (delay_counter == 3'd4) begin // 4 clock cycle delay
            state_t <= s3;
            delay_counter <= 0;
          end 
          else 
            delay_counter <= delay_counter + 1;
        end
        
        s3: begin
          hwy <= 2'b00; // Red
          cty <= 2'b10; // Green
          if (!X) 
            state_t <= s4; // Move to yellow when no car
        end
        
        s4: begin
          hwy <= 2'b00; // Red
          cty <= 2'b01; // Yellow
          if (delay_counter == 3'd5) begin // 5 clock cycle delay
            state_t <= s0;
            delay_counter <= 0;
          end 
          else 
            delay_counter <= delay_counter + 1;
        end
        
        default: begin
          hwy <= 2'b10;
          cty <= 2'b00;
          state_t <= s0;
        end
      endcase
    end
  end
endmodule
