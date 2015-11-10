library ieee;
use ieee.std_logic_1164.all;

entity test_PRNG is
end entity test_PRNG;

architecture RTL of test_PRNG is
	component LFSR_PRNG
		port(
			prn : out std_logic_vector(2 downto 0);
			clk : in  std_logic;
			rst : in  std_logic
		);
	end component LFSR_PRNG;

	constant full_period : time := 10 ns;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';
	signal prn : std_logic_vector(2 downto 0);
begin
	-- set reset to 0
	rst <= '1', '0' after full_period;

	-- make the clock
	Clock : process
	begin
		clk <= not clk;
		wait for full_period / 2;
	end process;

	-- test with some inputs
	testing : process
	begin
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		assert 1 = 0 report "1desired_end" severity failure;
	end process;

	-- Design Under Test
	DUT : LFSR_PRNG
		port map(
			clk => clk,
			rst => rst,
			prn => prn
		);

end architecture RTL;
