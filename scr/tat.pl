## Not remembering why I'm dealing with \n here instead of abstracting
## Something is confusing, but I should have made notes to myself.
## Could ask Claude.
s/<br>/\n/g;
s/&gt;/>/g;
s/&lt;/</g;
s/&nbsp;/ /g;
s/&amp;/&/g;
s|</?div>||g;
s|</?span[^>]*>|\n|g;
s/^[>\s\\]*\n/\n/g;
s/[>\s\\]*$/\n/g;
