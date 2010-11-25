#!/usr/bin/env ruby

require 'rubygems'
require 'Qt4'


class RGBPlot < Qt::Widget
  def paintEvent(e)
    x = @from
    fstep = (@to - @from) / width.to_f

    painter = Qt::Painter.new self

    (0...width).each do |i|
      painter.pen = Qt::Pen.new { |p|
        p.width = 1;
        p.color = Qt::Color.new red[x], green[x], blue[x]
      }
      painter.drawLine i, 0, i, height - 1

      x += fstep
    end

    painter.end
  end

  def initialize(from, to, parent = nil)
    super parent

    @from = from
    @to   = to
  end

  attr_accessor :red, :green, :blue
end

app = Qt::Application.new(ARGV)
window = Qt::MainWindow.new do |w|
  widget = RGBPlot.new -10, 45

  widget.red   = lambda { |x| 128 + 128 * Math.sin(x + 10) }
  widget.green = lambda { |x| 128 + 128 * Math.sin((x + 10)/10) }
  widget.blue  = lambda { |x| 128 + 128 * Math.sin((x + 10)/2) }

  w.centralWidget = widget
end

window.show
app.exec
