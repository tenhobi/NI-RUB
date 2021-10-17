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
    alphabet = Array('a'..'z')
    encryptor = Hash[alphabet.zip(alphabet.rotate(shift))]
    output what.chars.reduce(''){|memo, c|
      if /[^[:alpha:]]/.match(c)
        memo + c
      else
        is_upper = /[[:upper:]]/.match(c)
        encrypted_c = encryptor[c.downcase].to_s
        memo + (is_upper ? encrypted_c.upcase : encrypted_c)
      end
    }
  end
end
