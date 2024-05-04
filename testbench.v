module testbench;

    // Parameters
    parameter CLK_PERIOD = 20; // In nanoseconds
    parameter SIM_TIME = 1000; // Simulation time in nanoseconds

    // Signals
    reg clk;
    reg rst_n;
    reg sensor;
    wire [2:0] light_r;
    wire [2:0] light_h;


  top_module #(
    .CLK_FREQ(50000), // Adjust parameters as needed
    .green_timeout(20),
    .yellow_timeout(10)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .sensor(sensor),
    .light_r(light_r),
    .light_h(light_h)
);


    // Clock generation
    always #((CLK_PERIOD / 2)) clk = ~clk;
    
  initial begin
    // $monitor ("sensor=%b,light_h=%b,light_n=%b", sensor, light_h, light_n);
    clk = 0;
    rst_n = 1;
     #5  rst_n = 0;
    #15 rst_n = 1;
    #1500 sensor = 0;
    // after 20 clock cycles, there is cars in country road, country light should be green, highway should be yellow, then red
    #20000 sensor = 1;
    // cars go aways after 5 clock cycles, coutry light should be yellow then red, highway should be green
    // #70 sensor = 0;
    
    // // then after 10 clock cycles, there is cars in country road, country light should be green, highway should be yellow, then red
    // #100 sensor = 1;
    // // cars in country are to many, it goes out only after 20 cycles. 
    // // however, country should be yellow and then red after 10+2 cycles
    // // and highway should goes to green in 10 cycles
    // #200 sensor = 0;
    
  end
  always begin
    #5 clk = !clk;
  end 
  

endmodule

