#!/usr/bin/env ruby
#
# Plotting application
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
require 'rgbplot'

class MainWindow < Qt::Dialog
  def change_function to_change, val
     begin
       f = eval ' lambda { |x| ' + val + ' } '
       @plotter.send to_change, f
       @plotter.repaint
     rescue SyntaxError
       # do nothing here, just omit
     end
  end

  def create_function_group
    Qt::GroupBox.new(self) do |gb|
      gb.title = 'Functions'

      @red   = Qt::LineEdit.new self
      @red.connect(SIGNAL('textChanged(QString)')) do |val|
        change_function :red=, val
      end

      @green = Qt::LineEdit.new self
      @green.connect(SIGNAL('textChanged(QString)')) do |val|
        change_function :green=, val
      end

      @blue  = Qt::LineEdit.new self
      @blue.connect(SIGNAL('textChanged(QString)')) do |val|
        change_function :blue=, val
      end

      gb.layout = Qt::FormLayout.new
      gb.layout.addRow 'Red',   @red
      gb.layout.addRow 'Green', @green
      gb.layout.addRow 'Blue',  @blue
    end
  end

  def create_layout
    self.layout = Qt::VBoxLayout.new do |layout|
      @plotter = RGBPlot.new ARGV[0].to_i..ARGV[1].to_i, self

      layout.addWidget @plotter, 1
      layout.addWidget create_function_group

      @red.text   = 'x % 255'
      @green.text = '(2*x) % 255'
      @blue.text  = '(5*x) % 255'
    end
  end

  def initialize(parent = nil)
    super parent

    create_layout
  end
end

if(ARGV.length < 2) then
  print %{
    usage: ./plotter.rb min max
  }

  exit 1
end

app = Qt::Application.new(ARGV)
window = MainWindow.new
window.minimumWidth = 483 # of course it is golden ratio
window.minimumHeight = 300
window.show
app.exec

