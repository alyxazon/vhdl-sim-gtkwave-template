library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
  port (
    pulse_o : out std_logic);
end;

architecture rtl of testbench is

  component clock is
    generic (
      g_low_phase : time;
      g_high_phase : time);
    port (
      rst_i : in  std_logic;
      clk_o : out std_logic);
  end component;

  signal   s_pulse      : std_logic                     := '0';
  signal   s_reset      : std_logic                     := '1';
  signal   s_clock      : std_logic                     := '0';
  signal   s_counter    : std_logic_vector (3 downto 0) := (others => '0');
  constant c_reset_time : time                          := 100 ns;
  constant c_low_time   : time                          := 5 ns;
  constant c_high_time  : time                          := 5 ns;

begin

  u_clock : clock
  generic map (
    g_low_phase  => c_low_time,
    g_high_phase => c_high_time)
  port map (
    rst_i => s_reset,
    clk_o => s_clock);

  p_reset : process
  begin
    s_reset <= '1';
    wait for c_reset_time;
    s_reset <= '0';
    wait;
  end process;

  p_cnt : process(s_reset, s_clock) is
  begin
    if s_reset = '1' then
      s_counter <= (others => '0');
    elsif rising_edge(s_clock) then
      s_counter <= std_logic_vector(unsigned(s_counter) + 1);
    end if;
  end process;

  p_pulse : process(s_reset, s_clock) is
  begin
    if s_reset = '1' then
      s_pulse <= '0';
    elsif rising_edge(s_clock) then
      if s_counter = "1111" then
        s_pulse <= '1';
      else
        s_pulse <= '0';
      end if;
    end if;
  end process;

  pulse_o <= s_pulse;

end;
