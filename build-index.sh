#! /bin/bash

updated_at=`TZ="Asia/Tokyo" date "+%Y/%m/%d %H:%M"`

cat << HTML > index.html
<!DOCTYPE html>
<html lang="ja-JP">
<head>
  <meta charset="utf-8">
  <title>PRESENTATIONS</title>
  <link rel="stylesheet" href="./style.css">
  <meta name="viewport" content="width=device-width">
  <script type="text/javascript" id="mierucaOptimizejs">
    window.__optimizeid = window.__optimizeid || [];__optimizeid.push([1294360604]);
    (function () {var fjs = document.createElement('script');fjs.type = 'text/javascript';
    fjs.async = true;fjs.id = "fjssync";var timestamp = new Date;fjs.src = 'https://dev.opt.mieru-ca.com/service/js/mieruca-optimize-dev.js?v=' + timestamp.getTime();
    var x = document.getElementsByTagName('script')[0];x.parentNode.insertBefore(fjs, x);})();
  </script>
</head>
<body>
<h1>プレゼンテーションアーカイブ</h1>
<ul>
  <li id="profile">
    <a href="https://github.com/${GITHUB_ACTOR}" target="_blank">
      <img src="https://github.com/${GITHUB_ACTOR}.png" alt="" width="100" height="100">
      <b>${GITHUB_ACTOR}</b> updated this page at $updated_at
    </a>


    <img id="build-status" src="https://github.com/${GITHUB_REPOSITORY}/actions/workflows/index.yml/badge.svg?branch=master"
      alt="Index build status">
  </li>
HTML

IFS=$'\n'

for file in `ls -r *.md | sed -e "s/.md//g"`; do
  title=`grep "title:" $file.md | cut -f2 -d":" | xargs`

  if ! grep -q "private:" $file.md ; then
    echo -e "$file\t\t$title"
    cat << HTML >> index.html
  <li>
    <a href="./$file.html" target="_blank">$title</a>
    <span>
      [<a href="./$file.md" target="_blank">markdown</a>]
      [<a href="./$file.pdf" target="_blank">PDF</a>]
    </span>
  </li>
HTML
  else
    echo -e "$file*\t\t$title"
  fi
done

echo << HTML >> index.html
</ul>
</body>
</html>
HTML