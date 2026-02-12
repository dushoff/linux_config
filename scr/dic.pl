s/\s*new paragraph\s*/\n\n/gi;
s/(\.\s*)([a-z])/$1\U$2/g;
s/^\s([a-zA-Z])/\U$1/;
s/mcmaster/McMaster/;
s/\s*No paragraph\s*/\n\n/g;
