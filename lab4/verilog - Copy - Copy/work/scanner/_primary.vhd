library verilog;
use verilog.vl_types.all;
entity scanner is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        beginScanning   : in     vl_logic;
        beginTransfer   : in     vl_logic;
        status          : out    vl_logic_vector(4 downto 0);
        readyToTransfer : out    vl_logic;
        bufferAmount    : out    integer;
        startScanningOut: out    vl_logic
    );
end scanner;
