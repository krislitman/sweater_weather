class Job
  attr_reader :title,
              :min,
              :max

  def initialize(data)
    @title = data[:job][:title]
    @min = normalize_salary(data[:salary_percentiles], :percentile_25)
    @max = normalize_salary(data[:salary_percentiles], :percentile_75)
  end

  def normalize_salary(data, percentile)
    salary = data[percentile].floor(2).to_s.prepend('$')
    if salary.length == 9
      salary.chars.insert(3,',').join("")
    elsif salary.length == 10
      salary.chars.insert(4,',').join("")
    elsif salary.length == 8
      salary.chars.insert(3,',').join("").concat('0')
    end
  end
end