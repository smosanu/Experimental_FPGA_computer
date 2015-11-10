library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.switch_functions.all;

entity MUX is
	port(
		-- seven inputs from other sub-switches
		in1         : in  std_logic_vector(WIDTH - 1 downto 0);
		in2         : in  std_logic_vector(WIDTH - 1 downto 0);
		in3         : in  std_logic_vector(WIDTH - 1 downto 0);
		in4         : in  std_logic_vector(WIDTH - 1 downto 0);
		in5         : in  std_logic_vector(WIDTH - 1 downto 0);
		in6         : in  std_logic_vector(WIDTH - 1 downto 0);
		in7         : in  std_logic_vector(WIDTH - 1 downto 0);
		in8         : in  std_logic_vector(WIDTH - 1 downto 0);
		-- start flag
		fifo_en_vtr : std_logic_vector(INSOUTS - 1 downto 0);
		-- one output
		ouput       : out std_logic_vector(WIDTH - 1 downto 0);
		-- clock and reset
		clk         : in  std_logic;
		rst         : in  std_logic
	);
end entity MUX;

architecture RTL of MUX is
	-- declare the state machine type
	type message_handler_type is (idle, send_message);
	-- state variable
	signal message_handler : message_handler_type;
	--
	-- multiplexer selector
	signal sel             : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	-- will be linked with the end bit of the relevant signal
	signal endbit          : std_logic                              := '0';
	-- will be linked with the sum of end bits of all inputs
	--signal endbits_sum     : std_logic                              := '0';
	-- big OR which sums all the inputs
	signal start           : std_logic                              := '0';
	--
	-- will be assigned to the sum over input 1
	signal sum1            : std_logic                              := '0';
	-- will buffer input 1 with 1 delay
	signal temp1           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp1c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum2            : std_logic                              := '0';
	signal temp2           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp2c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum3            : std_logic                              := '0';
	signal temp3           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp3c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum4            : std_logic                              := '0';
	signal temp4           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp4c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum5            : std_logic                              := '0';
	signal temp5           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp5c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum6            : std_logic                              := '0';
	signal temp6           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp6c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum7            : std_logic                              := '0';
	signal temp7           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp7c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	--
	signal sum8            : std_logic                              := '0';
	signal temp8           : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	signal temp8c          : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	-- always full zero signal
	constant ground        : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
begin
	-- OR each input
	sum1   <= fifo_en_vtr(0);           --or_reduce(in1);
	sum2   <= fifo_en_vtr(1);           --or_reduce(in2);
	sum3   <= fifo_en_vtr(2);           --or_reduce(in3);
	sum4   <= fifo_en_vtr(3);           --or_reduce(in4);
	sum5   <= fifo_en_vtr(4);           --or_reduce(in5);
	sum6   <= fifo_en_vtr(5);           --or_reduce(in6);
	sum7   <= fifo_en_vtr(6);           --or_reduce(in7);
	sum8   <= fifo_en_vtr(7);           --or_reduce(in8);
	-- OR each sum_x
	start  <= sum1 OR sum2 OR sum3 OR sum4 OR sum5 OR sum6 OR sum7 OR sum8;
	-- OR all end bits
	--endbits_sum <= in1(0) OR in2(0) OR in3(0) OR in4(0) OR in5(0) OR in6(0) OR in7(0) OR in8(0);
	-- endbit logic: end bit from the right input
	endbit <= (sum1 and in1(0)) or (sum2 and in2(0)) or (sum3 and in3(0)) or (sum4 and in4(0)) or (sum5 and in5(0)) or (sum6 and in6(0)) or (sum7 and in7(0)) or (sum8 and in8(0));
	-- define the output
	ouput  <= temp1 when sel = "001" else temp2 when sel = "010" else temp3 when sel = "011" else temp4 when sel = "100" else temp5 when sel = "101" else temp6 when sel = "110" else temp7 when sel = "111" else temp8 when sel = "000" else ground;

	-- state machine implementation
	message_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset signals
				message_handler <= idle;
				sel             <= "000";
				temp1           <= (others => '0');
				temp2           <= (others => '0');
				temp3           <= (others => '0');
				temp4           <= (others => '0');
				temp5           <= (others => '0');
				temp6           <= (others => '0');
				temp7           <= (others => '0');
				temp8           <= (others => '0');
				temp1c          <= (others => '0');
				temp2c          <= (others => '0');
				temp3c          <= (others => '0');
				temp4c          <= (others => '0');
				temp5c          <= (others => '0');
				temp6c          <= (others => '0');
				temp7c          <= (others => '0');
				temp8c          <= (others => '0');
			else
				case message_handler is
					when idle =>
						-- state must switch to send_message when start = 1
						-- state is allowed to switch to send_message only when endbits_sum = 0 
						-- a first message with end bit 1 only has addresses and doesn't make sense
						if (start = '1') then -- and endbits_sum = '0') then
							message_handler <= send_message;
							-- which input should be send depends on sum_x and is encoded in sel
							if (sum1 = '1' and in1(0) = '0') then
								sel <= "001";
							elsif (sum2 = '1' and in2(0) = '0') then
								sel <= "010";
							elsif (sum3 = '1' and in3(0) = '0') then
								sel <= "011";
							elsif (sum4 = '1' and in4(0) = '0') then
								sel <= "100";
							elsif (sum5 = '1' and in5(0) = '0') then
								sel <= "101";
							elsif (sum6 = '1' and in6(0) = '0') then
								sel <= "110";
							elsif (sum7 = '1' and in7(0) = '0') then
								sel <= "111";
							elsif (sum8 = '1' and in8(0) = '0') then
								sel <= "000";
							end if;
						else
							message_handler <= idle;
							sel             <= "000";
						end if;
						-- buffering of the inputs for 1 clock cycle
						temp1  <= in1;
						temp2  <= in2;
						temp3  <= in3;
						temp4  <= in4;
						temp5  <= in5;
						temp6  <= in6;
						temp7  <= in7;
						temp8  <= in8;
						temp1c <= temp1;
						temp2c <= temp2;
						temp3c <= temp3;
						temp4c <= temp4;
						temp5c <= temp5;
						temp6c <= temp6;
						temp7c <= temp7;
						temp8c <= temp8;
					--
					when send_message =>
						-- will switch back to idle when endbit is 1 else will stay in send_message
						if (endbit = '1') then
							message_handler <= idle;
						else
							message_handler <= send_message;
						end if;
						-- buffering the inputs
						temp1  <= in1;
						temp2  <= in2;
						temp3  <= in3;
						temp4  <= in4;
						temp5  <= in5;
						temp6  <= in6;
						temp7  <= in7;
						temp8  <= in8;
						temp1c <= temp1;
						temp2c <= temp2;
						temp3c <= temp3;
						temp4c <= temp4;
						temp5c <= temp5;
						temp6c <= temp6;
						temp7c <= temp7;
						temp8c <= temp8;
				end case;
			end if;
		end if;
	end process;

end architecture RTL;
