#!/usr/bin/env ruby

require 'rubygems'
require 'Qt4'


class Widget < Qt::Widget
  Start = -10
  End = 45

  def rf(x); 128 + 128 * Math.sin(x + 10); end
  def gf(x); 128 + 128 * Math.sin((x + 10)/10); end
  def bf(x); 128 + 128 * Math.sin((x + 10)/2); end

  def paintEvent(e)
    x = Start
    fstep = (End - Start) / width.to_f

    puts fstep
    painter = Qt::Painter.new self

    (0...width).each do |i|
      painter.pen = Qt::Pen.new { |p|
        p.width = 1;
        p.color = Qt::Color.new rf(x), gf(x), bf(x)
      }
      painter.drawLine i, 0, i, height - 1

      x += fstep
    end
  end
end

app = Qt::Application.new(ARGV)
window = Qt::MainWindow.new
window.centralWidget = Widget.new

window.show
app.exec
