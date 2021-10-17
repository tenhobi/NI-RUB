require_relative 'talkative'
require_relative 'validations'

class Robot
  include Comparable
  include Talkative
  prepend Validations

  attr_reader :name

  def initialize(name)
    @name = name
    @arms = []
  end

  def add_arms(*params)
    _arms = params.flatten
    _arms.each do |param|
      unless param.is_a? Arm
        raise 'Hoopsie, this is not an arm.'
      end
    end

    @arms += _arms
  end

  def introduce
    output "My name is #{@name} and I have these arms:\n" + _output_arms
  end

  def output(input)
    puts input
  end

  def <=>(other)
    _count_score <=> other._count_score
  end

  protected

  def _output_arms
    aggregation = @arms.group_by { |arm| arm.type }.map { |key, value| [key, value.size] }
    aggregation.reduce('') do |memo, type|
      memo + "#{type[1]} arms of type #{type[0].to_s}\n"
    end
  end

  def _count_score
    score_sum = 0
    len_sum = 0

    @arms.each do |arm|
      len_sum += arm.length

      case arm.type
      when :poker
        score_sum += 1
      when :slasher
        score_sum += 3
      when :grabber
        score_sum += 5
      else
        raise 'wrong type of arm'
      end
    end

    avg_len = @arms.size == 0 ? len_sum : len_sum / @arms.size

    score_sum + avg_len
  end
end
