## This is running on file, not lines. Probably for some good reason but it makes the logic a bit confusing.
s/<br>/\n/g;
s/&gt;/>/g;
s/&lt;/</g;
s/&nbsp;/ /g;
s/&amp;/&/g;
s|</?div>||g;
s|</?span[^>]*>|\n|g;

## s/\n{3,}/\n\n/g;  # safety net: collapse any run of blank lines

s/^[>\s\\]*\n/\n/g;
s/[>\s\\]*$/\n/;
