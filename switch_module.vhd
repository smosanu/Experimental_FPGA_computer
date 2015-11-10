library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.switch_functions.all;

entity switch_module is
	port(
		-- 8 pins in
		input1  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input2  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input3  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input4  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input5  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input6  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input7  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		input8  : in  std_logic_vector(WIDTH + 1 - 1 downto 0);
		-- 8 pins out
		output1 : out std_logic_vector(WIDTH - 1 downto 0);
		output2 : out std_logic_vector(WIDTH - 1 downto 0);
		output3 : out std_logic_vector(WIDTH - 1 downto 0);
		output4 : out std_logic_vector(WIDTH - 1 downto 0);
		output5 : out std_logic_vector(WIDTH - 1 downto 0);
		output6 : out std_logic_vector(WIDTH - 1 downto 0);
		output7 : out std_logic_vector(WIDTH - 1 downto 0);
		output8 : out std_logic_vector(WIDTH - 1 downto 0);
		-- availability outputs
		-- 1 to others
		almost_full_1to2 : out std_logic;
		almost_full_1to3 : out std_logic;
		almost_full_1to4 : out std_logic;
		almost_full_1to5 : out std_logic;
		almost_full_1to6 : out std_logic;
		almost_full_1to7 : out std_logic;
		almost_full_1to8 : out std_logic;
		-- 2 to others
		almost_full_2to1 : out std_logic;
		almost_full_2to3 : out std_logic;
		almost_full_2to4 : out std_logic;
		almost_full_2to5 : out std_logic;
		almost_full_2to6 : out std_logic;
		almost_full_2to7 : out std_logic;
		almost_full_2to8 : out std_logic;
		-- 3 to others
		almost_full_3to1 : out std_logic;
		almost_full_3to2 : out std_logic;
		almost_full_3to4 : out std_logic;
		almost_full_3to5 : out std_logic;
		almost_full_3to6 : out std_logic;
		almost_full_3to7 : out std_logic;
		almost_full_3to8 : out std_logic;
		-- 4 to others
		almost_full_4to1 : out std_logic;
		almost_full_4to2 : out std_logic;
		almost_full_4to3 : out std_logic;
		almost_full_4to5 : out std_logic;
		almost_full_4to6 : out std_logic;
		almost_full_4to7 : out std_logic;
		almost_full_4to8 : out std_logic;
		-- 5 to others
		almost_full_5to1 : out std_logic;
		almost_full_5to2 : out std_logic;
		almost_full_5to3 : out std_logic;
		almost_full_5to4 : out std_logic;
		almost_full_5to6 : out std_logic;
		almost_full_5to7 : out std_logic;
		almost_full_5to8 : out std_logic;
		-- 6 to others
		almost_full_6to1 : out std_logic;
		almost_full_6to2 : out std_logic;
		almost_full_6to3 : out std_logic;
		almost_full_6to4 : out std_logic;
		almost_full_6to5 : out std_logic;
		almost_full_6to7 : out std_logic;
		almost_full_6to8 : out std_logic;
		-- 7 to others
		almost_full_7to1 : out std_logic;
		almost_full_7to2 : out std_logic;
		almost_full_7to3 : out std_logic;
		almost_full_7to4 : out std_logic;
		almost_full_7to5 : out std_logic;
		almost_full_7to6 : out std_logic;
		almost_full_7to8 : out std_logic;
		-- 8 to others
		almost_full_8to1 : out std_logic;
		almost_full_8to2 : out std_logic;
		almost_full_8to3 : out std_logic;
		almost_full_8to4 : out std_logic;
		almost_full_8to5 : out std_logic;
		almost_full_8to6 : out std_logic;
		almost_full_8to7 : out std_logic;
		-- clock and reset
		clk     : in  std_logic;
		rst     : in  std_logic
	);
end entity switch_module;

architecture RTL of switch_module is

	-- a ground signal
	constant level_zero  : std_logic_vector(WIDTH + 1 - 1 + 0 downto 0) := (others => '0');
	-- signals connecting the MuXs
	signal connector1to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector1to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector1to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector1to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector1to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector1to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector1to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');

	signal connector2to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');

	-- connecting XtoX
	signal connector1to1 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector2to2 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector3to3 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector4to4 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector5to5 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector6to6 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector7to7 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');
	signal connector8to8 : std_logic_vector(WIDTH + 1 - 1 + 1 downto 0) := (others => '0');

begin
	DUT1 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input1,
			ouput => output1,
			-- MuX in
			in1   => level_zero,
			in2   => connector2to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => connector3to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => connector4to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => connector5to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => connector6to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => connector7to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => connector8to1(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector1to1,
			ou2   => connector1to2,
			ou3   => connector1to3,
			ou4   => connector1to4,
			ou5   => connector1to5,
			ou6   => connector1to6,
			ou7   => connector1to7,
			ou8   => connector1to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_1to2 <= connector2to1(0);
	almost_full_1to3 <= connector3to1(0);
	almost_full_1to4 <= connector4to1(0);
	almost_full_1to5 <= connector5to1(0);
	almost_full_1to6 <= connector6to1(0);
	almost_full_1to7 <= connector7to1(0);
	almost_full_1to8 <= connector8to1(0);

	DUT2 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input2,
			ouput => output2,
			-- MuX in
			in1   => connector1to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => level_zero,
			in3   => connector3to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => connector4to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => connector5to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => connector6to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => connector7to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => connector8to2(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector2to1,
			ou2   => connector2to2,
			ou3   => connector2to3,
			ou4   => connector2to4,
			ou5   => connector2to5,
			ou6   => connector2to6,
			ou7   => connector2to7,
			ou8   => connector2to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_2to1 <= connector1to2(0);
	almost_full_2to3 <= connector3to2(0);
	almost_full_2to4 <= connector4to2(0);
	almost_full_2to5 <= connector5to2(0);
	almost_full_2to6 <= connector6to2(0);
	almost_full_2to7 <= connector7to2(0);
	almost_full_2to8 <= connector8to2(0);

	DUT3 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input3,
			ouput => output3,
			-- MuX in
			in1   => connector1to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => connector2to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => level_zero,
			in4   => connector4to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => connector5to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => connector6to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => connector7to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => connector8to3(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector3to1,
			ou2   => connector3to2,
			ou3   => connector3to3,
			ou4   => connector3to4,
			ou5   => connector3to5,
			ou6   => connector3to6,
			ou7   => connector3to7,
			ou8   => connector3to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_3to1 <= connector1to3(0);
	almost_full_3to2 <= connector2to3(0);
	almost_full_3to4 <= connector4to3(0);
	almost_full_3to5 <= connector5to3(0);
	almost_full_3to6 <= connector6to3(0);
	almost_full_3to7 <= connector7to3(0);
	almost_full_3to8 <= connector8to3(0);

	DUT4 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input4,
			ouput => output4,
			-- MuX in
			in1   => connector1to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => connector2to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => connector3to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => level_zero,
			in5   => connector5to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => connector6to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => connector7to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => connector8to4(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector4to1,
			ou2   => connector4to2,
			ou3   => connector4to3,
			ou4   => connector4to4,
			ou5   => connector4to5,
			ou6   => connector4to6,
			ou7   => connector4to7,
			ou8   => connector4to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_4to1 <= connector1to4(0);
	almost_full_4to2 <= connector2to4(0);
	almost_full_4to3 <= connector3to4(0);
	almost_full_4to5 <= connector5to4(0);
	almost_full_4to6 <= connector6to4(0);
	almost_full_4to7 <= connector7to4(0);
	almost_full_4to8 <= connector8to4(0);

	DUT5 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input5,
			ouput => output5,
			-- MuX in
			in1   => connector1to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => connector2to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => connector3to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => connector4to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => level_zero,
			in6   => connector6to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => connector7to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => connector8to5(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector5to1,
			ou2   => connector5to2,
			ou3   => connector5to3,
			ou4   => connector5to4,
			ou5   => connector5to5,
			ou6   => connector5to6,
			ou7   => connector5to7,
			ou8   => connector5to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_5to1 <= connector1to5(0);
	almost_full_5to2 <= connector2to5(0);
	almost_full_5to3 <= connector3to5(0);
	almost_full_5to4 <= connector4to5(0);
	almost_full_5to6 <= connector6to5(0);
	almost_full_5to7 <= connector7to5(0);
	almost_full_5to8 <= connector8to5(0);

	DUT6 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input6,
			ouput => output6,
			-- MuX in
			in1   => connector1to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => connector2to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => connector3to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => connector4to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => connector5to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => level_zero,
			in7   => connector7to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => connector8to6(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector6to1,
			ou2   => connector6to2,
			ou3   => connector6to3,
			ou4   => connector6to4,
			ou5   => connector6to5,
			ou6   => connector6to6,
			ou7   => connector6to7,
			ou8   => connector6to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_6to1 <= connector1to6(0);
	almost_full_6to2 <= connector2to6(0);
	almost_full_6to3 <= connector3to6(0);
	almost_full_6to4 <= connector4to6(0);
	almost_full_6to5 <= connector5to6(0);
	almost_full_6to7 <= connector7to6(0);
	almost_full_6to8 <= connector8to6(0);

	DUT7 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input7,
			ouput => output7,
			-- MuX in
			in1   => connector1to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => connector2to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => connector3to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => connector4to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => connector5to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => connector6to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => level_zero,
			in8   => connector8to7(WIDTH + 1 - 1 + 1 downto 0 + 1),
			-- MuX out
			ou1   => connector7to1,
			ou2   => connector7to2,
			ou3   => connector7to3,
			ou4   => connector7to4,
			ou5   => connector7to5,
			ou6   => connector7to6,
			ou7   => connector7to7,
			ou8   => connector7to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_7to1 <= connector1to7(0);
	almost_full_7to2 <= connector2to7(0);
	almost_full_7to3 <= connector3to7(0);
	almost_full_7to4 <= connector4to7(0);
	almost_full_7to5 <= connector5to7(0);
	almost_full_7to6 <= connector6to7(0);
	almost_full_7to8 <= connector8to7(0);

	DUT8 : entity work.MuX_DeMuX(RTL)
		port map(
			-- Sending MUX 1+7 pins
			input => input8,
			ouput => output8,
			-- MuX in
			in1   => connector1to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in2   => connector2to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in3   => connector3to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in4   => connector4to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in5   => connector5to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in6   => connector6to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in7   => connector7to8(WIDTH + 1 - 1 + 1 downto 0 + 1),
			in8   => level_zero,
			-- MuX out
			ou1   => connector8to1,
			ou2   => connector8to2,
			ou3   => connector8to3,
			ou4   => connector8to4,
			ou5   => connector8to5,
			ou6   => connector8to6,
			ou7   => connector8to7,
			ou8   => connector8to8,
			-- clock and reset
			clk   => clk,
			rst   => rst
		);

	-- availability outputs
	almost_full_8to1 <= connector1to8(0);
	almost_full_8to2 <= connector2to8(0);
	almost_full_8to3 <= connector3to8(0);
	almost_full_8to4 <= connector4to8(0);
	almost_full_8to5 <= connector5to8(0);
	almost_full_8to6 <= connector6to8(0);
	almost_full_8to7 <= connector7to8(0);

end RTL;