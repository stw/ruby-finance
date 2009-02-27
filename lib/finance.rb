require 'bigdecimal'

module Finance

  # :stopdoc:
  VERSION = '1.0.0'
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    VERSION
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args )
    args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args )
    args.empty? ? PATH : ::File.join(PATH, args.flatten)
  end

  # Utility method used to require all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end

  class Calculate

    def present_value(amount, rate = 0.06, timeframe = 1)
      round(BigDecimal.new((amount / (1 + rate) ** timeframe).to_s))
    end

    def future_value(amount, rate = 0.06, timeframe = 1)
      round(BigDecimal.new((amount * (1 + rate) ** timeframe).to_s))
    end

    def cagr(current_amount, future_amount, timeframe) 
      BigDecimal.new((((future_amount / current_amount) ** (1 / timeframe.to_f)) - 1).to_s)
    end

    def mortgage_payment(amount, rate = 0.06, timeframe = 15)
      monthly_rate = rate / 12
      payment = (monthly_rate / (1 - (1 + monthly_rate) ** (-timeframe * 12))) * amount
      round(BigDecimal.new(payment.to_s))
    end

    def round(amount, precision = 2)
      amount.round(precision).to_f
    end

  end

end  # module Finance

Finance.require_all_libs_relative_to(__FILE__)

# EOF
