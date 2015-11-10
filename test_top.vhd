library ieee;
use ieee.std_logic_1164.all;
use work.switch_functions.all;

entity test_top is
end entity test_top;

architecture behavioral of test_top is
	constant full_period : time := 10 ns;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';

	signal input1  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input2  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input3  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input4  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input5  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input6  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input7  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input8  : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output1 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output2 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output3 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output4 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output5 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output6 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output7 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal output8 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');

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
		input1 <= (others => '0');
		input2 <= (others => '0');
		input3 <= (others => '0');
		input4 <= (others => '0');
		input5 <= (others => '0');
		input6 <= (others => '0');
		input7 <= (others => '0');
		input8 <= (others => '0');
		wait for full_period;
		input1 <= "1000000000000000000";
		input2 <= "1001000100000000000";
		input3 <= "1010001000000000000";
		input4 <= "1011001100000000000";
		input5 <= "1100010000000000000";
		input6 <= "1101010100000000000";
		input7 <= "1110011000000000000";
		input8 <= "1111011100000000000";
		wait for full_period;
		input1 <= "1000000000000000100";
		input2 <= "1001000100000001000";
		input3 <= "1010001000000001100";
		input4 <= "1011001100000010000";
		input5 <= "1100010000000010100";
		input6 <= "1101010100000011000";
		input7 <= "1110011000000011100";
		input8 <= "1111011100000000000";
		wait for full_period;
		input1 <= "1000000000000000101";
		input2 <= "1001000100000001001";
		input3 <= "1010001000000001101";
		input4 <= "1011001100000010001";
		input5 <= "1100010000000010101";
		input6 <= "1101010100000011001";
		input7 <= "1110011000000011101";
		input8 <= "1111011100000000001";
		wait for full_period;
		input1 <= (others => '0');
		input2 <= (others => '0');
		input3 <= (others => '0');
		input4 <= (others => '0');
		input5 <= (others => '0');
		input6 <= (others => '0');
		input7 <= (others => '0');
		input8 <= (others => '0');
		for I in 0 to 40 loop
			wait for full_period;
		end loop;
		assert 1 = 0 report "1desired_end" severity failure;
	end process;

	-- Design Under Test
	DUT : entity work.switch_periphery(RTL)
		port map(
			input1  => input1,
			input2  => input2,
			input3  => input3,
			input4  => input4,
			input5  => input5,
			input6  => input6,
			input7  => input7,
			input8  => input8,
			output1 => output1,
			output2 => output2,
			output3 => output3,
			output4 => output4,
			output5 => output5,
			output6 => output6,
			output7 => output7,
			output8 => output8,
			clk     => clk,
			rst     => rst
		);
end architecture behavioral;