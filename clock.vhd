library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock is
  generic (
    g_low_phase  : time := 5 ns;
    g_high_phase : time := 5 ns);
  port (
    rst_i : in  std_logic := '0';
    clk_o : out std_logic);
end;

architecture rtl of clock is

  signal s_clk : std_logic := '0';

begin

  p_clock : process
  begin
    s_clk <= '0';
    wait for g_low_phase;
    s_clk <= '1' and not(rst_i);
    wait for g_high_phase;
  end process;

  clk_o <= s_clk;

end;
