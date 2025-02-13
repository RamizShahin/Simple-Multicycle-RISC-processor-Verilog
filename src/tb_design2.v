`timescale 1ps / 1ps

module tb_design2;

// Clock signal
reg clk;

// Instantiate the design2 module
design2 uut (
    .clk(clk)
);

// Initialize the clock signal
initial begin
    clk = 0;
end

// Generate the clock signal
always begin
    #5 clk = ~clk; // Toggle clock every 5 ps
end

// Test stimulus
initial begin
    // Initialize inputs and apply test vectors
    // For example, you can initialize your nets and apply test stimuli here

    // Wait for a few clock cycles to observe the behavior
    #10;

    // Apply more test stimuli if needed

    // Finish the simulation
    #2000 $finish;
end

endmodule
