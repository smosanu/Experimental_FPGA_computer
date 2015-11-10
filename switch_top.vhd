library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;
use work.switch_functions.all;

entity switch_top is
	port(
		USER_CLOCK : in  STD_LOGIC;
		RESET      : in  STD_LOGIC;
		GPIO_LED_0 : out std_logic;
		GPIO_LED_1 : out std_logic;
		GPIO_LED_2 : out std_logic;
		GPIO_LED_3 : out std_logic
	);
end entity switch_top;

architecture RTL of switch_top is
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

	signal led_count : unsigned(26 downto 0) := (others => '0');

	signal sum1 : std_logic := '0';
	signal sum2 : std_logic := '0';
	signal sum3 : std_logic := '0';
	signal sum4 : std_logic := '0';
	signal sum5 : std_logic := '0';
	signal sum6 : std_logic := '0';
	signal sum7 : std_logic := '0';
	signal sum8 : std_logic := '0';

	signal osm1 : std_logic := '0';
	signal osm2 : std_logic := '0';
	signal osm3 : std_logic := '0';
	signal osm4 : std_logic := '0';
	signal osm5 : std_logic := '0';
	signal osm6 : std_logic := '0';
	signal osm7 : std_logic := '0';
	signal osm8 : std_logic := '0';

	-- declare the testing state machine types
	type input_sm_type is (idle, stageI, stageA, stageB, stageC, stageD, stageX);
	-- state variable
	signal input_sm : input_sm_type;

begin
	sum1 <= or_reduce(input1);
	sum2 <= or_reduce(input2);
	sum3 <= or_reduce(input3);
	sum4 <= or_reduce(input4);
	sum5 <= or_reduce(input5);
	sum6 <= or_reduce(input6);
	sum7 <= or_reduce(input7);
	sum8 <= or_reduce(input8);

	osm1 <= or_reduce(output1);
	osm2 <= or_reduce(output2);
	osm3 <= or_reduce(output3);
	osm4 <= or_reduce(output4);
	osm5 <= or_reduce(output5);
	osm6 <= or_reduce(output6);
	osm7 <= or_reduce(output7);
	osm8 <= or_reduce(output8);

	-- state machine implementation
	input_p : process(USER_CLOCK)
	begin
		if (rising_edge(USER_CLOCK)) then
			if (RESET = '1') then       -- reset signals
				input_sm <= idle;
			else
				case input_sm is
					when idle =>
						input1   <= (others => '0');
						input2   <= (others => '0');
						input3   <= (others => '0');
						input4   <= (others => '0');
						input5   <= (others => '0');
						input6   <= (others => '0');
						input7   <= (others => '0');
						input8   <= (others => '0');
						input_sm <= stageI;
					when stageI =>
						input1   <= "1000000000000000000";
						input2   <= "1001000100000000000";
						input3   <= "1010001000000000000";
						input4   <= "1011001100000000000";
						input5   <= "1100010000000000000";
						input6   <= "1101010100000000000";
						input7   <= "1110011000000000000";
						input8   <= "1111011100000000000";
						input_sm <= stageA;
					when stageA =>
						input1   <= "1000000000000000100";
						input2   <= "1001000100000001000";
						input3   <= "1010001000000001100";
						input4   <= "1011001100000010000";
						input5   <= "1100010000000010100";
						input6   <= "1101010100000011000";
						input7   <= "1110011000000011100";
						input8   <= "1111011100000000000";
						input_sm <= stageB;
					when stageB =>
						input_sm <= stageC;
					when stageC =>
						input_sm <= stageD;
					when stageD =>
						input1   <= "1111111111111111110";
						input2   <= "1111111111111111110";
						input3   <= "1111111111111111110";
						input4   <= "1111111111111111110";
						input5   <= "1111111111111111110";
						input6   <= "1111111111111111110";
						input7   <= "1111111111111111110";
						input8   <= "1111111111111111110";
						input_sm <= stageX;
					when stageX =>
						input1   <= "1000000000000000101";
						input2   <= "1001000100000001001";
						input3   <= "1010001000000001101";
						input4   <= "1011001100000010001";
						input5   <= "1100010000000010101";
						input6   <= "1101010100000011001";
						input7   <= "1110011000000011101";
						input8   <= "1111011100000000001";
						input_sm <= idle;
				end case;
			end if;
		end if;
	end process;

	process(USER_CLOCK)
	begin
		if USER_CLOCK = '1' and USER_CLOCK'event then
			if (RESET = '1') then
				led_count <= (others => '0');
			else
				led_count <= led_count + 1;
			end if;
		end if;
	end process;

	GPIO_LED_0 <= led_count(26);        -- connects led outputs to counter value
	GPIO_LED_1 <= led_count(25);        -- connects led outputs to counter value
	GPIO_LED_2 <= osm1 or osm2 or osm3 or osm4 or osm5 or osm6 or osm7 or osm8;
	GPIO_LED_3 <= sum1 or sum2 or sum3 or sum4 or sum5 or sum6 or sum7 or sum8;

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
			clk     => USER_CLOCK,
			rst     => RESET
		);
end architecture RTL;
