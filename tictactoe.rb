class TicTacToe
  def initialize
    @p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9 = blank_spaces
    @squares = [@p1, @p2, @p3, @p4, @p5, @p6, @p7, @p8, @p9]
    @f_player = ''
    @s_player = ''
    @moves = 0
  end

  def blank_spaces
    [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  end

  def posibble_combinantions
    [
      [@p1, @p2, @p3],
      [@p1, @p5, @p9],
      [@p1, @p4, @p7],
      [@p4, @p5, @p6],
      [@p7, @p8, @p9],
      [@p7, @p5, @p3],
      [@p2, @p5, @p8],
      [@p3, @p6, @p9]
    ]
  end

  def print_board
    system 'clear'
    puts "
      GUIDE        GAME
    1 | 2 | 3    #{@p1} | #{@p2} | #{@p3}
    --|---|--    --|---|--
    4 | 5 | 6    #{@p4} | #{@p5} | #{@p6}
    --|---|--    --|---|--
    7 | 8 | 9    #{@p7} | #{@p8} | #{@p9}"
  end

  def empty?(val)
    if val == ' '
      true
    else
      puts 'SPACE IS TAKEN 😰 '
    end
  end

  def quit?(choice)
    exit unless choice != 'q'
  end

  def position(user_emoji)
    selected_position = 9

    puts "-----  Player #{user_emoji}   -----"
    until selected_position.between?(0, 8) && empty?(@squares[selected_position])
      print 'Choose an square: [1-9] or press q to quit: '
      selected_position = gets.chomp
      quit?(selected_position)
      selected_position = selected_position.to_i - 1
    end

    selected_position
  end

  def user_turn(user_emoji)
    index = position(user_emoji)

    @squares[index].sub!(' ', user_emoji)
    print_board
    @moves += 1
    winner
  end

  def run
    print_board
    loop do
      user_turn(@f_player)
      if @s_player == '🤖'
        computer
      else
        user_turn(@s_player)
      end
    end
  end

  def computer
    empty_squares = @squares.each_index.select { |i| @squares[i] == ' ' }

    @squares[empty_squares.sample].sub!(' ', '🤖')

    print_board
    @moves += 1
    winner
  end

  def same_value?(arr, user_emoji)
    arr.all? { |value| value == user_emoji }
  end

  def tie?
    return unless @moves == 9
    puts 'Tie!!!!'
    exit
  end

  def winner
    posibble_combinantions.each do |combos|
      if same_value?(combos, @f_player)
        puts "#{@f_player}  wins 🎊"
        exit
      elsif same_value?(combos, @s_player)
        puts "#{@s_player}  wins 🎊"
        exit
      end
    end
    tie?
  end

  def players_emojis
    print 'First Player, choose an emoji: '
    @f_player = gets.chomp
    print 'Second Player, choose an emoji: '
    @s_player = gets.chomp
  end

  def start
    puts '❌ ⭕️ Game ❌ ⭕️ '
    players_emojis
    run
  end
end

game = TicTacToe.new
game.start
