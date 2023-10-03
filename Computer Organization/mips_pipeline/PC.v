module PC( clk, rst, en_reg, d_in, d_out );
    input clk, rst, en_reg;
    input[31:0]	d_in;
    output[31:0] d_out;
    reg [31:0] d_out;
   
    always @( posedge clk ) begin
        if ( rst )
			d_out <= 32'b0;
        else if ( en_reg )
			d_out <= d_in;
    end
endmodule