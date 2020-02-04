class Wish
  def initialize(node)
    @text = node.text.strip!
    @date = Date.parse(node.attributes['date'])
  end

  # метод возвращает true если желание испольнилось
  def overdue?
    @date < Date.today
  end

  # метод для вывода желания на экран
  def to_s
    "#{@date.strftime('%d.%m.%Y')}: #{@text}"
  end
end