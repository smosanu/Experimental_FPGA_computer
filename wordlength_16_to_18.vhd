library ieee;
use ieee.std_logic_1164.all;
use work.switch_functions.all;
use ieee.numeric_std.all;

entity wordlength_16_to_18 is
	port(
		input16  : in  std_logic_vector(WIDTH16 - 1 downto 0);
		output19 : out std_logic_vector(WIDTH - 1 downto 0);
		input19  : in  std_logic_vector(WIDTH - 1 downto 0);
		output16 : out std_logic_vector(WIDTH16 - 1 downto 0);
		clk      : in  std_logic;
		rst      : in  std_logic
	);
end entity wordlength_16_to_18;

architecture RTL of wordlength_16_to_18 is
	signal input_buffer  : std_logic_vector(10 * WIDTH16 - 1 downto 0) := (others => '0');
	signal output_buffer : std_logic_vector(10 * WIDTH - 1 downto 0)   := (others => '0');
	signal i_i           : integer range 0 to 255                      := 0;
	signal o_i           : integer range 0 to 255                      := 0;
begin
	process(clk)
	begin
		if rising_edge(clk) then
			output_buffer(o_i + WIDTH - 1 downto o_i) <= input19;
			o_i                                   <= o_i + WIDTH;
		--			if input19(0) = '0' then
		--			else
		--			end if;
		end if;
	end process;
end architecture RTL;
