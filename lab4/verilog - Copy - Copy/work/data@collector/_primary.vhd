library verilog;
use verilog.vl_types.all;
entity dataCollector is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        startScanning   : in     vl_logic;
        displayData     : out    vl_logic_vector(7 downto 0)
    );
end dataCollector;
