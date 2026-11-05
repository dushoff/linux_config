## perl -p runs this once per input line, not on the whole file.
## But <br> and span substitutions below can put \n inside a record, so $ and ^ only match at the ends of the original line.
s/<br>/\n/g;
s/&gt;/>/g;
s/&lt;/</g;
s/&nbsp;/ /g;
s/&amp;/&/g;
s|</?div>||g;
s|</?span[^>]*>|\n|g;

## s/\n{3,}/\n\n/g;  # safety net: collapse any run of blank lines

s/^[>\s\\]*\n/\n/g;
s/\n[>\s\\]*$/\n/;
s/[\s\\]*$/\n/;
