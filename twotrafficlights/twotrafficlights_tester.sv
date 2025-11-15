module twotrafficlights_tester
  (
   output logic       clk,
   output logic       rst,
   output logic [2:0] lightsA,
   output logic [2:0] lightsB
   );

   logic [2:0]        correctA, correctB;

   initial
     begin
        clk = 1;
        rst = 1;
        #20 rst = 0;
        #165 $finish();
     end

   always #5 clk <= !clk;

   twotrafficlights dut(.clk(clk), .rst(rst), .lightsA(lightsA), .lightsB(lightsB));

  //  twotrafficlights_golden gold(.clk(clk), .rst(rst), .lightsA(correctA), .lightsB(correctB));

   always @(posedge clk)
     if(!rst)
       begin
          $write("%04d: rst=%1b  (lightsA,lightsB) = (%03b, %03b)   correct: (%03b, %03b)",
                 $time, rst, lightsA, lightsB, correctA, correctB);
          if({lightsA,lightsB} == {correctA,correctB})
            $display(" - pass");
          else
            $display(" - FAIL");
       end
endmodule
