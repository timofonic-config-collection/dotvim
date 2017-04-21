
# regitblame.pl

$previous_head = '';

while (<>) {

  $l = $_;

  /^([a-fA-F0-9]+) \((.+) (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) ([-+]\d{4}) (\s*\d+)\) (.+)?$/;
  $sha = $1;
  $author = substr($2, 0, 3);
  $date = $3;
  $lnum = $5;
  $line = $6;

  $date =~ s/[-: ]//g;
  $date = substr($date, 0, 12);

  $head = $sha . " " . $author . " " . $date;

  if ($head == $previous_head) {
    $head = sprintf("%" . length($head) . "s", " ");
  }
  else {
    $previous_head = $head;
  }

  print $head . " ";
  print $lnum;
  if (length($line) > 0) { print " " . $line; }
  print "\n";
}

