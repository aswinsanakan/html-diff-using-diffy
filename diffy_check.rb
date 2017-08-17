require 'diffy'
#Needs diffy gem

s1 = File.read("html-1.html") + "\n"
s2 = File.read("html-2.html") + "\n"

d = Diffy::SplitDiff.new(s1,s2)
left = d.left
right = d.right

dleft = left.split("\n").map do |line|
  if line[0] == '+'
    "<div class='ins'>#{line[1..-1]}</div>"
  elsif line[0] == '-'
    "<div class='del'>#{line[1..-1]}</div>"
  else
    "#{line[1..-1]}"
  end
end
dleft = dleft.join("\n")

dright = right.split("\n").map do |line|
  if line[0] == '+'
    "<div class='ins'>#{line[1..-1]}</div>"
  elsif line[0] == '-'
    "<div class='del'>#{line[1..-1]}</div>"
  else
    "#{line[1..-1]}"
  end
end
dright = dright.join("\n")

styles = "<style>\n.ins {background:#dfd; color:#080}\n.del {background:#fee; color:#b00}\n</style>"

doutput = dleft + "\n\n\n" + "++++++++++++++++" + "\n\n\n" + dright + "\n" + styles

File.write("diff-output.html",doutput)