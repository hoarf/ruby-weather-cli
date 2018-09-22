class Weather::Presenter

  def initialize(reporter)
    @reporter = reporter
  end

  def max() present_float(@reporter.max) end

  def min() present_float(@reporter.min) end

  def today_max() present_float(@reporter.today_max) end

  def today_min() present_float(@reporter.today_min) end

  private

  def present_float(float) "#{'%0.2f' % float}" end
end
