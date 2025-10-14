module updowncounter
  (
    input logic        clk,
    input logic        rst,
    input logic        up,
    output logic [3:0] count
  );

  // insert your code here
  // assign count = 0;
  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      count <= 0;
    else
      count <= (up) ? count + 1 : count - 1;
  end
   

endmodule
