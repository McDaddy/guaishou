#!/usr/bin/env ruby

str = ''
File.open("cards.md", 'r') do |f|
  str = f.read
end

str = str.gsub(/^###\s?(.*?)\s?$/, "<h3>\\1</h3>\n").
  gsub(/^任务：\s?(.*?)\n$/, "<div class=\"card\">\n<h3>\\1</h3>\n<ul>").
  gsub(/^\-\s+baidu:\s?(.*?)$/, "</ul>\n<a href='\\1'>视频</a>\n</div>").
  gsub(/^\-\s+id: \s?(.*?)$/, "<div class='id'>\\1</div>").
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
