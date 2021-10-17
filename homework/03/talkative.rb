# Requires method `output(text)`.
module Talkative
  def shout(what)
    output what.upcase
  end

  def whisper(what)
    output what.downcase
  end

  # inspiration: https://gist.github.com/matugm/db363c7131e6af27716c
  def encrypt(what, shift = 3)
    encryptor = Hash[Array('a'..'z').zip(Array('a'..'z').rotate(shift)) + Array('A'..'Z').zip(Array('A'..'Z').rotate(shift))]
    output what.chars.reduce('') { |memo, c|
      if /[^[:alpha:]]/.match(c)
        memo + c
      else
        memo + encryptor[c].to_s
      end
    }
  end
end
