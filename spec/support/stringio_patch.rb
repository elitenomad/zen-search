# frozen_string_literal: true

# Had to add this fix as i was testing `tty-prompt` output in the specs/
# https://github.com/piotrmurach/tty-screen/issues/11

require "stringio"

unless StringIO.method_defined? :ioctl
  class StringIO
    def ioctl(*)
      80
    end
  end
end

unless StringIO.method_defined? :wait_readable
  class StringIO
    def wait_readable(*)
      true
    end
  end
end
