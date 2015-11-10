library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.switch_functions.all;

entity testDEMUX is
end entity testDEMUX;

architecture RTL of testDEMUX is
	constant full_period : time := 10 ns;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';

	-- copy of DEMUX output
	signal ou1c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou2c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou3c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou4c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou5c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou6c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou7c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal ou8c  : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal input : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
begin
	-- set reset to 0
	rst <= '1', '0' after full_period;

	-- make the clock
	Clock : process
	begin
		clk <= not clk;
		wait for full_period / 2;
	end process;

	-- test with some MuXins
	testing : process
	begin
		wait for full_period;
		input <= "10110101000000000001";
		wait for full_period;
		input <= "10101010101010101001";
		wait for full_period;
		wait for full_period;
		input <= "00011100011100010011";
		wait for full_period;
		input <= (others => '0');
		for I in 0 to 10 loop
			wait for full_period;
		end loop;
		assert 1 = 0 report "1desired_end" severity failure;
	end process;

	DUT_D : entity work.DEMUX(RTL)
		port map(
			input => input,
			ou1   => ou1c,
			ou2   => ou2c,
			ou3   => ou3c,
			ou4   => ou4c,
			ou5   => ou5c,
			ou6   => ou6c,
			ou7   => ou7c,
			ou8   => ou8c,
			clk   => clk,
			rst   => rst
		);
end architecture RTL;
