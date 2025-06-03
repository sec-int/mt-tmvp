`timescale 1ns / 1ps

module final__tb();
    reg clk = 0;
    reg reset = 0;


    parameter TILE_SIZE = 16;
    parameter N = 512;
    parameter REAL_N = 509;
    parameter DATA_WIDTH = 8;


    always @(*) begin
        #4
        clk <=  ~clk;
    end
    initial begin
        #50
        reset = 1;
		start = 1;
		#8
		start = 0; 
    end

    //Instance
    reg start;
    wire ready;
    wire done;
    wire [$clog2(N)-1:0] bram_f_address_a, bram_f_address_b;
    wire [$clog2(N)-1:0] bram_g_address_a, bram_g_address_b;
    wire [DATA_WIDTH-1:0] bram_f_data_out_a, bram_f_data_out_b;
    wire [DATA_WIDTH-1:0] bram_g_data_out_a, bram_g_data_out_b;

    wire    [DATA_WIDTH-1:0]  m_axis_tdata;
    wire            m_axis_tvalid;

Top_TMVP #(.N(N), .TILE_SIZE(TILE_SIZE), .DATA_WIDTH(DATA_WIDTH), .REAL_N(REAL_N)) DUT
        (.clk(clk), .reset(reset), 
        .start(start),
        .ready(ready),
        .done(done), 
        .bram_f_address_a(bram_f_address_a), .bram_f_address_b(bram_f_address_b),
        .bram_f_data_out_a(bram_f_data_out_a), .bram_f_data_out_b(bram_f_data_out_b),
        .bram_g_address_a(bram_g_address_a), .bram_g_address_b(bram_g_address_b),
        .bram_g_data_out_a(bram_g_data_out_a), .bram_g_data_out_b(bram_g_data_out_b),
        .m_axis_tdata(m_axis_tdata), .m_axis_tvalid(m_axis_tvalid));


	dual_port_ram_TMVP #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH($clog2(N)), .INITIAL_FILE("f.mem"))	f_ROM	(
    .clk(clk), 
    .data_a(0), .addr_a(bram_f_address_a), .we_a(0), .q_a(bram_f_data_out_a),
    .data_b(0), .addr_b(bram_f_address_b), .we_b(0), .q_b(bram_f_data_out_b)
	);
	dual_port_ram_TMVP #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH($clog2(N)), .INITIAL_FILE("g.mem"))	g_ROM	(
    .clk(clk), 
    .data_a(0), .addr_a(bram_g_address_a), .we_a(0), .q_a(bram_g_data_out_a),
    .data_b(0), .addr_b(bram_g_address_b), .we_b(0), .q_b(bram_g_data_out_b)
	);


    integer out_file;
    initial begin
        out_file = $fopen("C:/Users/neisar01/Desktop/Phase_7/Resources/Verification/Final_Verification/final.dat", "w");
    end
    integer cnt_out;
    // Output
    always @(posedge clk) begin
        if (!reset) begin
            cnt_out <= 0;
        end
        else begin
            if (m_axis_tvalid) begin
                cnt_out <= cnt_out + 1;
                $fdisplay(out_file, m_axis_tdata);
            end
            if (done) begin
                $fclose(out_file);
                $finish();
            end 
        end
    end
endmodule
