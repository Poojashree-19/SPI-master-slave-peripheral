module clock_divider (
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] divider,
    output logic       spi_clk
);

    logic [7:0] counter;
    logic [7:0] half_period;

    assign half_period = (divider >> 1) - 1;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 8'd0;
            spi_clk <= 1'b0;
        end
        else begin
            if (divider < 8'd2) begin
                counter <= 8'd0;
                spi_clk <= 1'b0;
            end
            else if (counter == half_period) begin
                counter <= 8'd0;
                spi_clk <= ~spi_clk;
            end
            else begin
                counter <= counter + 1'b1;
            end
        end
    end

endmodule
