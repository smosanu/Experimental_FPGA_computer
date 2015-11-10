library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity PRNG_inc is
	port(
		prn : out std_logic_vector(2 downto 0);
		clk : in  std_logic;
		rst : in  std_logic
	);
end entity PRNG_inc;

architecture RTL of PRNG_inc is
	signal random : unsigned(2 downto 0) := (others => '0');
begin
	prn <= std_logic_vector(random);
	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				random <= (others => '0');
			else
				random <= random + 1;
			end if;
		end if;
	end process;

end architecture RTL;
