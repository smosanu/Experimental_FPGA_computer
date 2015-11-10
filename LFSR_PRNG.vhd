library ieee;
use ieee.std_logic_1164.all;

entity LFSR_PRNG is
	port(
		prn : out std_logic_vector(2 downto 0);
		clk : in  std_logic;
		rst : in  std_logic
	);
end entity LFSR_PRNG;

architecture RTL of LFSR_PRNG is
	signal D123456 : std_logic_vector(5 downto 0) := "000001"; --NEVER 000000
begin
	prn(0) <= D123456(5);
	prn(1) <= D123456(3);
	prn(2) <= D123456(1);

	process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				D123456 <= "000001";
			else
				D123456(1) <= D123456(0);
				D123456(2) <= D123456(1);
				D123456(3) <= D123456(2);
				D123456(4) <= D123456(3);
				D123456(5) <= D123456(4);
				D123456(0) <= D123456(5) XOR D123456(4);
			end if;
		end if;
	end process;

end architecture RTL;
