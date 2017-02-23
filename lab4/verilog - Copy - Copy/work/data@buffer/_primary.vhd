library verilog;
use verilog.vl_types.all;
entity dataBuffer is
    generic(
        DELAY           : integer := 25000000
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        beginScanning   : in     vl_logic;
        bufferCleared   : in     vl_logic;
        level80         : out    vl_logic;
        level90         : out    vl_logic;
        level100        : out    vl_logic;
        bufferAmount    : out    integer
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DELAY : constant is 1;
end dataBuffer;
