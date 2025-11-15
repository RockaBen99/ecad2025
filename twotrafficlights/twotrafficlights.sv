module twotrafficlights(
      input  logic clk,
      input  logic rst,
      output logic [2:0] lightsA, 
      output logic [2:0] lightsB
    );
  logic [2:0] state;
  
  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      state <= 0;
    else
      state <= state + 1;
  end

  always_comb begin
    case (state)
      0      : begin lightsA=3'b100; lightsB=3'b110; end
      1      : begin lightsA=3'b100; lightsB=3'b001; end
      2      : begin lightsA=3'b100; lightsB=3'b010; end
      3      : begin lightsA=3'b100; lightsB=3'b100; end
      4      : begin lightsA=3'b110; lightsB=3'b100; end
      5      : begin lightsA=3'b001; lightsB=3'b100; end
      6      : begin lightsA=3'b010; lightsB=3'b100; end
      7      : begin lightsA=3'b100; lightsB=3'b100; end
      default: begin lightsA=3'b100; lightsB=3'b110; end
    endcase
  end

endmodule
