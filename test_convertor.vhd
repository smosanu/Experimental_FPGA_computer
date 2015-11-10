library ieee;
use ieee.std_logic_1164.all;
use work.switch_functions.all;

entity test_convertor is
end entity test_convertor;

architecture behavioral of test_convertor is
	constant full_period : time := 1 ns;

	signal uls : std_logic := '0';
	signal clk : std_logic := '0';
	signal rst : std_logic := '0';

	signal input16  : std_logic_vector(WIDTH16 - 1 downto 0) := (others => '0');
	signal input19  : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal output16 : std_logic_vector(WIDTH16 - 1 downto 0) := (others => '0');
	signal output19 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');

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
		input16 <= (others => '0');
		input19 <= (others => '0');
		wait for full_period;
		--input16 <= "1000000000000000000";
		input19 <= "1000000000000000000";
		wait for full_period;
		--input16 <= "1000000000000000100";
		input19 <= "1000000000000001000";
		for I in 0 to 0 loop
			wait for full_period;
		end loop;
		wait for full_period;
		--		input16 <= "1000000000000000101";
		input19 <= "1001000000000001001";
		wait for full_period;
		--		input16 <= (others => '0');
		input19 <= (others => '0');
		for I in 0 to 0 loop
			wait for full_period;
		end loop;
		assert 1 = 0 report "1desired_end" severity failure;
	end process;

	-- Design Under Test
	DUT : entity work.wordlength_16_to_18(RTL)
		port map(
			input16  => input16,
			input19  => input19,
			output16 => output16,
			output19 => output19,
			clk      => clk,
			rst      => rst
		);
end architecture behavioral;