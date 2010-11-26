#!/usr/bin/env ruby
#
# Widget for plotting
#
# Copyright (c) 2010 Peter Parkanyi <me@rhapsodhy.hu>.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
require 'rubygems'
require 'Qt4'

class RGBPlot < Qt::Widget
  def paintEvent(e)
    painter = Qt::Painter.new self
    x = @value_range.step((@value_range.count - 1) / width.to_f).to_a

    (0...width).each do |i|
      painter.pen = Qt::Pen.new { |p|
        p.width = 1;
        p.color = Qt::Color.new red[x[i]], green[x[i]], blue[x[i]]
      }
      painter.drawLine i, 0, i, height - 1
    end

    painter.end
  end

  def initialize(value_range, parent = nil)
    super parent

    @value_range = value_range
    self.minimumHeight = 50
  end

  attr_accessor :red, :green, :blue, :value_range
end

