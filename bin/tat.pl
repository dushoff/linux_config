s/<br>/\n/g;
s/&gt;/>/g;
s/&lt;/</g;
s/&nbsp;/ /g;
s/&amp;/&/g;
s|</?div>||g;
s|</?span[^>]*>|\n|g;
s/^[> ]*$//;
s/^[> ]*\n/\n/;
