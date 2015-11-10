library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.switch_functions.all;

entity testMUX is
end entity testMUX;

architecture RTL of testMUX is
	constant full_period : time := 1 ns;

	signal clk : std_logic := '0';
	signal rst : std_logic := '1';

	signal MuXin1 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin2 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin3 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin4 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin5 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin6 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin7 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuXin8 : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal ouput  : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal MuX_ON : std_logic_vector(INSOUTS - 1 downto 0) := ('1', others => '0');
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
		MuXin1 <= (others => '0');
		MuXin2 <= (others => '0');
		MuXin3 <= (others => '0');
		MuXin4 <= (others => '0');
		MuXin5 <= (others => '0');
		MuXin6 <= (others => '0');
		MuXin7 <= (others => '0');
		MuXin8 <= (others => '0');
		wait for full_period;
		MuXin1 <= "1011000000000000000";
		wait for full_period;
		MuXin1 <= "1010101010101010100";
		for I in 0 to 3 loop
			wait for full_period;
		end loop;
		wait for full_period;
		MuXin1 <= "0001110001110001001";
		wait for full_period;
		MuXin1 <= (others => '0');
		for I in 0 to 10 loop
			wait for full_period;
		end loop;
		assert 1 = 0 report "1desired_end" severity failure;
	end process;

	DUT_M : entity work.MUX(RTL)
		port map(
			in1         => MuXin1,
			in2         => MuXin2,
			in3         => MuXin3,
			in4         => MuXin4,
			in5         => MuXin5,
			in6         => MuXin6,
			in7         => MuXin7,
			in8         => MuXin8,
			ouput       => ouput,
			fifo_en_vtr => MuX_ON,
			clk         => clk,
			rst         => rst
		);
end architecture RTL;
