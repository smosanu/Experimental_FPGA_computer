library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use work.switch_functions.all;

entity switch_periphery is
	port(
		-- 8 outputs in
		input1  : in  std_logic_vector(WIDTH - 1 downto 0);
		input2  : in  std_logic_vector(WIDTH - 1 downto 0);
		input3  : in  std_logic_vector(WIDTH - 1 downto 0);
		input4  : in  std_logic_vector(WIDTH - 1 downto 0);
		input5  : in  std_logic_vector(WIDTH - 1 downto 0);
		input6  : in  std_logic_vector(WIDTH - 1 downto 0);
		input7  : in  std_logic_vector(WIDTH - 1 downto 0);
		input8  : in  std_logic_vector(WIDTH - 1 downto 0);
		-- 8 pins out
		output1 : out std_logic_vector(WIDTH - 1 downto 0);
		output2 : out std_logic_vector(WIDTH - 1 downto 0);
		output3 : out std_logic_vector(WIDTH - 1 downto 0);
		output4 : out std_logic_vector(WIDTH - 1 downto 0);
		output5 : out std_logic_vector(WIDTH - 1 downto 0);
		output6 : out std_logic_vector(WIDTH - 1 downto 0);
		output7 : out std_logic_vector(WIDTH - 1 downto 0);
		output8 : out std_logic_vector(WIDTH - 1 downto 0);
		-- clock and reset
		clk     : in  std_logic;
		rst     : in  std_logic
	);
end entity switch_periphery;

architecture RTL of switch_periphery is

	-- availability outputs
	-- 1 to others
	signal almost_full_1to2 : std_logic;
	signal almost_full_1to3 : std_logic;
	signal almost_full_1to4 : std_logic;
	signal almost_full_1to5 : std_logic;
	signal almost_full_1to6 : std_logic;
	signal almost_full_1to7 : std_logic;
	signal almost_full_1to8 : std_logic;
	-- 2 to others
	signal almost_full_2to1 : std_logic;
	signal almost_full_2to3 : std_logic;
	signal almost_full_2to4 : std_logic;
	signal almost_full_2to5 : std_logic;
	signal almost_full_2to6 : std_logic;
	signal almost_full_2to7 : std_logic;
	signal almost_full_2to8 : std_logic;
	-- 3 to others
	signal almost_full_3to1 : std_logic;
	signal almost_full_3to2 : std_logic;
	signal almost_full_3to4 : std_logic;
	signal almost_full_3to5 : std_logic;
	signal almost_full_3to6 : std_logic;
	signal almost_full_3to7 : std_logic;
	signal almost_full_3to8 : std_logic;
	-- 4 to others
	signal almost_full_4to1 : std_logic;
	signal almost_full_4to2 : std_logic;
	signal almost_full_4to3 : std_logic;
	signal almost_full_4to5 : std_logic;
	signal almost_full_4to6 : std_logic;
	signal almost_full_4to7 : std_logic;
	signal almost_full_4to8 : std_logic;
	-- 5 to others
	signal almost_full_5to1 : std_logic;
	signal almost_full_5to2 : std_logic;
	signal almost_full_5to3 : std_logic;
	signal almost_full_5to4 : std_logic;
	signal almost_full_5to6 : std_logic;
	signal almost_full_5to7 : std_logic;
	signal almost_full_5to8 : std_logic;
	-- 6 to others
	signal almost_full_6to1 : std_logic;
	signal almost_full_6to2 : std_logic;
	signal almost_full_6to3 : std_logic;
	signal almost_full_6to4 : std_logic;
	signal almost_full_6to5 : std_logic;
	signal almost_full_6to7 : std_logic;
	signal almost_full_6to8 : std_logic;
	-- 7 to others
	signal almost_full_7to1 : std_logic;
	signal almost_full_7to2 : std_logic;
	signal almost_full_7to3 : std_logic;
	signal almost_full_7to4 : std_logic;
	signal almost_full_7to5 : std_logic;
	signal almost_full_7to6 : std_logic;
	signal almost_full_7to8 : std_logic;
	-- 8 to others
	signal almost_full_8to1 : std_logic;
	signal almost_full_8to2 : std_logic;
	signal almost_full_8to3 : std_logic;
	signal almost_full_8to4 : std_logic;
	signal almost_full_8to5 : std_logic;
	signal almost_full_8to6 : std_logic;
	signal almost_full_8to7 : std_logic;

	signal Buff2Switch1 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch2 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch3 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch4 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch5 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch6 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch7 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2Switch8 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');

	signal Switch_in1 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in2 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in3 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in4 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in5 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in6 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in7 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');
	signal Switch_in8 : std_logic_vector(WIDTH + 1 - 1 downto 0) := (others => '0');

	signal input1c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input2c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input3c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input4c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input5c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input6c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input7c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal input8c : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');

	signal destination1 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination2 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination3 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination4 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination5 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination6 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination7 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');
	signal destination8 : std_logic_vector(SELCODE - 1 downto 0) := (others => '0');

	signal rd_en_vtr : std_logic_vector(INSOUTS - 1 downto 0) := (others => '0');
	signal wr_en_vtr : std_logic_vector(INSOUTS - 1 downto 0) := (others => '0');
	signal full_vtr  : std_logic_vector(INSOUTS - 1 downto 0) := (others => '0');
	signal empty_vtr : std_logic_vector(INSOUTS - 1 downto 0) := (others => '0');

	-- declare the state machine type (stm handles inputs)
	type state_type_input is (waiting, reading);
	-- state variables
	signal input1_handler : state_type_input;
	signal input2_handler : state_type_input;
	signal input3_handler : state_type_input;
	signal input4_handler : state_type_input;
	signal input5_handler : state_type_input;
	signal input6_handler : state_type_input;
	signal input7_handler : state_type_input;
	signal input8_handler : state_type_input;

	-- declare the state machine type (stm handles reading from FWFT and writing to the switch)
	type state_type_fwft2sw is (acquiring, sending);
	-- state variables
	signal fwft2sw1_handler : state_type_fwft2sw;
	signal fwft2sw2_handler : state_type_fwft2sw;
	signal fwft2sw3_handler : state_type_fwft2sw;
	signal fwft2sw4_handler : state_type_fwft2sw;
	signal fwft2sw5_handler : state_type_fwft2sw;
	signal fwft2sw6_handler : state_type_fwft2sw;
	signal fwft2sw7_handler : state_type_fwft2sw;
	signal fwft2sw8_handler : state_type_fwft2sw;

begin

	-- state machine implementation
	fwft2sw1_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw1_handler <= acquiring;
				rd_en_vtr(1 - 1) <= '0';
			else
				case fwft2sw1_handler is
					when acquiring =>
						if empty_vtr(1 - 1) = '0' then
							fwft2sw1_handler <= sending;
						else
							fwft2sw1_handler <= acquiring;
						end if;
						rd_en_vtr(1 - 1) <= '0';
						destination1     <= Buff2Switch1(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch1(0) = '1' then
							fwft2sw1_handler <= acquiring;
							rd_en_vtr(1 - 1) <= '0';
						else
							if ((destination1 = "010" and almost_full_1to2 = '1') or
								--
								(destination1 = "011" and almost_full_1to3 = '1') or
								--
								(destination1 = "100" and almost_full_1to4 = '1') or
								--
								(destination1 = "101" and almost_full_1to5 = '1') or
								--
								(destination1 = "110" and almost_full_1to6 = '1') or
								--
								(destination1 = "111" and almost_full_1to7 = '1') or
								--
								(destination1 = "000" and almost_full_1to8 = '1')) then
								rd_en_vtr(1 - 1) <= '0';
							else
								rd_en_vtr(1 - 1) <= '1';
							end if;
							fwft2sw1_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in1 <= (others => '0') when rd_en_vtr(1 - 1) <= '0' else Buff2Switch1 & '1';

	fwft2sw2_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw2_handler <= acquiring;
				rd_en_vtr(2 - 1) <= '0';
			else
				case fwft2sw2_handler is
					when acquiring =>
						if empty_vtr(2 - 1) = '0' then
							fwft2sw2_handler <= sending;
						else
							fwft2sw2_handler <= acquiring;
						end if;
						rd_en_vtr(2 - 1) <= '0';
						destination2     <= Buff2Switch2(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch2(0) = '1' then
							fwft2sw2_handler <= acquiring;
							rd_en_vtr(2 - 1) <= '0';
						else
							if ((destination2 = "001" and almost_full_2to1 = '1') or
								--
								(destination2 = "011" and almost_full_2to3 = '1') or
								--
								(destination2 = "100" and almost_full_2to4 = '1') or
								--
								(destination2 = "101" and almost_full_2to5 = '1') or
								--
								(destination2 = "110" and almost_full_2to6 = '1') or
								--
								(destination2 = "111" and almost_full_2to7 = '1') or
								--
								(destination2 = "000" and almost_full_2to8 = '1')) then
								rd_en_vtr(2 - 1) <= '0';
							else
								rd_en_vtr(2 - 1) <= '1';
							end if;
							fwft2sw2_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in2 <= (others => '0') when rd_en_vtr(2 - 1) <= '0' else Buff2Switch2 & '1';

	fwft2sw3_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw3_handler <= acquiring;
				rd_en_vtr(3 - 1) <= '0';
			else
				case fwft2sw3_handler is
					when acquiring =>
						if empty_vtr(3 - 1) = '0' then
							fwft2sw3_handler <= sending;
						else
							fwft2sw3_handler <= acquiring;
						end if;
						rd_en_vtr(3 - 1) <= '0';
						destination3     <= Buff2Switch3(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch3(0) = '1' then
							fwft2sw3_handler <= acquiring;
							rd_en_vtr(3 - 1) <= '0';
						else
							if ((destination3 = "001" and almost_full_3to1 = '1') or
								--
								(destination3 = "010" and almost_full_3to2 = '1') or
								--
								(destination3 = "100" and almost_full_3to4 = '1') or
								--
								(destination3 = "101" and almost_full_3to5 = '1') or
								--
								(destination3 = "110" and almost_full_3to6 = '1') or
								--
								(destination3 = "111" and almost_full_3to7 = '1') or
								--
								(destination3 = "000" and almost_full_3to8 = '1')) then
								rd_en_vtr(3 - 1) <= '0';
							else
								rd_en_vtr(3 - 1) <= '1';
							end if;
							fwft2sw3_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in3 <= (others => '0') when rd_en_vtr(3 - 1) <= '0' else Buff2Switch3 & '1';

	fwft2sw4_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw4_handler <= acquiring;
				rd_en_vtr(4 - 1) <= '0';
			else
				case fwft2sw4_handler is
					when acquiring =>
						if empty_vtr(4 - 1) = '0' then
							fwft2sw4_handler <= sending;
						else
							fwft2sw4_handler <= acquiring;
						end if;
						rd_en_vtr(4 - 1) <= '0';
						destination4     <= Buff2Switch4(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch4(0) = '1' then
							fwft2sw4_handler <= acquiring;
							rd_en_vtr(4 - 1) <= '0';
						else
							if ((destination4 = "001" and almost_full_4to1 = '1') or
								--
								(destination4 = "010" and almost_full_4to2 = '1') or
								--
								(destination4 = "011" and almost_full_4to3 = '1') or
								--
								(destination4 = "101" and almost_full_4to5 = '1') or
								--
								(destination4 = "110" and almost_full_4to6 = '1') or
								--
								(destination4 = "111" and almost_full_4to7 = '1') or
								--
								(destination4 = "000" and almost_full_4to8 = '1')) then
								rd_en_vtr(4 - 1) <= '0';
							else
								rd_en_vtr(4 - 1) <= '1';
							end if;
							fwft2sw4_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in4 <= (others => '0') when rd_en_vtr(4 - 1) <= '0' else Buff2Switch4 & '1';

	fwft2sw5_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw5_handler <= acquiring;
				rd_en_vtr(5 - 1) <= '0';
			else
				case fwft2sw5_handler is
					when acquiring =>
						if empty_vtr(5 - 1) = '0' then
							fwft2sw5_handler <= sending;
						else
							fwft2sw5_handler <= acquiring;
						end if;
						rd_en_vtr(5 - 1) <= '0';
						destination5     <= Buff2Switch5(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch5(0) = '1' then
							fwft2sw5_handler <= acquiring;
							rd_en_vtr(5 - 1) <= '0';
						else
							if ((destination5 = "001" and almost_full_5to1 = '1') or
								--
								(destination5 = "010" and almost_full_5to2 = '1') or
								--
								(destination5 = "011" and almost_full_5to3 = '1') or
								--
								(destination5 = "100" and almost_full_5to4 = '1') or
								--
								(destination5 = "110" and almost_full_5to6 = '1') or
								--
								(destination5 = "111" and almost_full_5to7 = '1') or
								--
								(destination5 = "000" and almost_full_5to8 = '1')) then
								rd_en_vtr(5 - 1) <= '0';
							else
								rd_en_vtr(5 - 1) <= '1';
							end if;
							fwft2sw5_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in5 <= (others => '0') when rd_en_vtr(5 - 1) <= '0' else Buff2Switch5 & '1';

	fwft2sw6_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw6_handler <= acquiring;
				rd_en_vtr(6 - 1) <= '0';
			else
				case fwft2sw6_handler is
					when acquiring =>
						if empty_vtr(6 - 1) = '0' then
							fwft2sw6_handler <= sending;
						else
							fwft2sw6_handler <= acquiring;
						end if;
						rd_en_vtr(6 - 1) <= '0';
						destination6     <= Buff2Switch6(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch6(0) = '1' then
							fwft2sw6_handler <= acquiring;
							rd_en_vtr(6 - 1) <= '0';
						else
							if ((destination6 = "001" and almost_full_6to1 = '1') or
								--
								(destination6 = "010" and almost_full_6to2 = '1') or
								--
								(destination6 = "011" and almost_full_6to3 = '1') or
								--
								(destination6 = "100" and almost_full_6to4 = '1') or
								--
								(destination6 = "101" and almost_full_6to5 = '1') or
								--
								(destination6 = "111" and almost_full_6to7 = '1') or
								--
								(destination6 = "000" and almost_full_6to8 = '1')) then
								rd_en_vtr(6 - 1) <= '0';
							else
								rd_en_vtr(6 - 1) <= '1';
							end if;
							fwft2sw6_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in6 <= (others => '0') when rd_en_vtr(6 - 1) <= '0' else Buff2Switch6 & '1';

	fwft2sw7_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw7_handler <= acquiring;
				rd_en_vtr(7 - 1) <= '0';
			else
				case fwft2sw7_handler is
					when acquiring =>
						if empty_vtr(7 - 1) = '0' then
							fwft2sw7_handler <= sending;
						else
							fwft2sw7_handler <= acquiring;
						end if;
						rd_en_vtr(7 - 1) <= '0';
						destination7     <= Buff2Switch7(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch7(0) = '1' then
							fwft2sw7_handler <= acquiring;
							rd_en_vtr(7 - 1) <= '0';
						else
							if ((destination7 = "001" and almost_full_7to1 = '1') or
								--
								(destination7 = "010" and almost_full_7to2 = '1') or
								--
								(destination7 = "011" and almost_full_7to3 = '1') or
								--
								(destination7 = "100" and almost_full_7to4 = '1') or
								--
								(destination7 = "101" and almost_full_7to5 = '1') or
								--
								(destination7 = "110" and almost_full_7to6 = '1') or
								--
								(destination7 = "000" and almost_full_7to8 = '1')) then
								rd_en_vtr(7 - 1) <= '0';
							else
								rd_en_vtr(7 - 1) <= '1';
							end if;
							fwft2sw7_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in7 <= (others => '0') when rd_en_vtr(7 - 1) <= '0' else Buff2Switch7 & '1';

	fwft2sw8_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				fwft2sw8_handler <= acquiring;
				rd_en_vtr(8 - 1) <= '0';
			else
				case fwft2sw8_handler is
					when acquiring =>
						if empty_vtr(8 - 1) = '0' then
							fwft2sw8_handler <= sending;
						else
							fwft2sw8_handler <= acquiring;
						end if;
						rd_en_vtr(8 - 1) <= '0';
						destination8     <= Buff2Switch8(WIDTH - 1 - 1 downto WIDTH - 1 - SELCODE);
					when sending =>
						if Buff2Switch8(0) = '1' then
							fwft2sw8_handler <= acquiring;
							rd_en_vtr(8 - 1) <= '0';
						else
							if ((destination8 = "001" and almost_full_8to1 = '1') or
								--
								(destination8 = "010" and almost_full_8to2 = '1') or
								--
								(destination8 = "011" and almost_full_8to3 = '1') or
								--
								(destination8 = "100" and almost_full_8to4 = '1') or
								--
								(destination8 = "101" and almost_full_8to5 = '1') or
								--
								(destination8 = "110" and almost_full_8to6 = '1') or
								--
								(destination8 = "111" and almost_full_8to7 = '1')) then
								rd_en_vtr(8 - 1) <= '0';
							else
								rd_en_vtr(8 - 1) <= '1';
							end if;
							fwft2sw8_handler <= sending;
						end if;
				end case;
			end if;
		end if;
	end process;
	Switch_in8 <= (others => '0') when rd_en_vtr(8 - 1) <= '0' else Buff2Switch8 & '1';

	-- state machine implementation
	input1_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input1_handler   <= waiting;
				wr_en_vtr(1 - 1) <= '0';
			else
				case input1_handler is
					when waiting =>
						if (or_reduce(input1) = '1') then
							input1_handler   <= reading;
							wr_en_vtr(1 - 1) <= '1' and not full_vtr(1 - 1);
						else
							input1_handler   <= waiting;
							wr_en_vtr(1 - 1) <= '0';
						end if;
					when reading =>
						if input1(0) = '1' then
							input1_handler <= waiting;
						else
							input1_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input2_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input2_handler   <= waiting;
				wr_en_vtr(2 - 1) <= '0';
			else
				case input2_handler is
					when waiting =>
						if (or_reduce(input2) = '1') then
							input2_handler   <= reading;
							wr_en_vtr(2 - 1) <= '1' and not full_vtr(2 - 1);
						else
							input2_handler   <= waiting;
							wr_en_vtr(2 - 1) <= '0';
						end if;
					when reading =>
						if input2(0) = '1' then
							input2_handler <= waiting;
						else
							input2_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input3_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input3_handler   <= waiting;
				wr_en_vtr(3 - 1) <= '0';
			else
				case input3_handler is
					when waiting =>
						if (or_reduce(input3) = '1') then
							input3_handler   <= reading;
							wr_en_vtr(3 - 1) <= '1' and not full_vtr(3 - 1);
						else
							input3_handler   <= waiting;
							wr_en_vtr(3 - 1) <= '0';
						end if;
					when reading =>
						if input3(0) = '1' then
							input3_handler <= waiting;
						else
							input3_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input4_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input4_handler   <= waiting;
				wr_en_vtr(4 - 1) <= '0';
			else
				case input4_handler is
					when waiting =>
						if (or_reduce(input4) = '1') then
							input4_handler   <= reading;
							wr_en_vtr(4 - 1) <= '1' and not full_vtr(4 - 1);
						else
							input4_handler   <= waiting;
							wr_en_vtr(4 - 1) <= '0';
						end if;
					when reading =>
						if input4(0) = '1' then
							input4_handler <= waiting;
						else
							input4_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input5_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input5_handler   <= waiting;
				wr_en_vtr(5 - 1) <= '0';
			else
				case input5_handler is
					when waiting =>
						if (or_reduce(input5) = '1') then
							input5_handler   <= reading;
							wr_en_vtr(5 - 1) <= '1' and not full_vtr(5 - 1);
						else
							input5_handler   <= waiting;
							wr_en_vtr(5 - 1) <= '0';
						end if;
					when reading =>
						if input5(0) = '1' then
							input5_handler <= waiting;
						else
							input5_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input6_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input6_handler   <= waiting;
				wr_en_vtr(6 - 1) <= '0';
			else
				case input6_handler is
					when waiting =>
						if (or_reduce(input6) = '1') then
							input6_handler   <= reading;
							wr_en_vtr(6 - 1) <= '1' and not full_vtr(6 - 1);
						else
							input6_handler   <= waiting;
							wr_en_vtr(6 - 1) <= '0';
						end if;
					when reading =>
						if input6(0) = '1' then
							input6_handler <= waiting;
						else
							input6_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input7_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input7_handler   <= waiting;
				wr_en_vtr(7 - 1) <= '0';
			else
				case input7_handler is
					when waiting =>
						if (or_reduce(input7) = '1') then
							input7_handler   <= reading;
							wr_en_vtr(7 - 1) <= '1' and not full_vtr(7 - 1);
						else
							input7_handler   <= waiting;
							wr_en_vtr(7 - 1) <= '0';
						end if;
					when reading =>
						if input7(0) = '1' then
							input7_handler <= waiting;
						else
							input7_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	input8_handler_sm : process(clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then         -- reset
				input8_handler   <= waiting;
				wr_en_vtr(8 - 1) <= '0';
			else
				case input8_handler is
					when waiting =>
						if (or_reduce(input8) = '1') then
							input8_handler   <= reading;
							wr_en_vtr(8 - 1) <= '1' and not full_vtr(8 - 1);
						else
							input8_handler   <= waiting;
							wr_en_vtr(8 - 1) <= '0';
						end if;
					when reading =>
						if input8(0) = '1' then
							input8_handler <= waiting;
						else
							input8_handler <= reading;
						end if;
				end case;
			end if;
		end if;
	end process;

	process(clk)
	begin
		if rising_edge(clk) then
			input1c <= input1;
			input2c <= input2;
			input3c <= input3;
			input4c <= input4;
			input5c <= input5;
			input6c <= input6;
			input7c <= input7;
			input8c <= input8;
		end if;
	end process;

	DUT_Buff_IN1 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input1c,
			wr_en => wr_en_vtr(0),
			rd_en => rd_en_vtr(0),
			dout  => Buff2Switch1,
			full  => full_vtr(0),
			empty => empty_vtr(0)
		);

	DUT_Buff_IN2 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input2c,
			wr_en => wr_en_vtr(1),
			rd_en => rd_en_vtr(1),
			dout  => Buff2Switch2,
			full  => full_vtr(1),
			empty => empty_vtr(1)
		);

	DUT_Buff_IN3 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input3c,
			wr_en => wr_en_vtr(2),
			rd_en => rd_en_vtr(2),
			dout  => Buff2Switch3,
			full  => full_vtr(2),
			empty => empty_vtr(2)
		);

	DUT_Buff_IN4 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input4c,
			wr_en => wr_en_vtr(3),
			rd_en => rd_en_vtr(3),
			dout  => Buff2Switch4,
			full  => full_vtr(3),
			empty => empty_vtr(3)
		);

	DUT_Buff_IN5 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input5c,
			wr_en => wr_en_vtr(4),
			rd_en => rd_en_vtr(4),
			dout  => Buff2Switch5,
			full  => full_vtr(4),
			empty => empty_vtr(4)
		);

	DUT_Buff_IN6 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input6c,
			wr_en => wr_en_vtr(5),
			rd_en => rd_en_vtr(5),
			dout  => Buff2Switch6,
			full  => full_vtr(5),
			empty => empty_vtr(5)
		);

	DUT_Buff_IN7 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input7c,
			wr_en => wr_en_vtr(6),
			rd_en => rd_en_vtr(6),
			dout  => Buff2Switch7,
			full  => full_vtr(6),
			empty => empty_vtr(6)
		);

	DUT_Buff_IN8 : entity work.fwft_19_128(fwft_19_128_a)
		port map(
			clk   => clk,
			srst  => rst,
			din   => input8c,
			wr_en => wr_en_vtr(7),
			rd_en => rd_en_vtr(7),
			dout  => Buff2Switch8,
			full  => full_vtr(7),
			empty => empty_vtr(7)
		);

	-- Design Under Test
	DUT : entity work.switch_module(RTL)
		port map(
			input1           => Switch_in1,
			input2           => Switch_in2,
			input3           => Switch_in3,
			input4           => Switch_in4,
			input5           => Switch_in5,
			input6           => Switch_in6,
			input7           => Switch_in7,
			input8           => Switch_in8,
			output1          => output1,
			output2          => output2,
			output3          => output3,
			output4          => output4,
			output5          => output5,
			output6          => output6,
			output7          => output7,
			output8          => output8,
			almost_full_1to2 => almost_full_1to2,
			almost_full_1to3 => almost_full_1to3,
			almost_full_1to4 => almost_full_1to4,
			almost_full_1to5 => almost_full_1to5,
			almost_full_1to6 => almost_full_1to6,
			almost_full_1to7 => almost_full_1to7,
			almost_full_1to8 => almost_full_1to8,
			almost_full_2to1 => almost_full_2to1,
			almost_full_2to3 => almost_full_2to3,
			almost_full_2to4 => almost_full_2to4,
			almost_full_2to5 => almost_full_2to5,
			almost_full_2to6 => almost_full_2to6,
			almost_full_2to7 => almost_full_2to7,
			almost_full_2to8 => almost_full_2to8,
			almost_full_3to1 => almost_full_3to1,
			almost_full_3to2 => almost_full_3to2,
			almost_full_3to4 => almost_full_3to4,
			almost_full_3to5 => almost_full_3to5,
			almost_full_3to6 => almost_full_3to6,
			almost_full_3to7 => almost_full_3to7,
			almost_full_3to8 => almost_full_3to8,
			almost_full_4to1 => almost_full_4to1,
			almost_full_4to2 => almost_full_4to2,
			almost_full_4to3 => almost_full_4to3,
			almost_full_4to5 => almost_full_4to5,
			almost_full_4to6 => almost_full_4to6,
			almost_full_4to7 => almost_full_4to7,
			almost_full_4to8 => almost_full_4to8,
			almost_full_5to1 => almost_full_5to1,
			almost_full_5to2 => almost_full_5to2,
			almost_full_5to3 => almost_full_5to3,
			almost_full_5to4 => almost_full_5to4,
			almost_full_5to6 => almost_full_5to6,
			almost_full_5to7 => almost_full_5to7,
			almost_full_5to8 => almost_full_5to8,
			almost_full_6to1 => almost_full_6to1,
			almost_full_6to2 => almost_full_6to2,
			almost_full_6to3 => almost_full_6to3,
			almost_full_6to4 => almost_full_6to4,
			almost_full_6to5 => almost_full_6to5,
			almost_full_6to7 => almost_full_6to7,
			almost_full_6to8 => almost_full_6to8,
			almost_full_7to1 => almost_full_7to1,
			almost_full_7to2 => almost_full_7to2,
			almost_full_7to3 => almost_full_7to3,
			almost_full_7to4 => almost_full_7to4,
			almost_full_7to5 => almost_full_7to5,
			almost_full_7to6 => almost_full_7to6,
			almost_full_7to8 => almost_full_7to8,
			almost_full_8to1 => almost_full_8to1,
			almost_full_8to2 => almost_full_8to2,
			almost_full_8to3 => almost_full_8to3,
			almost_full_8to4 => almost_full_8to4,
			almost_full_8to5 => almost_full_8to5,
			almost_full_8to6 => almost_full_8to6,
			almost_full_8to7 => almost_full_8to7,
			clk              => clk,
			rst              => rst
		);
end architecture RTL;
