library verilog;
use verilog.vl_types.all;
entity instructionmemory is
    port(
        IMAdd           : in     vl_logic_vector(6 downto 0);
        Ins             : out    vl_logic_vector(31 downto 0)
    );
end instructionmemory;
