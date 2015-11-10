library ieee;
use ieee.std_logic_1164.all;

entity test_BUFF is
end entity test_BUFF;

architecture RTL of test_BUFF is
	component fifo_19_64
		port(
			clk   : in  std_logic;
			srst  : in  std_logic;
			din   : in  std_logic_vector(18 DOWNTO 0);
			wr_en : in  std_logic;
			rd_en : in  std_logic;
			dout  : out std_logic_vector(18 DOWNTO 0);
			full  : out std_logic;
			empty : out std_logic
		);
	end component fifo_19_64;

	constant full_period : time    := 10 ns;

	signal clk   : std_logic := '0';
	signal srst  : std_logic := '1';
	signal din   : std_logic_vector(18 DOWNTO 0) := (others => '0');
	signal wr_en : std_logic := '0';
	signal rd_en : std_logic := '0';
	signal dout  : std_logic_vector(18 DOWNTO 0) := (others => '0');
	signal full  : std_logic := '0';
	signal empty : std_logic := '0';
begin
	-- set reset to 0
	srst  <= '1', '0' after full_period;

	-- make the clock
	Clock : process
	begin
		clk <= not clk;
		wait for full_period / 2;
	end process;

	-- test with some inputs
	testing : process
	begin
		wait for full_period;
		wr_en <= '1';
		rd_en <= '0';
		din <= "1111111110000000000";
		wait for full_period;
		din <= "0000000001111111111";
		wait for full_period;
		din <= "1111111110000000000";
		wait for full_period;
		din <= "0000000001111111111";
		--rd_en <= '1';
		wait for full_period;
		din <= "1110001110001110000";
		wait for full_period;
		din <= "1000111000111001111";
		rd_en <= '1';
		wait for full_period;
		din <= "1111111110000000000";
		wait for full_period;
		wr_en <= '0';
		din <= "0000000000000000000";
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		rd_en <= '0';
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		wait for full_period;
		assert 1 = 0 report "1desired_end" severity failure;
	end process;

	-- Design Under Test
	DUT : fifo_19_64
		port map(
			clk   => clk,
			srst  => srst,
			din   => din,
			wr_en => wr_en,
			rd_en => rd_en,
			dout  => dout,
			full  => full,
			empty => empty
		);

end architecture RTL;
