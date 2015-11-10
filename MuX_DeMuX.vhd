library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.switch_functions.all;

entity MuX_DeMuX is
	port(
		-- the single side of the MUX and DEMUX
		input : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		ouput : out std_logic_vector(WIDTH - 1 downto 0);
		-- inputs of MUX (first to the buffers)
		in1   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in2   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in3   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in4   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in5   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in6   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in7   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		in8   : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		-- outputs of DEMUX + 3bits describing number of available places in each buffer
		ou1   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou2   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou3   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou4   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou5   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou6   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou7   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		ou8   : out std_logic_vector(WIDTH + 1 - 1 + 1 downto 0);
		-- clock and reset
		clk   : in  std_logic;
		rst   : in  std_logic
	);
end entity MuX_DeMuX;

architecture RTL of MuX_DeMuX is
	-- copy of DEMUX output
	signal ou1c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou2c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou3c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou4c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou5c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou6c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou7c : std_logic_vector(WIDTH + 1 - 1 downto 0);
	signal ou8c : std_logic_vector(WIDTH + 1 - 1 downto 0);

	signal Buff2MuX1 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX2 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX3 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX4 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX5 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX6 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX7 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal Buff2MuX8 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');

	signal MuXin1 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin2 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin3 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin4 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin5 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin6 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin7 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
	signal MuXin8 : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');

	signal end_msg : std_logic;         -- is 1 when a message was processed and the end_bit was 1

	-- if FIFO is empty, empty is 1, else 0
	--	signal empty1 : std_logic;
	--	signal empty2 : std_logic;
	--	signal empty3 : std_logic;
	--	signal empty4 : std_logic;
	--	signal empty5 : std_logic;
	--	signal empty6 : std_logic;
	--	signal empty7 : std_logic;
	--	signal empty8 : std_logic;
	signal empty_vtr : std_logic_vector(INSOUTS - 1 downto 0);

	-- copied empty signals in memory for one more cycle
	--	signal empty1c : std_logic;
	--	signal empty2c : std_logic;
	--	signal empty3c : std_logic;
	--	signal empty4c : std_logic;
	--	signal empty5c : std_logic;
	--	signal empty6c : std_logic;
	--	signal empty7c : std_logic;
	--	signal empty8c : std_logic;
	signal empty_vtr_c : std_logic_vector(INSOUTS - 1 downto 0);

	-- if FIFO is full, full is 1, else 0
	--	signal full1 : std_logic;
	--	signal full2 : std_logic;
	--	signal full3 : std_logic;
	--	signal full4 : std_logic;
	--	signal full5 : std_logic;
	--	signal full6 : std_logic;
	--	signal full7 : std_logic;
	--	signal full8 : std_logic;
	signal full_vtr : std_logic_vector(INSOUTS - 1 downto 0);

	-- describe the occupancy of each FIFO
	signal occ1 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ2 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ3 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ4 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ5 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ6 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ7 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ8 : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');

	-- modified occ based on the scheduling policy (either occx or inverse)
	signal occ1c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ2c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ3c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ4c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ5c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ6c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ7c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');
	signal occ8c : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');

	-- will be active when a FIFO has only 2 left words inside 
	--	signal almost_full1 : std_logic := '0';
	--	signal almost_full2 : std_logic := '0';
	--	signal almost_full3 : std_logic := '0';
	--	signal almost_full4 : std_logic := '0';
	--	signal almost_full5 : std_logic := '0';
	--	signal almost_full6 : std_logic := '0';
	--	signal almost_full7 : std_logic := '0';
	--	signal almost_full8 : std_logic := '0';
	signal almost_full_vtr : std_logic_vector(INSOUTS - 1 downto 0);

	-- FIFO write enables (TO DO: switch to a vector)
	--	signal wr_en1 : std_logic := '1';
	--	signal wr_en2 : std_logic := '1';
	--	signal wr_en3 : std_logic := '1';
	--	signal wr_en4 : std_logic := '1';
	--	signal wr_en5 : std_logic := '1';
	--	signal wr_en6 : std_logic := '1';
	--	signal wr_en7 : std_logic := '1';
	--	signal wr_en8 : std_logic := '1';
	signal wr_en_vtr : std_logic_vector(INSOUTS - 1 downto 0);

	-- FIFO read enable vector and copy for next clock cycle
	signal rd_en_vtr   : std_logic_vector(INSOUTS - 1 downto 0) := (others => '0');
	signal rd_en_vtrc  : std_logic_vector(INSOUTS - 1 downto 0) := (others => '0');
	-- Shortest Queue First (0) or Largest Queue First (1) flag
	signal SQF_LQF     : std_logic                              := '0';
	-- Pseudo Random Number
	signal prn         : std_logic_vector(2 downto 0);
	-- Constants
	constant ground    : std_logic_vector(WIDTH - 1 downto 0)   := (others => '0');
	constant empty_occ : std_logic_vector(ENC_OCC - 1 downto 0) := (others => '0');

	-- declare the state machine type
	type rden_sm_type is (idle, send);
	-- state variable
	signal rden_sm_handler : rden_sm_type;

begin
	ou1 <= ou1c & almost_full_vtr(0);
	ou2 <= ou2c & almost_full_vtr(1);
	ou3 <= ou3c & almost_full_vtr(2);
	ou4 <= ou4c & almost_full_vtr(3);
	ou5 <= ou5c & almost_full_vtr(4);
	ou6 <= ou6c & almost_full_vtr(5);
	ou7 <= ou7c & almost_full_vtr(6);
	ou8 <= ou8c & almost_full_vtr(7);

	almost_full_vtr(0) <= '1' when (occ1(ENC_OCC - 1) and occ1(ENC_OCC - 2) and occ1(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(1) <= '1' when (occ2(ENC_OCC - 1) and occ2(ENC_OCC - 2) and occ2(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(2) <= '1' when (occ3(ENC_OCC - 1) and occ3(ENC_OCC - 2) and occ3(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(3) <= '1' when (occ4(ENC_OCC - 1) and occ4(ENC_OCC - 2) and occ4(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(4) <= '1' when (occ5(ENC_OCC - 1) and occ5(ENC_OCC - 2) and occ5(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(5) <= '1' when (occ6(ENC_OCC - 1) and occ6(ENC_OCC - 2) and occ6(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(6) <= '1' when (occ7(ENC_OCC - 1) and occ7(ENC_OCC - 2) and occ7(ENC_OCC - 3)) = '1' else '0';
	almost_full_vtr(7) <= '1' when (occ8(ENC_OCC - 1) and occ8(ENC_OCC - 2) and occ8(ENC_OCC - 3)) = '1' else '0';

	wr_en_vtr(0) <= in1(0) and not full_vtr(0);
	wr_en_vtr(1) <= in2(0) and not full_vtr(1);
	wr_en_vtr(2) <= in3(0) and not full_vtr(2);
	wr_en_vtr(3) <= in4(0) and not full_vtr(3);
	wr_en_vtr(4) <= in5(0) and not full_vtr(4);
	wr_en_vtr(5) <= in6(0) and not full_vtr(5);
	wr_en_vtr(6) <= in7(0) and not full_vtr(6);
	wr_en_vtr(7) <= in8(0) and not full_vtr(7);

	process(clk)
	begin
		if rising_edge(clk) then
			--			empty1c    <= empty1;
			--			empty2c    <= empty2;
			--			empty3c    <= empty3;
			--			empty4c    <= empty4;
			--			empty5c    <= empty5;
			--			empty6c    <= empty6;
			--			empty7c    <= empty7;
			--			empty8c    <= empty8;
			empty_vtr_c <= empty_vtr;
			rd_en_vtrc  <= rd_en_vtr;
		end if;
	end process;

	MuXin1 <= Buff2MuX1 when empty_vtr_c(0) = '0' and rd_en_vtrc(0) = '1' else ground;
	MuXin2 <= Buff2MuX2 when empty_vtr_c(1) = '0' and rd_en_vtrc(1) = '1' else ground;
	MuXin3 <= Buff2MuX3 when empty_vtr_c(2) = '0' and rd_en_vtrc(2) = '1' else ground;
	MuXin4 <= Buff2MuX4 when empty_vtr_c(3) = '0' and rd_en_vtrc(3) = '1' else ground;
	MuXin5 <= Buff2MuX5 when empty_vtr_c(4) = '0' and rd_en_vtrc(4) = '1' else ground;
	MuXin6 <= Buff2MuX6 when empty_vtr_c(5) = '0' and rd_en_vtrc(5) = '1' else ground;
	MuXin7 <= Buff2MuX7 when empty_vtr_c(6) = '0' and rd_en_vtrc(6) = '1' else ground;
	MuXin8 <= Buff2MuX8 when empty_vtr_c(7) = '0' and rd_en_vtrc(7) = '1' else ground;

	end_msg <= MuXin1(0) or MuXin2(0) or MuXin3(0) or MuXin4(0) or MuXin5(0) or MuXin6(0) or MuXin7(0) or MuXin8(0);

	Q_ALG_GEN : if USE_SCH_SQF_LQF = TRUE generate
		-- scheduling policy module (shortest queue first and largest queue first (SQF_LQF) based on occupancy)

		SQF_LQF <= occ1(ENC_OCC - 1) or occ2(ENC_OCC - 1) or occ3(ENC_OCC - 1) or occ4(ENC_OCC - 1) or occ5(ENC_OCC - 1) or occ6(ENC_OCC - 1) or occ7(ENC_OCC - 1) or occ8(ENC_OCC - 1);

		occ1c <= occ1 when SQF_LQF = '1' or occ1 = empty_occ else not occ1;
		occ2c <= occ2 when SQF_LQF = '1' or occ2 = empty_occ else not occ2;
		occ3c <= occ3 when SQF_LQF = '1' or occ3 = empty_occ else not occ3;
		occ4c <= occ4 when SQF_LQF = '1' or occ4 = empty_occ else not occ4;
		occ5c <= occ5 when SQF_LQF = '1' or occ5 = empty_occ else not occ5;
		occ6c <= occ6 when SQF_LQF = '1' or occ6 = empty_occ else not occ6;
		occ7c <= occ7 when SQF_LQF = '1' or occ7 = empty_occ else not occ7;
		occ8c <= occ8 when SQF_LQF = '1' or occ8 = empty_occ else not occ8;

		-- state machine implementation
		rden_sm_handler_sm : process(clk)
		begin
			if (rising_edge(clk)) then
				if (rst = '1') then     -- reset signals
					rden_sm_handler <= idle;
					rd_en_vtr       <= "00000000";
				else
					case rden_sm_handler is
						when idle =>
							if (occ1c >= occ2c and occ1c >= occ3c and occ1c >= occ4c and occ1c >= occ5c and occ1c >= occ6c and occ1c >= occ7c and occ1c >= occ8c) and (empty_vtr(0) = '0') then
								rd_en_vtr       <= "00000001";
								rden_sm_handler <= send;
							elsif (occ2c >= occ3c and occ2c >= occ4c and occ2c >= occ5c and occ2c >= occ6c and occ2c >= occ7c and occ2c >= occ8c) and (empty_vtr(1) = '0') then
								rd_en_vtr       <= "00000010";
								rden_sm_handler <= send;
							elsif (occ3c >= occ4c and occ3c >= occ5c and occ3c >= occ6c and occ3c >= occ7c and occ3c >= occ8c) and (empty_vtr(2) = '0') then
								rd_en_vtr       <= "00000100";
								rden_sm_handler <= send;
							elsif (occ4c >= occ5c and occ4c >= occ6c and occ4c >= occ7c and occ4c >= occ8c) and (empty_vtr(3) = '0') then
								rd_en_vtr       <= "00001000";
								rden_sm_handler <= send;
							elsif (occ5c >= occ6c and occ5c >= occ7c and occ5c >= occ8c) and (empty_vtr(4) = '0') then
								rd_en_vtr       <= "00010000";
								rden_sm_handler <= send;
							elsif (occ6c >= occ7c and occ6c >= occ8c) and (empty_vtr(5) = '0') then
								rd_en_vtr       <= "00100000";
								rden_sm_handler <= send;
							elsif (occ7c >= occ8c) and (empty_vtr(6) = '0') then
								rd_en_vtr       <= "01000000";
								rden_sm_handler <= send;
							elsif (empty_vtr(7) = '0') then
								rd_en_vtr       <= "10000000";
								rden_sm_handler <= send;
							end if;
						when send =>
							if end_msg = '1' then
								rd_en_vtr       <= "00000000";
								rden_sm_handler <= idle;
							end if;
					end case;
				end if;
			end if;
		end process;
	end generate Q_ALG_GEN;

	PRN_ALG_GEN : if USE_SCH_SQF_LQF = FALSE generate
		-- scheduling policy module (based on a pseudo random number generator)

		-- state machine implementation
		rden_sm_handler_sm : process(clk)
		begin
			if (rising_edge(clk)) then
				if (rst = '1') then     -- reset signals
					rden_sm_handler <= idle;
					rd_en_vtr       <= "00000000";
				else
					case rden_sm_handler is
						when idle =>
							if (prn = "001") and (empty_vtr(0) = '0') then
								rd_en_vtr       <= "00000001";
								rden_sm_handler <= send;
							end if;
							if (prn = "010") and (empty_vtr(1) = '0') then
								rd_en_vtr       <= "00000010";
								rden_sm_handler <= send;
							end if;
							if (prn = "011") and (empty_vtr(2) = '0') then
								rd_en_vtr       <= "00000100";
								rden_sm_handler <= send;
							end if;
							if (prn = "100") and (empty_vtr(3) = '0') then
								rd_en_vtr       <= "00001000";
								rden_sm_handler <= send;
							end if;
							if (prn = "101") and (empty_vtr(4) = '0') then
								rd_en_vtr       <= "00010000";
								rden_sm_handler <= send;
							end if;
							if (prn = "110") and (empty_vtr(5) = '0') then
								rd_en_vtr       <= "00100000";
								rden_sm_handler <= send;
							end if;
							if (prn = "111") and (empty_vtr(6) = '0') then
								rd_en_vtr       <= "01000000";
								rden_sm_handler <= send;
							end if;
							if (prn = "000") and (empty_vtr(7) = '0') then
								rd_en_vtr       <= "10000000";
								rden_sm_handler <= send;
							end if;
						when send =>
							if end_msg = '1' then
								rd_en_vtr       <= "00000000";
								rden_sm_handler <= idle;
							end if;
					end case;
				end if;
			end if;
		end process;
	end generate PRN_ALG_GEN;

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
			fifo_en_vtr => rd_en_vtrc,
			ouput       => ouput,
			clk         => clk,
			rst         => rst
		);

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

	DUT_Buff1 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in1(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(0),
			rd_en      => rd_en_vtr(0),
			dout       => Buff2MuX1,
			full       => full_vtr(0),
			empty      => empty_vtr(0),
			data_count => occ1
		);

	DUT_Buff2 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in2(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(1),
			rd_en      => rd_en_vtr(1),
			dout       => Buff2MuX2,
			full       => full_vtr(1),
			empty      => empty_vtr(1),
			data_count => occ2
		);

	DUT_Buff3 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in3(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(2),
			rd_en      => rd_en_vtr(2),
			dout       => Buff2MuX3,
			full       => full_vtr(2),
			empty      => empty_vtr(2),
			data_count => occ3
		);

	DUT_Buff4 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in4(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(3),
			rd_en      => rd_en_vtr(3),
			dout       => Buff2MuX4,
			full       => full_vtr(3),
			empty      => empty_vtr(3),
			data_count => occ4
		);

	DUT_Buff5 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in5(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(4),
			rd_en      => rd_en_vtr(4),
			dout       => Buff2MuX5,
			full       => full_vtr(4),
			empty      => empty_vtr(4),
			data_count => occ5
		);

	DUT_Buff6 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in6(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(5),
			rd_en      => rd_en_vtr(5),
			dout       => Buff2MuX6,
			full       => full_vtr(5),
			empty      => empty_vtr(5),
			data_count => occ6
		);

	DUT_Buff7 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in7(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(6),
			rd_en      => rd_en_vtr(6),
			dout       => Buff2MuX7,
			full       => full_vtr(6),
			empty      => empty_vtr(6),
			data_count => occ7
		);

	DUT_Buff8 : entity work.fifo_19_64(fifo_19_64_a)
		port map(
			clk        => clk,
			srst       => rst,
			din        => in8(WIDTH + 1 - 1 downto 1),
			wr_en      => wr_en_vtr(7),
			rd_en      => rd_en_vtr(7),
			dout       => Buff2MuX8,
			full       => full_vtr(7),
			empty      => empty_vtr(7),
			data_count => occ8
		);

	PRN_ALG_GEN_pm : if USE_SCH_SQF_LQF = FALSE generate
		-- scheduling policy module (based on a pseudo random number generator)
		DUT_PRNG : entity work.LFSR_PRNG(RTL)
			port map(
				clk => clk,
				rst => rst,
				prn => prn
			);
	end generate PRN_ALG_GEN_pm;

end architecture RTL;

--		case prn is
--			when "001" => if empty1 = '0' then
--					rd_en_vtr       <= "00000001";
--					rden_sm_handler <= send;
--				end if;
--			when "010" => if empty2 = '0' then
--					rd_en_vtr       <= "00000010";
--					rden_sm_handler <= send;
--				end if;
--			when "011" => if empty3 = '0' then
--					rd_en_vtr       <= "00000100";
--					rden_sm_handler <= send;
--				end if;
--			when "100" => if empty4 = '0' then
--					rd_en_vtr       <= "00001000";
--					rden_sm_handler <= send;
--				end if;
--			when "101" => if empty5 = '0' then
--					rd_en_vtr       <= "00010000";
--					rden_sm_handler <= send;
--				end if;
--			when "110" => if empty6 = '0' then
--					rd_en_vtr       <= "00100000";
--					rden_sm_handler <= send;
--				end if;
--			when "111" => if empty7 = '0' then
--					rd_en_vtr       <= "01000000";
--					rden_sm_handler <= send;
--				end if;
--			when "000" => if empty8 = '0' then
--					rd_en_vtr       <= "10000000";
--					rden_sm_handler <= send;
--				end if;
--		end case;


--		rd_en_vtr <=
--			-- 
--			"00000001" when (empty1 = '0') and ((rd_en_vtr(0) = '1' and end_msg = '0') or (prn = "001")) else
--			--
--			"00000010" when (empty2 = '0') and ((rd_en_vtr(1) = '1' and end_msg = '0') or (prn = "010")) else
--			--
--			"00000100" when (empty3 = '0') and ((rd_en_vtr(2) = '1' and end_msg = '0') or (prn = "011")) else
--			--
--			"00001000" when (empty4 = '0') and ((rd_en_vtr(3) = '1' and end_msg = '0') or (prn = "100")) else
--			--
--			"00010000" when (empty5 = '0') and ((rd_en_vtr(4) = '1' and end_msg = '0') or (prn = "101")) else
--			--
--			"00100000" when (empty6 = '0') and ((rd_en_vtr(5) = '1' and end_msg = '0') or (prn = "110")) else
--			--
--			"01000000" when (empty7 = '0') and ((rd_en_vtr(6) = '1' and end_msg = '0') or (prn = "111")) else
--			--
--			"10000000" when (empty8 = '0') and ((rd_en_vtr(7) = '1' and end_msg = '0') or (prn = "000")) else "00000000";


--		rd_en_vtr <=
--			--
--			--"00000000" when end_msg = '1' else -- (also a good solution, but which involves wasting a clock cycle while reseting the rd_en_vtr)
--			--
--			"00000001" when (empty1 = '0') and ((rd_en_vtr(0) = '1' and end_msg = '0') or (rd_en_vtr(1) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(6) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ1c >= occ2c and occ1c >= occ3c and occ1c >= occ4c and occ1c >= occ5c and occ1c >= occ6c and occ1c >= occ7c and occ1c >= occ8c)) else
--			--
--			"00000010" when (empty2 = '0') and ((rd_en_vtr(1) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(6) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ2c >= occ3c and occ2c >= occ4c and occ2c >= occ5c and occ2c >= occ6c and occ2c >= occ7c and occ2c >= occ8c)) else
--			--
--			"00000100" when (empty3 = '0') and ((rd_en_vtr(2) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(1) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(6) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ3c >= occ4c and occ3c >= occ5c and occ3c >= occ6c and occ3c >= occ7c and occ3c >= occ8c)) else
--			--
--			"00001000" when (empty4 = '0') and ((rd_en_vtr(3) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(1) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(6) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ4c >= occ5c and occ4c >= occ6c and occ4c >= occ7c and occ4c >= occ8c)) else
--			--
--			"00010000" when (empty5 = '0') and ((rd_en_vtr(4) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(1) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(6) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ5c >= occ6c and occ5c >= occ7c and occ5c >= occ8c)) else
--			--
--			"00100000" when (empty6 = '0') and ((rd_en_vtr(5) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(1) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(6) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ6c >= occ7c and occ6c >= occ8c)) else
--			--
--			"01000000" when (empty7 = '0') and ((rd_en_vtr(6) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(1) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(7) = '0' and
--					--
--					occ7c >= occ8c)) else
--			--
--			"10000000" when (empty8 = '0') and ((rd_en_vtr(7) = '1' and end_msg = '0') or (rd_en_vtr(0) = '0' and rd_en_vtr(1) = '0' and rd_en_vtr(2) = '0' and rd_en_vtr(3) = '0' and rd_en_vtr(4) = '0' and rd_en_vtr(5) = '0' and rd_en_vtr(6) = '0')) else "00000000";

--	available_buff1 <=
--		-- 
--		"111" when occ1 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ1 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ1 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ1 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ1 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ1 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ1 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ1 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff2 <=
--		-- 
--		"111" when occ2 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ2 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ2 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ2 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ2 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ2 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ2 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ2 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff3 <=
--		-- 
--		"111" when occ3 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ3 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ3 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ3 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ3 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ3 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ3 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ3 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff4 <=
--		-- 
--		"111" when occ4 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ4 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ4 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ4 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ4 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ4 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ4 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ4 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff5 <=
--		-- 
--		"111" when occ5 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ5 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ5 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ5 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ5 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ5 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ5 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ5 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff6 <=
--		-- 
--		"111" when occ6 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ6 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ6 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ6 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ6 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ6 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ6 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ6 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff7 <=
--		-- 
--		"111" when occ7 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ7 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ7 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ7 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ7 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ7 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ7 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ7 <= std_logic_vector(to_unsigned(63 + 0, 6));
--
--	available_buff8 <=
--		-- 
--		"111" when occ8 = std_logic_vector(to_unsigned(00 + 0, 6)) else
--		--
--		"110" when occ8 < std_logic_vector(to_unsigned(32 + 1, 6)) else
--		--
--		"101" when occ8 < std_logic_vector(to_unsigned(43 + 1, 6)) else
--		--
--		"100" when occ8 < std_logic_vector(to_unsigned(50 + 1, 6)) else
--		--
--		"011" when occ8 < std_logic_vector(to_unsigned(54 + 1, 6)) else
--		--
--		"010" when occ8 < std_logic_vector(to_unsigned(57 + 1, 6)) else
--		--
--		"001" when occ8 < std_logic_vector(to_unsigned(59 + 1, 6)) else
--		--
--		"000" when occ8 <= std_logic_vector(to_unsigned(63 + 0, 6));