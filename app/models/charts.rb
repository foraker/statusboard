class Charts

  def initialize(type, size)
    self.g = eval "Gruff::#{type}.new(#{size})"
    g.font = '/Library/Fonts/Verdana.ttf'
    new_graph
  end

  def new_graph
    #datasets = [[0,1],[2,3], [4,3], [5,6]]
    g.title = "Github Commits"
    datasets = [
        [:first0, [0, 5, 10, 8, 18]],
        [:normal, [1, 2, 3, 4, 5]]
    ]
    datasets.each do |data|

      g.data(data[0], data[1])
    end
    g.write("app/assets/images/mygraph.jpg")
  end

  attr_accessor :g
end
