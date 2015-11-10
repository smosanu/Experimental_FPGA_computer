library ieee;
use ieee.std_logic_1164.all;

package switch_functions is
	constant WIDTH   : integer := 19;   -- expected width of the input signals & of targeted processor
	constant WIDTH16 : integer := 16;   -- expected width of the input signals & of targeted processor
	constant WIDTH32 : integer := 32;   -- expected width of the input signals & of targeted processor

	constant SELCODE         : integer := 3; -- encode addresses
	constant INSOUTS         : integer := 8; -- number of inputs and outputs
	constant ENC_OCC         : integer := 6; -- bits needed to encode the occupancy of the FIFO (0 to 63 needs 6 bits)
	constant USE_SCH_SQF_LQF : boolean := TRUE; -- TRUE -> uses SQF_LQF, else -> uses PRNG

	function address_management(temp : std_logic_vector(WIDTH + 1 - 1 downto 0)) return std_logic_vector;
end package switch_functions;

package body switch_functions is
	function address_management(temp : std_logic_vector(WIDTH + 1 - 1 downto 0)) return std_logic_vector is
		variable tempo : std_logic_vector(WIDTH + 1 - 1 downto 0);
	begin
		-- FUNCTION CONCEPT: a message can either be sent over 1 hop or 2 hops,
		-- therefore it contains either 1 address or 2 addresses
		-- if the address is 000, a sel=000 results in the message not being sent further
		-- the function is executed after sel is assigned the first address
		-- address 1 is assigned address 2
		-- address 2 is assigned 000

		-- copy the bits that don't change anyway
		tempo(WIDTH + 1 - 1)                              := temp(WIDTH + 1 - 1);
		tempo(WIDTH + 1 - 1 - 4)                          := temp(WIDTH + 1 - 1 - 4);
		tempo(WIDTH + 1 - 1 - 8 downto 0)                 := temp(WIDTH + 1 - 1 - 8 downto 0);
		-- hop 1 address is already used, since sel reads it from temp
		-- copy hop 2 address over hop 1 address and set hop 2 address to zero
		tempo(WIDTH + 1 - 1 - 1 downto WIDTH + 1 - 1 - 3) := temp(WIDTH + 1 - 1 - 5 downto WIDTH + 1 - 1 - 7);
		tempo(WIDTH + 1 - 1 - 5 downto WIDTH + 1 - 1 - 7) := (others => '0');
		return tempo;
	end function address_management;
end package body switch_functions;
