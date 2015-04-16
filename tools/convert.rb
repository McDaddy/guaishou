#!/usr/bin/env ruby

str = ''
File.open("tools/cards.md", 'r') do |f|
  str = f.read
end


# 上面的 gsub 先执行，执行完了就交给下一行做替换，替换后的内容再交给下一行的 gsub，顺序相关的

str = str.gsub(/^###\s?(.*?)\s?$/, "<h3>\\1</h3>\n").
  gsub(/^任务：\s?(.*?)\n$/, "<div class=\"card\">\n<h3>\\1</h3>\n<ul>").
  gsub(/^\-\s+baidu:\s?(.*?)$/, "</ul>\n<a class=\"video\" href='\\1'>视频</a>\n</div>").
  gsub(/^\-\s+id: \s?(.*?)$/, "<a href=\"\#\\1\" class='id' id=\"\\1\">\\1</a>").
  gsub(/^\-\s?(.*?)$/, "<li>\\1</li>")



front = <<HEREDOC
---
title: 小白变怪兽
---

HEREDOC

File.open("index.md", 'w') do |f|
  f.write(front)
end

File.open("index.md", 'a') do |f|
  f.write(str)
end


system 'git add -A&&git commit -m"i"&&git push'
system 'echo "deploy new stuff"'
system 'ssh peter@happyec.org "source .profile &&/home/peter/bin/ggg.sh"'

