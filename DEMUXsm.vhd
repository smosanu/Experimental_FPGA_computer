library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_misc.all;
use work.switch_functions.all;

entity DEMUX is
	port(
		-- one input
		input : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		-- seven outputs to other sub-switches
		ou1   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou2   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou3   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou4   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou5   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou6   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou7   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		ou8   : out std_logic_vector(WIDTH + 1 - 1 downto 0);
		-- clock and reset
		clk   : in  std_logic;
		rst   : in  std_logic
	);
end entity DEMUX;

architecture RTL of DEMUX is
	-- declare the state machine type
	type message_handler_type is (idle, send_message);
	-- state variable
	signal message_handler : message_handler_type;
	--
	signal sending         : std_logic                                := '0';
	signal start           : std_logic                                := '0';
	signal endbit          : std_logic                                := '0';
	--
	constant ground        : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	--
	signal sel             : std_logic_vector(SELCODE - 1 downto 0)   := (others => '0');
	--
	signal tempo           : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal temp            : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
begin
	start  <= input(0);
	endbit <= input(1);
	temp   <= input;

	ou1 <= tempo when (sel = "001" and sending = '1') else ground;
	ou2 <= tempo when (sel = "010" and sending = '1') else ground;
	ou3 <= tempo when (sel = "011" and sending = '1') else ground;
	ou4 <= tempo when (sel = "100" and sending = '1') else ground;
	ou5 <= tempo when (sel = "101" and sending = '1') else ground;
	ou6 <= tempo when (sel = "110" and sending = '1') else ground;
	ou7 <= tempo when (sel = "111" and sending = '1') else ground;
	ou8 <= tempo when (sel = "000" and sending = '1') else ground;

	-- state machine implementation
	message_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				message_handler <= idle;
				sel             <= (others => '0');
				sending         <= '0';
				tempo           <= (others => '0');
			else
				case message_handler is
					when idle =>
						-- change state to send_message when start = 1
						if (start = '1' and endbit = '0') then
							message_handler <= send_message;
							sel             <= temp(WIDTH + 1 - 1 - 1 downto WIDTH + 1 - 1 - 3);
							sending         <= '1';
						else
							message_handler <= idle;
							sel             <= (others => '0');
							sending         <= '0';
						end if;
						-- this is the place to delete the address data
						tempo <= address_management(temp);

					when send_message =>
						-- change back to idle when endbit = 1
						if endbit = '1' then
							message_handler <= idle;
						else
							message_handler <= send_message;
						end if;
						tempo <= temp;
				end case;
			end if;
		end if;
	end process;
end architecture RTL;